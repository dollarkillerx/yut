import 'package:flutter/material.dart';
import 'package:yut/common/utils/view_util.dart';
import 'package:yut/http/request/base_request.dart';
import '../common/entity/video.dart';
import '../http/dao/login.dart';

class VideoCard extends StatelessWidget {
  final VideoItem videoMo;

  const VideoCard({Key? key, required this.videoMo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("click: ${videoMo.title}");
      },
      child: SizedBox(
        height: 200,
        child: Card(
          margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemImage(context),
                _infoText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        cachedImage("$ImgUrl/${videoMo.img}?token=${LoginDao.getBoardingPass()}"),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
              decoration: BoxDecoration(
                  // 漸變
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconText(Icons.ondemand_video, videoMo.publishedAt),
                  // _iconText(Icons.wifi_channel, videoMo.channelTitle),
                ],
              ),
            ))
      ],
    );
  }

  _iconText(IconData iconData, String? time) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.white,
          size: 12,
        ),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            time!,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ],
    );
  }

  _infoText() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(videoMo.title!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 12, color: Colors.black87),),
          _owner(),
        ],
      ),
    ));
  }

  _owner() {
    var urlImg =
        "$ImgUrl/aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2xlb25hZGxlci9yb3lhbHR5LWZyZWUtdXNlci1hdmF0YXJzL21hc3Rlci8yNTYlMjB4JTIwMjU2LzAwNi5qcGc?token=${LoginDao.getBoardingPass()}";
    urlImg =
        "https://raw.githubusercontent.com/leonadler/royalty-free-user-avatars/master/256%20x%20256/006.jpg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  width: 24,
                  height: 24,
                  image: AssetImage('images/head_right.png'),
                )),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Container(
                width: 120,
                child: Text(
                  videoMo.channelTitle!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 11, color: Colors.black87),
                ),
              ),
            )
          ],
        ),
        Icon(
          Icons.more_vert,
          size: 15,
          color: Colors.black87,
        )
      ],
    );
  }
}

class VideoCard2 extends StatelessWidget {
  final VideoItem videoMo;

  const VideoCard2({Key? key, required this.videoMo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("click: ${videoMo.title}");
      },
      child: Card(
        margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
        child:  Column(
          children: [
            Container(
              child: cachedImage("https://ggapi.mechat.live/api/v1/asset/${videoMo.img}?token=${LoginDao.getBoardingPass()}"),
              margin: EdgeInsets.all(10),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('images/head_right.png'),
              ),
              title: Text(videoMo.channelTitle!),
              subtitle: Text(
                videoMo.title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }


}