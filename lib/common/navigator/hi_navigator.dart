import 'package:flutter/material.dart';
import 'package:yut/common/navigator/bottom_navigator.dart';
import 'package:yut/page/home.dart';
import 'package:yut/page/login.dart';
import 'package:yut/page/registration.dart';
import 'package:yut/page/video_detail.dart';

// 當前,上次 頁面
typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo? pre);

// create page
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

// 自定義路由封裝,路由狀態
enum RouteStatus { login, registration, home, detail, unknown }

// 獲取page 對應的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unknown;
  }
}

// 路由信息
class RouteStatusInfo {
  final RouteStatus roteStatus;
  final Widget page;

  RouteStatusInfo(this.roteStatus, this.page);
}

// 獲取routeStatus在頁面堆棧中的位置
int getPageIndex(List<Page<dynamic>> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    Page<dynamic> page = pages[i];
    if (getStatus(page as MaterialPage) == routeStatus) {
      return i;
    }
  }

  return -1;
}

// 監聽頁面是否壓後臺
class HiNavigator extends _RouteJumpListener {
  static HiNavigator? _instance;

  RouteJumpListener? _routeJump;
  List<RouteChangeListener> _listeners = [];

  HiNavigator._();

  RouteStatusInfo? _current;
  RouteStatusInfo? _bottomTab;

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }

    return _instance!;
  }

  // 注冊路由跳轉邏輯
  void registerRouteJump(RouteJumpListener roteJumpListener) {
    this._routeJump = roteJumpListener;
  }

  // 監聽路由頁面跳轉
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  // 移除監聽
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  // 首頁底部tab切換監聽
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  // 通知路由頁面變化
  void notify(
    List<Page<dynamic>> currentPage,
    List<Page<dynamic>> prePages,
  ) {
    var current = RouteStatusInfo(getStatus(currentPage.last as MaterialPage),
        (currentPage.last as MaterialPage).child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      current = _bottomTab!;
    }

    print('hi current: ${current.page}');
    print('hi pre: ${_current?.page}');
    _listeners.forEach((element) {
      element(current, _current);
    });
    _current = current;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    if (_routeJump != null) {
      _routeJump!.onJumpTo(routeStatus, args: args);
    }
  }
}

abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

// 定義路由跳轉邏輯實現功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener(this.onJumpTo);
}
