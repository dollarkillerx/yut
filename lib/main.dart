import 'package:flutter/material.dart';
import 'package:yut/common/local_storage/hi_cache.dart';
import 'package:yut/common/navigator/hi_navigator.dart';
import 'package:yut/common/utils/toast.dart';
import 'package:yut/http/dao/login.dart';
import 'package:yut/page/login.dart';
import 'package:yut/page/registration.dart';
import 'package:yut/page/video_detail.dart';
import 'common/entity/video.dart';
import 'common/color/color.dart';
import 'common/navigator/bottom_navigator.dart';

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
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    HiNavigator.getInstance().registerRouteJump(RouteJumpListener((routeStatus, {args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        if (args!= null) {
          this.videoModel = args['videoMo'];
        }
      }

      notifyListeners();
    }));
  }
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
      page = pageWrap(const BottomNavigator());
    }else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel: videoModel!));
    }else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(const RegistrationPage());
    }else if (routeStatus == RouteStatus.login) {
     page = pageWrap(const LoginPage());
    }

    // 構建路由堆棧
    tempPages = [...tempPages,page];
    // 儅路由發生變化
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;

    return WillPopScope(child: Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route,result) {
        if (route.settings is MaterialPage) {
          // 登錄未的登陸返回攔截
          if ((route.settings as MaterialPage).child is LoginPage) {
            if (!hasLogin) {
              showWarnToast("please login");
              return false;
            }
          }
        }

        if (!route.didPop(result)) {
          return false;
        }

        // 儅路由發生變化
        var tempPages = [...pages];
        pages.removeLast();
        HiNavigator.getInstance().notify(pages, tempPages);
        return true;
      },
    ), onWillPop: () async => !(await navigatorKey.currentState?.maybePop() ?? false));
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