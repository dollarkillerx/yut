import 'package:flutter/material.dart';
import 'package:yut/common/dialog/dialog.dart';
import 'package:yut/common/logs/logs.dart';
import 'package:yut/http/core/hi_error.dart';
import 'package:yut/http/dao/login.dart';
import 'package:yut/widget/appbar.dart';
import 'package:yut/widget/login_input.dart';

import '../common/utils/strings.dart';
import '../widget/LOGIN_EFFECT.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback onJumpToLogin;

  const RegistrationPage({Key? key, required this.onJumpToLogin})
      : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false; // 保護 儅輸入密碼的時候 導航圖片顯示
  bool loginEnable = false; // 參數校驗完畢 可登錄
  String? userName;
  String? password;
  String? rePassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注冊", "登錄", widget.onJumpToLogin),
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
            LoginInput(
              title: "確認密碼",
              hint: "請再次輸入密碼",
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
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
              child: _loginButton(),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
      child: Text('Registration'),
      onTap: () {
        if (!checkParams()) {
          MyDialog.Alert(context, "Error", Text("參數錯誤"));
          return;
        }
        if (loginEnable) {
          _send();
        } else {
          MyDialog.Alert(context, "Error", Text("請認真填寫參數"));
        }
      },
    );
  }

  bool checkParams() {
    if (password == rePassword) {
      return true;
    }

    return false;
  }

  _send() async {
    try {
      var result = await LoginDao.registration(userName!, password!);
      if (result["code"] == 0) {
        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin();
        }
      } else {
        print(result['msg']);
      }
    } on HiNetError catch (e) {
      Log.info("$e", StackTrace.current);
    } catch (e) {
      Log.info("$e", StackTrace.current);
    }

    print("no empt");
  }
}
