import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_cubit.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_state.dart';
import 'package:movie_finder_app/models/load_status.dart';

class DetailScreen1 extends StatefulWidget {
  const DetailScreen1({super.key, required this.movieId});

  final String movieId;
  @override
  State<DetailScreen1> createState() => _DetailScreen1State();
}

class _DetailScreen1State extends State<DetailScreen1> {
  late final CollectionMovieCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = BlocProvider.of<CollectionMovieCubit>(context);
    _cubit.getDetaileMovie(id: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BlocBuilder<CollectionMovieCubit, CollectionMovieState>(
            bloc: _cubit,
            buildWhen: (previous, current) =>
                previous.loadingStatus != current.loadingStatus,
            builder: (context, state) => SliverAppBar(
              expandedHeight: 500,
              flexibleSpace: FlexibleSpaceBar(
                background: state.loadingStatus == LoadingStatus.LOADING
                    ? Container()
                    : Image.network(
                        'https://image.tmdb.org/t/p/original/${state.currentMovie!.posterPath}',
                        fit: BoxFit.fitWidth,
                      ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
              ),
            ),
            Container(
              height: 250,
              color: Colors.amber,
            ),
            Container(
              height: 250,
              color: Colors.amber,
            )
          ]))
        ],
      ),
    );
  }
}
