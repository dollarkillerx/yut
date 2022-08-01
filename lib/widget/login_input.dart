import 'package:flutter/material.dart';
import 'package:yut/common/color/color.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String? hint; // placeholder
  final ValueChanged<String>? onChanged; // 改变
  final ValueChanged<bool>? focusChanged; // 焦点改变
  final bool lineStretch; // 线拉伸
  final bool obscureText; // password input
  final TextInputType? keyboardType;

  const LoginInput(
      {super.key,
      required this.title, // title
      this.hint,
      this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType});

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode(); // 檢查獲取光標

  @override
  void initState() {
    super.initState();

    // 光標獲取
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            _input(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: !widget.lineStretch ? 15 : 0,
            right: !widget.lineStretch ? 15 : 0,
          ),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }

  _input() {
    return Expanded(
      child: TextField(
        focusNode: _focusNode,
        // 是否被選擇
        onChanged: widget.onChanged,
        // 改變
        obscureText: widget.obscureText,
        // 密碼
        keyboardType: widget.keyboardType,
        // keyboard類型
        autofocus: !widget.obscureText,
        // 光標顔色
        cursorColor: primary,
        style: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
        // 輸入框樣式
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.hint ?? '',
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ),
    );
  }
}
