import 'package:yut/http/core/hi_net_adapter.dart';
import 'package:yut/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(
          request: request,
          statusCode: 200,
          data: {"code": 0, "message": 'success'} as T);
    });
  }
}
