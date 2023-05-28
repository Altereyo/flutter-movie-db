import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/data/models/movie.dart';
import 'package:flutter_movie_db/data/models/movie_route_args.dart';
import 'package:flutter_movie_db/data/services/imdb_service.dart';
import 'package:get/get.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final ImdbService imdbService = Get.find<ImdbService>();

  MovieBloc() : super(MovieState()) {
    on<MovieInitialEvent>((event, emit) async {
      final List<Movie> movies = await imdbService.getTopMovies();
      emit(state.copyWith(
        movieList: movies,
        isLoading: false,
      ));
    });

    on<ShowMoreEvent>((event, emit) {
      emit(state.copyWith(
        maxMovieCount: state.maxMovieCount + 10,
      ));
    });

    on<SearchInputEvent>((event, emit) async {
      if (!state.isSearching) {
        emit(state.copyWith(
          isLoading: true,
        ));
      }
      final List<Movie> movies = await imdbService.searchMovie(event.text);
      emit(state.copyWith(
        isLoading: false,
        isSearching: true,
        searchInput: event.text,
        maxMovieCount: 10,
        searchList: movies,
      ));
    });

    on<SearchClosedEvent>((event, emit) {
      emit(state.copyWith(
        isSearching: false,
        searchInput: '',
        maxMovieCount: 10,
        searchList: null,
      ));
    });

    on<ClickMovieEvent>((event, emit) async {
      final String movieDescription =
          await imdbService.getMovieDescription(event.movie.id!);
      final Movie currentMovie = event.movie.copyWith(description: movieDescription);
      emit(state.copyWith(
        currentMovie: currentMovie,
      ));
      Get.toNamed(
        '/movie',
        arguments: MovieRouteArgs(
          movie: state.currentMovie!,
          onReturn: Get.back,
        ),
      );
    });
  }
}
