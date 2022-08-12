import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yut/common/entity/video.dart';
import 'package:yut/widget/video_view.dart';

import '../http/dao/login.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoItem videoModel;

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
        child: Column(
          children: [
            Text('視頻詳情頁， vid: ${widget.videoModel.videoId}'),
            Text('視頻詳情頁， title: ${widget.videoModel.title}'),
            _videoView(),
          ],
        ),
      ),
    );
  }

  _videoView() {
    print("https://ggapi.mechat.live/api/v1/video/${widget.videoModel.videoId}?token=${LoginDao.getBoardingPass()}");
    return VideoView("https://ggapi.mechat.live/api/v1/video/${widget.videoModel.videoId}?token=${LoginDao.getBoardingPass()}", cover: "false");
  }
}
