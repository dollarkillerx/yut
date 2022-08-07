import 'package:flutter/material.dart';
import 'package:yut/common/local_storage/hi_cache.dart';
import 'package:yut/common/navigator/hi_navigator.dart';
import 'package:yut/http/dao/login.dart';
import 'package:yut/page/home.dart';
import 'package:yut/page/login.dart';
import 'package:yut/page/registration.dart';
import 'package:yut/page/video_detail.dart';
import 'common/entity/video.dart';
import 'common/color/color.dart';

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
    return FutureBuilder<HiCache>(
        future: () async {
          return await HiCache.preInit();
        }(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
      var widget = snapshot.connectionState == ConnectionState.done ?
          Router(routerDelegate: _routerDelegate):
          Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
      return MaterialApp(
        home: widget,
        theme: ThemeData(primarySwatch: white),
      );
    });
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>  with ChangeNotifier,PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  // 為Navigator設置一個key,必要的時候通過navigatorKey.currentState來獲取到NavigatorState對象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  // 存放所有的頁面
  List<Page<dynamic>> pages = [];
  VideoModel? videoModel;
  late BiliRoutePath path;
  RouteStatus _routeStatus = RouteStatus.home;

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  // 返回路由的堆棧信息
  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<Page<dynamic>> tempPages = pages;
    if (index != -1) {
      // 要開打頁面在棧中已存在, 則將該頁面和它上面的所有頁面進行出棧
      // tips 具體邏輯具體調整,要求只允許有一個同樣的頁面實例
      tempPages = tempPages.sublist(0,index);
    }

    var page;

    // 如果是首頁 將棧内其他都出棧
    if (routeStatus==RouteStatus.home) {
      pages.clear();
      page = pageWrap(HomePage(onJumpToDetail: (videoModel) {
        this.videoModel = videoModel;
        notifyListeners(); // 通知數據變化
      },));
    }else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel: videoModel!));
    }else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage(onJumpToLogin: () {
        _routeStatus = RouteStatus.login;
        notifyListeners(); // 通知數據變化
      }));
    }else if (routeStatus == RouteStatus.login) {
     page = pageWrap(LoginPage());
    }

    tempPages = [...tempPages,page];
    pages = tempPages;
    // 構建路由堆棧

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

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    }else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    }

    return _routeStatus;
  }
}

class BiliRoutePath {
  late final String location;

  BiliRoutePath.home(): location = "/";
  BiliRoutePath.detail(): location = "/detail";
}

// create page
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode),child: child);
}