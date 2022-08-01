import 'package:flutter/material.dart';

class MyDialog {
  static Alert(BuildContext context,String title,Widget content, {List<Widget>? actions}) async {
    if (actions == null) {
      actions = <Widget>[
        ElevatedButton(onPressed: () {
          Navigator.pop(context,"ok");    // 這個會返回
        }, child: Text("返回"))
      ];
    }

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: content,
            actions: actions,
          );
        },
    );
  }
}