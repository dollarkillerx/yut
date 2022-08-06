import 'package:yut/http/request/base_request.dart';

class LoginRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool neeLogin() {
    return false;
  }

  @override
  String path() {
    return "api/v1/login";
  }
}