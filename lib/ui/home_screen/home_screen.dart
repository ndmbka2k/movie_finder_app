import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_cubit.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_state.dart';
import 'package:movie_finder_app/constants/images/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_finder_app/ui/detail_screen/detail_screen.dart';
import 'package:movie_finder_app/ui/detail_screen/detail_screen1.dart';

import '../detail_screen/detai.dart';
import 'components/categpry_button.dart';
import 'components/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final CollectionMovieCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    _cubit = BlocProvider.of<CollectionMovieCubit>(context);
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: 428.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff2b5876), Color(0xff4e4376)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 58.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 64.w, vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: TextStyle(color: Color(0xffffffff)),
                            children: [
                              TextSpan(
                                text: 'Hello, ',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: 'Jane!',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700),
                              )
                            ]),
                      ),
                      Image.asset(AppIcon.notiIcon)
                    ],
                  ),
                ),
                Container(
                  height: 50.h,
                  margin: EdgeInsets.only(left: 52.w, bottom: 27.h),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0x4C6b66a6),
                          Color(0x4c74d1dd),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        width: 1.w,
                        color: Colors.white.withOpacity(0.2),
                      )),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 18.w, right: 10.w),
                        child: Image.asset(AppIcon.searchIcon),
                      ),
                      SizedBox(
                        width: 230.w,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Color(0x4cffffff),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 13.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 35.h,
                              width: 1.w,
                              color: Colors.white.withOpacity(0.2),
                            ),
                            SizedBox(
                              width: 17.w,
                            ),
                            Image.asset(AppIcon.voiceIcon),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SectionTitle(
                  title: 'Most Popular',
                ),
                SizedBox(
                  height: 166.h,
                  child:
                      BlocBuilder<CollectionMovieCubit, CollectionMovieState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      var popular = state.popularMovies;
                      return Swiper(
                        fade: 0.3,
                        itemCount: popular == null ? 0 : 5,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.topCenter,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return Detail(
                                        movieId: popular!.movies[index].id);
                                  }));
                                },
                                child: Image(
                                  image: CachedNetworkImageProvider(
                                      'https://image.tmdb.org/t/p/original/${popular!.movies[index].backdropPath}'),
                                  height: 140.h,
                                  width: 328.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                        viewportFraction: 0.7,
                        scale: 0.8,
                        pagination: SwiperPagination(
                          margin: EdgeInsets.zero,
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            activeSize: 8.r,
                            size: 8.r,
                            color: Colors.grey,
                            activeColor: Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.h, left: 50.w, right: 50.w, bottom: 35.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CategoryButton(
                        image: AppIcon.genrs,
                        title: 'Generes',
                      ),
                      CategoryButton(
                        image: AppIcon.tv,
                        title: 'TV series',
                      ),
                      CategoryButton(
                        image: AppIcon.movie,
                        title: 'Movies',
                      ),
                      CategoryButton(
                        image: AppIcon.theater,
                        title: 'In Theater',
                      ),
                    ],
                  ),
                ),
                SectionTitle(title: 'Upcoming releases'),
                SizedBox(
                  height: 240.h,
                  child:
                      BlocBuilder<CollectionMovieCubit, CollectionMovieState>(
                    builder: (context, state) {
                      var newMovie = state.newReleaseMovie;
                      return Swiper(
                        itemCount: newMovie == null ? 0 : 5,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.topCenter,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DetailScreen(
                                          movieId: state.newReleaseMovie!
                                              .movies[index].id,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Image(
                                  image: CachedNetworkImageProvider(
                                      'https://image.tmdb.org/t/p/original/${newMovie!.movies[index].posterPath}'),
                                  fit: BoxFit.fill,
                                  height: 215.h,
                                  width: 145.w,
                                ),
                              ),
                            ),
                          );
                        },
                        viewportFraction: 0.38,
                        pagination: SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.zero,
                          builder: DotSwiperPaginationBuilder(
                            activeSize: 8.r,
                            size: 8.r,
                            color: Colors.grey,
                            activeColor: Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.h,
            child: CustomNavigationBar(),
          )
        ],
      ),
    );
  }
}

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Color(0x4c6b66a6), Color(0x4c75d1dd)]),
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0x4cffffff),
          ),
        ),
      ),
      width: 428.w,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 42.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AppIcon.home),
          Image.asset(AppIcon.favorite),
          Image.asset(AppIcon.ticket),
          Image.asset(AppIcon.account),
          Image.asset(AppIcon.shuffle),
        ],
      ),
    );
  }
}
