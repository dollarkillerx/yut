import 'package:flutter/material.dart';

enum StatusStyle {
  LIGHT_CONTENT,
  DARK_CONTENT
}

class NavigationBar extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  const NavigationBar({Key? key,  this.statusStyle  = StatusStyle.DARK_CONTENT, this.color = Colors.white, this.height = 16, required this.child}) : super(key: key);

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
}

// flutter pub add flutter_statusbar_manager 修改狀態欄樣式