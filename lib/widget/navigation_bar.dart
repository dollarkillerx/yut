import 'package:flutter/material.dart';
import '../common/utils/view_util.dart';

enum StatusStyle {
  LIGHT_CONTENT,
  DARK_CONTENT
}

class MyNavigationBar extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  const MyNavigationBar({Key? key,  this.statusStyle  = StatusStyle.DARK_CONTENT, this.color = Colors.white, this.height = 16, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // 獲取狀態欄高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width, // 獲取屏幕寬度
      height: top + height,
      child: child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }

  void _statusBarInit() {
    //沉浸式状态栏
    changeStatusBar(color: color, statusStyle: statusStyle);
  }
}

