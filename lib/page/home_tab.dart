import 'package:flutter/material.dart';
import 'package:yut/common/entity/banner.dart';
import 'package:yut/core/hi_state.dart';
import 'package:yut/http/dao/login.dart';
import 'package:yut/widget/hi_banner.dart';
import '../common/entity/video.dart';
import '../common/logs/logs.dart';
import '../common/utils/toast.dart';
import '../http/dao/tops.dart';
import '../http/request/base_request.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  final String topic;

  const HomeTabPage({Key? key, required this.name, required this.topic})
      : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends HiState<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  var isLoad = true;
  List<VideoItem>? videoList;
  String? nextToken;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    await this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _view(),
    );
  }

  _view() {
    if (this.isLoad) {
      return CircularProgressIndicator(
        color: Colors.cyan,
      );
    } else {
      return Container(
        child: ListView(
          // children: [if (widget.bannerList != null) _banner()],
          children: [_banner()],
        ),
      );
    }
    //   return ListView.builder(
    //       padding: EdgeInsets.all(10),
    //       shrinkWrap: true,
    //       itemCount: this.videoList?.length,
    //       itemBuilder: (context, index) {
    //         return ListTile(
    //           title: Image.network(
    //               "https://ggapi.mechat.live/api/v1/asset/${this.videoList![index].img}?token=${LoginDao.getBoardingPass()}"),
    //           subtitle: Text(this.videoList![index].title!),
    //         );
    //       });
    // }
  }

  _loadData() async {

    setState(() {
      this.isLoad  = false;
    });
    return;
    try {
      var result = await TopsDao.videos(topic: widget.topic);
      var err = NetTools.CheckError(result);
      if (err != null) {
        showWarnToast("$err");
        return;
      }
      VideoList loginResp = VideoList.fromJson(result);
      setState(() {
        nextToken = loginResp.data!.nextToken;
        videoList = loginResp.data!.item;
        isLoad = false;
      });
    } catch (e) {
      Log.info("$e", StackTrace.current);
      showWarnToast("$e");
      setState(() {
        isLoad = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 8,right: 8),
      child: HiBanner(bannerList: [
        BannerMo(
          title: "にほんだいがく",
          img: "https://www.nihon-u.ac.jp/uploads/images/20220415185608.jpg",
          url: "https://www.nihon-u.ac.jp/"
        ),
        BannerMo(
            title: "とうようだいがく",
            img: "https://www.toyo.ac.jp/-/media/Images/Toyo/pickup/menu/enryo-coffee.ashx",
            url: "https://www.toyo.ac.jp/"
        ),
        BannerMo(
            title: "せんしゅうだいがく",
            img: "https://www.senshu-u.ac.jp/albums/9/abm00001213.png",
            url: "https://www.senshu-u.ac.jp/"
        ),
      ]),
    );
  }
}
