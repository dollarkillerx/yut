import 'package:yut/common/entity/basic_resp.dart';
import 'package:yut/common/logs/logs.dart';
import 'package:yut/http/dao/login.dart';

enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  Map<String, dynamic> queryParameters = {}; // query
  Map<String, dynamic> params = {}; // data
  Map<String, String> header = {}; // header
  bool neeLogin();

  var userHttps = true;

  String authority() {
    return "ggapi.mechat.live";
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

    return ui;
  }

  String url() {
    Log.info(uri().toString(), StackTrace.current);
    return uri().toString();
  }

  // add params
  BaseRequest add(String k, dynamic v) {
    params[k] = v;
    return this;
  }

  // set params
  BaseRequest setParam(Map<String, dynamic> v) {
    params = v;
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

class NetTools {
  static String? CheckError(Map<String, dynamic> postsJson) {
    BasicResp posts = BasicResp.fromJson(postsJson);
    if (posts.code != "0") {
      return posts.message;
    }
    return null;
  }
}