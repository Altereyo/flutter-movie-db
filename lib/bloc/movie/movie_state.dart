part of 'movie_bloc.dart';

class MovieState {
  final List<Movie> movieList;
  final List<Movie> searchList;
  final String searchInput;
  final Movie? currentMovie;
  final bool isSearching;
  final bool isLoading;
  final int maxMovieCount;

  MovieState({
    this.movieList = const [],
    this.searchList = const [],
    this.searchInput = '',
    this.currentMovie,
    this.isSearching = false,
    this.isLoading = true,
    this.maxMovieCount = 10,
  })
  ;
  MovieState copyWith({
    List<Movie>? movieList,
    List<Movie>? searchList,
    String? searchInput,
    Movie? currentMovie,
    bool? isSearching,
    bool? isLoading,
    int? maxMovieCount,
  }) {
    return MovieState(
      movieList: movieList ?? this.movieList,
      searchList: searchList ?? this.searchList,
      searchInput: searchInput ?? this.searchInput,
      currentMovie: currentMovie ?? this.currentMovie,
      isSearching: isSearching ?? this.isSearching,
      isLoading: isLoading ?? this.isLoading,
      maxMovieCount: maxMovieCount ?? this.maxMovieCount,
    );
  }
}