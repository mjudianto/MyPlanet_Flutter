// import 'package:flutter/foundation.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoPlayPodtret extends StatefulWidget {
  const VideoPlayPodtret({super.key});

  // String? get title => null;

  @override
  State<VideoPlayPodtret> createState() => _VideoPlayPodtretState();
}

class _VideoPlayPodtretState extends State<VideoPlayPodtret> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  String videoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('test'),
      ),
      child: SafeArea(
        child: CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController),
      ),
    );
  }
}
