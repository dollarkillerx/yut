import 'package:flutter/material.dart';
import 'package:yut/common/entity/captcha.dart';
import 'package:yut/common/utils/img.dart';
import 'package:yut/common/utils/toast.dart';
import '../common/entity/login.dart';
import '../common/local_storage/hi_cache.dart';
import '../common/logs/logs.dart';
import '../common/utils/strings.dart';
import '../http/dao/login.dart';
import '../http/request/base_request.dart';
import '../widget/LOGIN_EFFECT.dart';
import '../widget/appbar.dart';
import '../widget/login_button.dart';
import '../widget/login_input.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onJumpRegistration;
  final VoidCallback? onSuccess;


  const LoginPage({Key? key, this.onJumpRegistration,this.onSuccess}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false; // 保護 儅輸入密碼的時候 導航圖片顯示
  bool loginEnable = false; // 參數校驗完畢 可登錄
  String? account;
  String? password;
  String? captcha;
  String? captchaID;
  String? captchaImage;

  @override
  void initState() {
    super.initState();
    // 初始化后加載
    WidgetsBinding.instance.addPostFrameCallback((_){
      onInit();
    });
  }

  onInit() async {
    CaptchaEntity? cap =  await LoginDao.captcha();
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
      appBar: appBar("登錄", "注冊", () {
        print("object");
        if (widget.onJumpRegistration != null) {
          widget.onJumpRegistration!();
        }
        // widget.onJumpRegistration??widget.onJumpRegistration!();
      }),
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
                account = text;
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
                child: (){
                  if (this.captchaImage != null) {
                    return InkWell(
                      child: imageFromBase64String(this.captchaImage!),
                      onTap: () async {
                        await upImg();
                      },
                    );
                  }
                  return Container();
                }(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton('登錄',
                  enable: loginEnable, onPressed: checkParams),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(account) &&
        isNotEmpty(password) && isNotEmpty(captcha)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  upImg() async {
    CaptchaEntity? cap =  await LoginDao.captcha();
    if (cap != null) {
      setState(() {
        captchaImage = cap.data!.base64Captcha!;
        captchaID = cap.data!.captchaId!;
      });
    }
  }

  checkParams() async {
    try {
      var result = await LoginDao.login(captchaID!, captcha!, account!, password!);
      var err = NetTools.CheckError(result);
      if (err != null) {
        showWarnToast("$err");
        await upImg();
        return;
      }

      Log.info("$result",StackTrace.current);
      LoginResponseEntity loginResp = LoginResponseEntity.fromJson(result);
      print(loginResp.toJson());

      HiCache.getInstance().setString(LoginDao.BOARDING_PASS, loginResp.data!.jwt!);
      showToast("Login Success");
      if (widget.onSuccess != null) {
        widget.onSuccess!();
      }
    }catch (e) {
      Log.info("$e",StackTrace.current);
      await upImg();
      showWarnToast("$e");
    }
  }
}


