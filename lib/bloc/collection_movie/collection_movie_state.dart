import 'package:equatable/equatable.dart';

import '../../models/movie.dart';

class CollectionMovieState extends Equatable {
  Movie? currentMovie;
  MovieCollection? popularMovies;
  MovieCollection? newReleaseMovie;
  CollectionMovieState(
      {this.popularMovies, this.newReleaseMovie, this.currentMovie});

  CollectionMovieState copyWith(
      {MovieCollection? popularMovies,
      MovieCollection? newReleaseMovie,
      Movie? currentMovie}) {
    return CollectionMovieState(
      popularMovies: popularMovies ?? this.popularMovies,
      newReleaseMovie: newReleaseMovie ?? this.newReleaseMovie,
      currentMovie: currentMovie ?? this.currentMovie,
    );
  }

  @override
  List get props => [popularMovies, newReleaseMovie, currentMovie];
}
