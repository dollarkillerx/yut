enum HttpMethod { GET, POST, DELETE }

// https://api.devio.org/uapi/swagger-ui.html

abstract class BaseRequest {
  Map<String, dynamic>? queryParameters;
  var userHttps = true;

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathStr != "") {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathStr";
      } else {
        pathStr = "${path()}/$pathStr";
      }
    }

    if (userHttps) {
      uri = Uri.https(authority(), pathStr, queryParameters);
    } else {
      uri = Uri.http(authority(), pathStr, queryParameters);
    }

    return uri.toString();
  }

  bool neeLogin();

  // add params
  Map<String,String> params = {};
  BaseRequest add(String k,Object v) {
    params[k] = v.toString();
    return this;
  }

  // add header
  Map<String, dynamic> header = {};
  BaseRequest addHeader(String k,Object v) {
    header[k] = v.toString();
    return this;
  }
}