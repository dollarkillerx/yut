import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String url;
  final String cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio; // 播放畫框比例

  const VideoView(this.url,{Key? key, required this.cover, this.autoPlay = false, this.looping = false, this.aspectRatio = 16/9}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final VideoPlayerController _videoPlayerController;
  late final ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}

