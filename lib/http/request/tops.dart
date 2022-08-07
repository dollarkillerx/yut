import 'base_request.dart';

class TopsRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool neeLogin() {
    return true;
  }

  @override
  String path() {
    return "api/v1/internal/topic";
  }
}

class TopsVideos extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool neeLogin() {
    return true;
  }

  @override
  String path() {
    return "api/v1/internal/video_list";
  }
}