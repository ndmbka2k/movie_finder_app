import 'package:equatable/equatable.dart';
import 'package:movie_finder_app/models/load_status.dart';

import '../../models/movie.dart';

class CollectionMovieState extends Equatable {
  Movie? currentMovie;
  MovieCollection? popularMovies;
  MovieCollection? newReleaseMovie;
  MovieCredit? movieCredit;

  LoadingStatus? loadingStatus;
  CollectionMovieState(
      {this.popularMovies,
      this.newReleaseMovie,
      this.currentMovie,
      this.movieCredit,
      this.loadingStatus});

  CollectionMovieState copyWith(
      {MovieCollection? popularMovies,
      MovieCollection? newReleaseMovie,
      Movie? currentMovie,
      MovieCredit? movieCredit,
      LoadingStatus? loadingStatus}) {
    return CollectionMovieState(
        popularMovies: popularMovies ?? this.popularMovies,
        newReleaseMovie: newReleaseMovie ?? this.newReleaseMovie,
        currentMovie: currentMovie ?? this.currentMovie,
        movieCredit: movieCredit ?? this.movieCredit,
        loadingStatus: loadingStatus ?? this.loadingStatus);
  }

  @override
  List get props => [
        popularMovies,
        newReleaseMovie,
        currentMovie,
        movieCredit,
        loadingStatus
      ];
}
