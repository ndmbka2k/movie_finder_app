import 'package:flutter/src/widgets/framework.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key, required this.videoId});
  final String videoId;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String url = widget.videoId;
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: YoutubePlayerFlags(autoPlay: false, loop: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: controller,
    );
  }
}
