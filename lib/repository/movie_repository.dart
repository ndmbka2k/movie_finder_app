import 'package:movie_finder_app/models/movie.dart';
import 'package:movie_finder_app/network/api_client.dart';

class MovieRepo {
  ApiClient apiClient;

  MovieRepo({required this.apiClient});

  Future<MovieCollection> getPopularMovie() async {
    return await apiClient.getPopularMovie();
  }

  Future<MovieCollection> getNewMovie() async {
    return await apiClient.getNewMovie();
  }

  Future<Movie?> getDetaileMovie(String id) async {
    return await apiClient.getDetaileMovie(id: id);
  }

  Future<MovieCredit> getDetaileMovieCredit(String id) async {
    return await apiClient.getDetaileMovieCredit(id);
  }
}
