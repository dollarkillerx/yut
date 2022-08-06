import 'package:yut/http/request/base_request.dart';

class Captcha extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool neeLogin() {
    return false;
  }

  @override
  String path() {
    return "api/v1/captcha";
  }
}