import 'package:flutter/material.dart';

import '../common/utils/strings.dart';
import '../widget/LOGIN_EFFECT.dart';
import '../widget/appbar.dart';
import '../widget/login_button.dart';
import '../widget/login_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false; // 保護 儅輸入密碼的時候 導航圖片顯示
  bool loginEnable = false; // 參數校驗完畢 可登錄
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注冊", "登錄", () {}),
      body: Container(
        child: ListView(
          // 自適應鍵盤彈起,防止遮擋
          children: <Widget>[
            LoginEffect(
              protect: protect,
            ),
            LoginInput(
              title: "用戶名",
              hint: "請輸入用戶名",
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              title: "密碼",
              hint: "請輸入密碼",
              obscureText: true,
              // lineStretch: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (ok) {
                setState(() {
                  protect = ok;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton('登錄',
                  enable: loginEnable, onPressed: checkParams),
            )
            // Padding(
            //   padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            //   child: _loginButton(),
            // )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void checkParams() {
    // send();
  }

}
