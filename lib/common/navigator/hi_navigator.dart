import 'package:flutter/material.dart';
import 'package:yut/page/home.dart';
import 'package:yut/page/login.dart';
import 'package:yut/page/registration.dart';
import 'package:yut/page/video_detail.dart';

// create page
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode),child: child);
}

// 自定義路由封裝,路由狀態
enum RouteStatus {
  login,
  registration,
  home,
  detail,
  unknown
}

// 獲取page 對應的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  }else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  }else if (page.child is HomePage) {
    return RouteStatus.home;
  }else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  }else {
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
int getPageIndex(List<Page<dynamic>>  pages, RouteStatus routeStatus) {
  for (int i=0;i<pages.length;i++) {
    Page<dynamic> page = pages[i];
    if (getStatus(page as MaterialPage) == routeStatus) {
      return i;
    }
  }

  return -1;
}

// 監聽頁面是否壓後臺
class HiNavigator {
  static HiNavigator? _instance;

  HiNavigator._();

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }

    return _instance!;
  }
}