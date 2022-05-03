import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/movie.dart';

class ApiClient {
  var client = http.Client();
  Future<MovieCollection> getPopularMovie() async {
    try {
      var response = await client.get(Uri.parse(
          'https://api.themoviedb.org/3/trending/movie/week?api_key=26763d7bf2e94098192e629eb975dab0'));
      Map<dynamic, dynamic> decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var movieCollection =
          MovieCollection.fromJson(decodedResponse as Map<String, dynamic>);

      return movieCollection;
    } finally {}
  }

  Future<MovieCollection> getNewMovie() async {
    try {
      var response = await client.get(Uri.parse(
          'https://api.themoviedb.org/3/discover/movie?api_key=26763d7bf2e94098192e629eb975dab0'));
      Map<dynamic, dynamic> decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var movieCollection =
          MovieCollection.fromJson(decodedResponse as Map<String, dynamic>);

      return movieCollection;
    } finally {}
  }

  Future<Movie> getDetaileMovie(String id) async {
    try {
      var response = await client.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$id?api_key=26763d7bf2e94098192e629eb975dab0'));
      Map<dynamic, dynamic> decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var movie = Movie.fromJson(decodedResponse as Map<String, dynamic>);

      return movie;
    } finally {}
  }
}
