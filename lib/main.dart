import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yut/page/home.dart';
import 'package:yut/page/video_detail.dart';
import 'common/entity/video.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  State<BiliApp> createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _routerDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    var widget = Router(routerDelegate: _routerDelegate);

    return MaterialApp(
      home: widget,
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>  with ChangeNotifier,PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  // 為Navigator設置一個key,必要的時候通過navigatorKey.currentState來獲取到NavigatorState對象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  // 存放所有的頁面
  List<Page<dynamic>> pages = [];
  VideoModel videoModel = VideoModel(1);
  late BiliRoutePath path;

  // 返回路由的堆棧信息
  @override
  Widget build(BuildContext context) {

    // 構建路由堆棧
    pages = [
      pageWrap(HomePage(onJumpToDetail: (videoModel) {
        this.videoModel = videoModel;
        notifyListeners(); // 通知數據變化
      },)),
      pageWrap(VideoDetailPage(videoModel: videoModel)),

      // if (videoModel != null) pageWrap(VideoDetailPage(videoModel: videoModel!))
    ];

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route,result) {
          if (!route.didPop(result)) {
            return false;
          }
          return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {
    path = configuration;
  }

}

class BiliRoutePath {
  late final String location;

  BiliRoutePath.home(): location = "/";
  BiliRoutePath.detail(): location = "/detail";
}

// create page
pageWrap(Widget child) {
  return CupertinoPage(key: ValueKey(child.hashCode),child: child);
}