import 'package:flutter/material.dart';
import 'package:yut/http/core/hi_error.dart';
import 'package:yut/http/dao/login.dart';
import 'package:yut/widget/appbar.dart';
import 'package:yut/widget/login_input.dart';
import '../common/entity/captcha.dart';
import '../common/utils/img.dart';
import '../common/utils/strings.dart';
import '../widget/LOGIN_EFFECT.dart';
import '../widget/login_button.dart';

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
  String? account;
  String? password;
  String? rePassword;
  String? captcha;
  String? captchaID;
  String? captchaImage;

  @override
  void initState() {
    super.initState();
    // 初始化后加載
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onInit();
    });
  }

  onInit() async {
    CaptchaEntity? cap = await LoginDao.captcha();
    if (cap != null) {
      setState(() {
        captchaImage = cap.data!.base64Captcha!;
        captchaID = cap.data!.captchaId!;
      });
    }
  }

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
              title: "Account",
              hint: "請輸Account",
              onChanged: (text) {
                account = text;
                checkInput();
              },
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
            LoginInput(
              title: "驗證碼",
              hint: "請輸驗證碼",
              obscureText: false,
              onChanged: (text) {
                captcha = text;
                checkInput();
              },
              rightWidget: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10),
                child: () {
                  if (this.captchaImage != null) {
                    return InkWell(
                      child: imageFromBase64String(this.captchaImage!),
                      onTap: () async {
                        CaptchaEntity? cap = await LoginDao.captcha();
                        if (cap != null) {
                          setState(() {
                            captchaImage = cap.data!.base64Captcha!;
                            captchaID = cap.data!.captchaId!;
                          });
                        }
                      },
                    );
                  }
                  return Container();
                }(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton('注册',
                  enable: loginEnable, onPressed: checkParams),
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
        isNotEmpty(rePassword) &&
        isNotEmpty(captcha) &&
        isNotEmpty(account)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result = await LoginDao.registration(
          captchaID!, captcha!, userName!, password!, account!);
      print(result);
      if (result['code'] == 0) {
        print('注册成功');
        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin();
        }
      } else {
        print(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }

}
