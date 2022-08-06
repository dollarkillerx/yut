import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yut/common/entity/video.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage({Key? key, required this.videoModel}) : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('video id: ${widget.videoModel.vid}'),
      ),
    );
  }
}
