import 'package:yut/common/local_storage/hi_cache.dart';
import 'package:yut/http/core/hi_net.dart';
import 'package:yut/http/request/login_request.dart';
import 'package:yut/http/request/registration.dart';
import '../request/base_request.dart';

class LoginDao {
  static const BOARDING_PASS = "boarding-pass";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(String userName, String password) {
    return _send(userName, password, isLogin: false);
  }

  static _send(String userName, String password, {bool isLogin = true}) async {
    BaseRequest request;

    if (isLogin) {
      request = LoginRequest();
      request.query("userName", userName);
      request.query("password", password);
    } else {
      request = RegistrationRequest();
      request.query("imoocId", "2317968");
      request.query("orderId", "2207291029356428");
      request.query("userName", userName);
      request.query("password", password);
    }
    request.query("course-flag", "fa");
    request.query("courseFlag", "fa");
    var result = await HiNet.getInstance().fire(request);
    if (result['code'] == 0 && result['data'] != null) {
      // save token
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }

    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().getString(BOARDING_PASS);
  }
}

// WorldLink,
