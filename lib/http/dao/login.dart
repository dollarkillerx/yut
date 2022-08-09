import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yut/common/entity/registry.dart';
import 'package:yut/common/local_storage/hi_cache.dart';
import 'package:yut/common/logs/logs.dart';
import 'package:yut/http/core/hi_net.dart';
import 'package:yut/http/request/captcha.dart';
import 'package:yut/http/request/login_request.dart';
import '../../common/entity/login.dart';
import '../../common/entity/captcha.dart';
import '../request/base_request.dart';
import '../request/registration.dart';

class LoginDao {
  static const BOARDING_PASS = "Authorization";

  static login(String captchaID, String captchaCode, String account, String password) async {
    var request = LoginRequest();
    LoginRequestEntity loginRequest = LoginRequestEntity(
      captchaId: captchaID,
      captchaCode: captchaCode,
      account: account,
      password: password,
    );
    request.setParam(loginRequest.toJson());

    var result = await HiNet.getInstance().fire(request);

    return result;
  }

  static registration(String captchaID, String captchaCode, String account, String password,String name) async {
    var request = RegistrationRequest();
    RegistryRequestEntity regRequest = RegistryRequestEntity(
      captchaId: captchaID,
      captchaCode: captchaCode,
      account: account,
      password: password,
      name: name,
    );
    request.setParam(regRequest.toJson());

    var result = await HiNet.getInstance().fire(request);
    return result;
  }

  static Future<CaptchaEntity?> captcha() async {
    var request = Captcha();

    try {
      var result = await HiNet.getInstance().fire(request);
      var err = NetTools.CheckError(result);
      if (err != null) {
        SmartDialog.showToast(err);
      }

      CaptchaEntity cap = CaptchaEntity.fromJson(result);
      return cap;
    }catch (e) {
      SmartDialog.showToast("$e");
    }

    return null;
  }

  static getBoardingPass() {
    return HiCache.getInstance().getString(BOARDING_PASS);
  }
}

