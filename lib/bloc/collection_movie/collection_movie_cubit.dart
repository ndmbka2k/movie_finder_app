import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_state.dart';
import 'package:movie_finder_app/repository/movie_repository.dart';

class CollectionMovieCubit extends Cubit<CollectionMovieState> {
  MovieRepo movieRepo;

  CollectionMovieCubit(this.movieRepo) : super(CollectionMovieState());

  void init() async {
    try {
      var popularMovie = await movieRepo.getPopularMovie();
      var newMovie = await movieRepo.getNewMovie();
      emit(state.copyWith(
          popularMovies: popularMovie, newReleaseMovie: newMovie));
    } catch (e) {
      print(e);
    }
  }

  void getDetaileMovie(String id) async {
    try {
      var movie = await movieRepo.getDetaileMovie(id);
      emit(state.copyWith(currentMovie: movie));
    } catch (e) {
      print(e);
    }
  }
}
