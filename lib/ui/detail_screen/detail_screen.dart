import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_cubit.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_state.dart';
import 'package:movie_finder_app/constants/colors/colors.dart';
import 'package:movie_finder_app/constants/images/images.dart';
import 'package:movie_finder_app/models/movie.dart';
import 'package:movie_finder_app/ui/home_screen/home_screen.dart';
import 'package:readmore/readmore.dart';

class DetailScreen extends StatefulWidget {
  final String movieId;
  const DetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final CollectionMovieCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = BlocProvider.of<CollectionMovieCubit>(context);
    _cubit.getDetaileMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    var textStyleRegular = TextStyle(
      fontSize: 8.sp,
      fontWeight: FontWeight.w500,
      color: Color(0xffffffff),
    );
    var textStyleBold = TextStyle(
        fontWeight: FontWeight.w700, color: Color(0xffffffff), fontSize: 64.sp);
    var textStyleMedium = TextStyle(
        fontWeight: FontWeight.w500, color: Color(0xffffffff), fontSize: 12.sp);
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00121212), Color(0xff121212)],
                ),
              ),
              child: BlocBuilder<CollectionMovieCubit, CollectionMovieState>(
                buildWhen: (previous, current) =>
                    previous.currentMovie != current.currentMovie,
                builder: (context, state) {
                  return state.currentMovie == null
                      ? Container()
                      : Image.network(
                          'https://image.tmdb.org/t/p/original/${state.currentMovie!.posterPath}',
                          height: 634.h,
                          width: 428.w,
                          fit: BoxFit.fill,
                        );
                },
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 490.h),
                height: 926.h,
                width: 428.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff2b5876),
                      Color(0xff4e4376),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      50.r,
                    ),
                    topRight: Radius.circular(50.r),
                  ),
                ),
                padding: EdgeInsets.only(top: 30.h, left: 50.w, right: 50.w),
                child: BlocBuilder<CollectionMovieCubit, CollectionMovieState>(
                  buildWhen: (previous, current) =>
                      previous.currentMovie != current.currentMovie,
                  builder: (context, state) {
                    return Column(
                      children: [
                        Image.asset(AppIcon.strikethrough),
                        Center(
                          child: Text(
                            state.currentMovie?.movieTitle ?? '',
                            style: textStyleBold,
                          ),
                        ),
                        Text(
                          state.currentMovie?.tagline ?? '',
                          style: textStyleBold.copyWith(
                            fontSize: 18.sp,
                            color: Color(0xffffffff).withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: state.currentMovie == null
                                      ? []
                                      : (state.currentMovie?.genres ?? [])
                                          .map((e) {
                                          return MovieGenre(
                                              title: e.toString());
                                        }).toList(),
                                ),
                                Container(
                                  width: 73.w,
                                  height: 23.h,
                                  padding:
                                      EdgeInsets.only(left: 6.5.w, right: 10.w),
                                  decoration: BoxDecoration(
                                    color: Color(0xfff5c518),
                                    borderRadius: BorderRadius.circular(15.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x4000000000),
                                        blurRadius: 15.r,
                                        offset: Offset(4, 4),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(AppIcon.imdb),
                                      Text(
                                        '8.5',
                                        style: textStyleBold.copyWith(
                                          fontSize: 12,
                                          color: Color(0xff000000),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(AppIcon.share),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Image.asset(AppIcon.favorite_solid),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        ReadMoreText(
                          state.currentMovie?.overview ?? '',
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          colorClickableText: Color(0xffA6A1E0),
                          trimExpandedText: 'Less',
                          trimCollapsedText: 'More',
                          style: TextStyle(
                            color: Color(0xffffffff).withOpacity(0.75),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cast',
                              style: textStyleBold.copyWith(fontSize: 18.sp),
                            ),
                            Text(
                              'See All',
                              style: textStyleMedium,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: AppImage.actor.map((e) {
                            return ActorCard(
                              textStyle: textStyleRegular,
                              image: e[0],
                              actorName: e[1],
                              charName: e[2],
                            );
                          }).toList(),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
              child: InkWell(
                  onTap: (() => Navigator.pop(context)),
                  child: Image.asset(AppIcon.back_icon)),
              left: 50.w,
              top: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ActorCard extends StatelessWidget {
  const ActorCard({
    Key? key,
    required this.textStyle,
    required this.actorName,
    required this.charName,
    required this.image,
  }) : super(key: key);

  final TextStyle textStyle;

  final String image;
  final String actorName;
  final String charName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102.h,
      width: 49.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 15.r,
                  offset: Offset(4, 4))
            ]),
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            actorName,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            charName,
            textAlign: TextAlign.center,
            style: textStyle.copyWith(
              color: Color(0xffffffff).withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieGenre extends StatelessWidget {
  const MovieGenre({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
          gradient: AppColor.gradientButtonColor,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 15.r,
              offset: Offset(4, 4),
            )
          ]),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: Color(0xffffffff)),
      ),
    );
  }
}
