import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoURL;
  const VideoPlayerItem({super.key, required this.videoURL});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoURL))
          ..initialize().then((value) {
            videoPlayerController.play();
            videoPlayerController.setVolume(1);
            videoPlayerController.setLooping(true);
          });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(color: Colors.black),
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            )
          : Container(
              child: VideoPlayer(videoPlayerController),
            ),
      // child: VideoPlayer(videoPlayerController),
    );
  }
}
