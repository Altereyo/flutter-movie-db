part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class MovieInitialEvent extends MovieEvent {}

class SearchInputEvent extends MovieEvent {
  final String text;

  SearchInputEvent(this.text);
}
class SearchClosedEvent extends MovieEvent {}

class ShowMoreEvent extends MovieEvent {}

class OpenMovieEvent extends MovieEvent {
  final Movie movie;

  OpenMovieEvent(this.movie);
}

class ExitMovieEvent extends MovieEvent {}
