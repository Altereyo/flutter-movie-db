import 'package:flutter_movie_db/data/models/movie.dart';

class MovieRouteArgs {
  final Movie movie;
  final void Function() onReturn;

  const MovieRouteArgs({
    required this.movie,
    required this.onReturn,
  });
}