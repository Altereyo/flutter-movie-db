import 'package:dio/dio.dart';
import 'package:flutter_movie_db/data/models/movie.dart';
import 'package:get/get.dart' as getx;

class ImdbService extends getx.GetxService {
  final String apiKey = 'k_uh884hdk';
  final Dio dio = Dio();

  Future<List<Movie>> getTopMovies() async {
    final Response response =
        await dio.get('https://imdb-api.com/en/API/Top250Movies/$apiKey');

    List<Movie> result = response.data['items'].map<Movie>((el) {
      return Movie.fromMap(el);
    }).toList();

    return result;
  }

  Future<List<Movie>> searchMovie(String input) async {
    final Response response =
        await dio.get('https://imdb-api.com/en/API/Search/$apiKey/$input');

    List<Movie> result = response.data['results'].map<Movie>((el) {
      return Movie.fromMap(el);
    }).toList();

    return result;
  }

  Future<String> getMovieDescription(String movieId) async {
    final response = await dio
        .get('https://imdb-api.com/en/API/Title/$apiKey/$movieId');

    String result = response.data['plot'];
    return result;
  }
}
