class Movie {
  String backdropPath;
  String posterPath;
  String movieTitle;
  String overview;
  String id;
  String tagline;
  List? genres;

  Movie(
      {required this.backdropPath,
      required this.movieTitle,
      required this.overview,
      required this.posterPath,
      required this.id,
      this.tagline = '',
      this.genres});

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        backdropPath: json['backdrop_path'],
        movieTitle: json['original_title'],
        posterPath: json['poster_path'],
        overview: json['overview'],
        id: json['id'].toString(),
        tagline: json['tagline'],
        genres: (json['genres'] as List).length >= 1
            ? (json['genres'] as List)
                .map((e) {
                  return e['name'];
                })
                .toList()
                .sublist(0, 1)
            : (json['genres'] as List).map((e) {
                return e['name'];
              }).toList(),
      );
}

// class MovieCredit {
//   String key;
//   MovieCredit(this.key);
//   factory MovieCredit.fromJson(Map<String, dynamic> json) =>
//       MovieCredit(json['results'].first['key']);
// }

class MovieCredit {
  List results;
  MovieCredit({required this.results});

  String getKey() {
    return results
        .where((element) => element['type'] == 'Trailer')
        .first['key'];
  }

  factory MovieCredit.fromJson(Map<String, dynamic> json) =>
      MovieCredit(results: json['results']);
}

class MovieCollection {
  List<Movie> movies;
  MovieCollection({required this.movies});

  factory MovieCollection.fromJson(Map<String, dynamic> json) {
    List<Movie> temp = (json['results'] as List<dynamic>).map((e) {
      return Movie(
        backdropPath: e['backdrop_path'],
        movieTitle: e['title'],
        overview: e['overview'],
        posterPath: e['poster_path'],
        id: e['id'].toString(),
      );
    }).toList();
    return MovieCollection(movies: temp);
  }
}
