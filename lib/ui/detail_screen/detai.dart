import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_cubit.dart';
import 'package:movie_finder_app/bloc/collection_movie/collection_movie_state.dart';
import 'package:movie_finder_app/models/load_status.dart';
import 'package:movie_finder_app/ui/detail_screen/detail_screen.dart';
import 'package:movie_finder_app/ui/detail_screen/video_player/custom_video_player.dart';
import 'package:readmore/readmore.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../constants/images/images.dart';

class Detail extends StatefulWidget {
  const Detail({super.key, required this.movieId});

  final String movieId;
  @override
  State<Detail> createState() => _Detail();
}

class _Detail extends State<Detail> {
  late final CollectionMovieCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = BlocProvider.of<CollectionMovieCubit>(context);
    _cubit.getDetaileMovie(id: widget.movieId);
  }

  final PanelController panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CollectionMovieCubit, CollectionMovieState>(
        builder: (context, state) {
          var textStyleRegular = TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xffffffff));
          var textStyleBold = TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xffffffff),
              fontSize: 64.sp);
          var textStyleMedium = TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xffffffff),
              fontSize: 12.sp);
          return Stack(
            children: [
              SlidingUpPanel(
                controller: panelController,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(55),
                ),
                parallaxEnabled: true,
                minHeight: 400,
                maxHeight: 800,
                panelBuilder: (controller) {
                  return Container(
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
                        topRight: Radius.circular(45.r),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(left: 50.w, right: 50.w),
                      controller: controller,
                      children: [
                        InkWell(
                          onTap: () {
                            panelController.isPanelOpen
                                ? panelController.close()
                                : panelController.open();
                          },
                          child: Image.asset(AppIcon.strikethrough),
                        ),
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
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Videos',
                            style: textStyleBold.copyWith(fontSize: 18.sp),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        state.loadingStatus == LoadingStatus.LOADING
                            ? Container()
                            : Stack(
                                children: [
                                  Image.network(
                                    'https://image.tmdb.org/t/p/original/${state.currentMovie!.backdropPath}',
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            insetPadding: EdgeInsets.zero,
                                            contentPadding: EdgeInsets.zero,
                                            content: CustomVideoPlayer(
                                              videoId:
                                                  'https://www.youtube.com/watch?v=${state.movieCredit!.getKey()}',
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.play_circle_fill_outlined,
                                        color: Colors.yellow,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  );
                },
                body: state.loadingStatus == LoadingStatus.LOADING
                    ? Container()
                    : Container(
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x00121212), Color(0xff121212)],
                          ),
                        ),
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original/${state.currentMovie!.posterPath}',
                        ),
                      ),
              ),
              Positioned(
                child: InkWell(
                  onTap: (() => Navigator.pop(context)),
                  child: Image.asset(AppIcon.back_icon),
                ),
                left: 50.w,
                top: 50.h,
              ),
            ],
          );
        },
      ),
    );
  }
}
