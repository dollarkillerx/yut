import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import '../../widget/navigation_bar.dart';

///修改状态栏
void changeStatusBar(
    {color: Colors.white,
      StatusStyle statusStyle: StatusStyle.DARK_CONTENT,
      BuildContext? context}) {
  //沉浸式状态栏样式
  Brightness brightness;
  if (Platform.isIOS) {
    brightness = statusStyle == StatusStyle.LIGHT_CONTENT
        ? Brightness.dark
        : Brightness.light;
  } else {
    brightness = statusStyle == StatusStyle.LIGHT_CONTENT
        ? Brightness.light
        : Brightness.dark;
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: brightness,
    statusBarIconBrightness: brightness,
  ));
}
