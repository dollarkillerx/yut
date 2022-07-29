import 'package:yut/http/request/base_request.dart';

class TestRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    throw HttpMethod.GET;
  }

  @override
  bool neeLogin() {
    return false;
  }

  @override
  String path() {
    return "/";
  }
}