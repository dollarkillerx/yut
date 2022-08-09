import 'package:flutter/material.dart';
import 'package:yut/http/request/base_request.dart';
import '../common/entity/video.dart';

class VideoCard extends StatelessWidget {
  final VideoItem videmoMo;

  const VideoCard({Key? key,required this.videmoMo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("click: ${videmoMo.title}");
      },
      child: Image.network("$ImgUrl/${videmoMo.img}"),
    );
  }
}
