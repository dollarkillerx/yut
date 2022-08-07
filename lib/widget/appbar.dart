import 'package:flutter/material.dart';

appBar(
  String title,
  String rightTitle,
  VoidCallback rightButtonClick, // 點擊事件
) {
  return AppBar(
    // title 居左
    centerTitle: false,
    titleSpacing: 0,
    // 标题间距
    leading: BackButton(),
    // 左邊加上返回按鈕
    title: Text(
      title,
      style: TextStyle(fontSize: 18),
    ),
    actions: <Widget>[
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}
