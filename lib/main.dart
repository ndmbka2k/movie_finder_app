import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_cubit.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_state.dart';
import 'package:movie_finder_app/models/movie.dart';
import 'package:movie_finder_app/network/api_client.dart';
import 'package:movie_finder_app/network/api_ulti.dart';
import 'package:movie_finder_app/repository/movie_repository.dart';
import 'package:movie_finder_app/ui/detail_screen/detail_screen.dart';
import 'package:movie_finder_app/ui/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ApiClient _apiClient;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiClient = ApiUlti.instance.client;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      builder: (_) => RepositoryProvider<MovieRepo>(
        create: (context) => MovieRepo(apiClient: _apiClient),
        child: BlocProvider<CollectionMovieCubit>(
          create: (context) =>
              CollectionMovieCubit(RepositoryProvider.of<MovieRepo>(context)),
          child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'BeVietnamPro',
            ),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
