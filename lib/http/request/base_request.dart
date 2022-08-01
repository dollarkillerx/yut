import 'package:yut/common/logs/logs.dart';
import 'package:yut/http/dao/login.dart';

enum HttpMethod { GET, POST, DELETE }

// https://api.devio.org/uapi/swagger-ui.html

abstract class BaseRequest {
  Map<String, dynamic> queryParameters = {}; // query
  Map<String, String> params = {}; // data
  Map<String, String> header = {}; // header
  bool neeLogin();

  var userHttps = true;

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  Uri uri() {
    Uri ui;
    var pathStr = path();
    if (pathStr != "") {
      if (path().endsWith("/")) {
        pathStr = pathStr;
      } else {
        pathStr = "/$pathStr";
      }
    }

    if (userHttps) {
      ui = Uri.https(authority(), pathStr, queryParameters);
    } else {
      ui = Uri.http(authority(), pathStr, queryParameters);
    }

    if (neeLogin()) {
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
      Log.info("$header");
    }

    query("course-flag", "fa");
    query("courseFlag", "fa");

    return ui;
  }

  String url() {
    Log.info(uri().toString(), StackTrace.current);
    return uri().toString();
  }

  // add params
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  // add params
  BaseRequest query(String k, Object v) {
    queryParameters[k] = v.toString();
    return this;
  }

  // add header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
