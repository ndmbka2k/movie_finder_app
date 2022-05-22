import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_state.dart';
import 'package:movie_finder_app/models/load_status.dart';
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

  void getDetaileMovie({String id = ''}) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.LOADING));
      var movie = await movieRepo.getDetaileMovie(id);
      var credit = await movieRepo.getDetaileMovieCredit(id);
      emit(
        state.copyWith(
          currentMovie: movie,
          movieCredit: credit,
          loadingStatus: LoadingStatus.LOADED,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void gettingData() {
    emit(state.copyWith(loadingStatus: LoadingStatus.LOADING));
  }
}
