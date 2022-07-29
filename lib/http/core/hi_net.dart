import 'package:yut/http/core/hi_net_adapter.dart';
import 'package:yut/http/core/mock_adapter.dart';
import 'package:yut/http/request/base_request.dart';

import 'hi_error.dart';

class HiNet {
  HiNet._();

  static bool _debug = false;
  static HiNet? _instance;

  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }

    return _instance!;
  }

  Future<dynamic?> send<T>(BaseRequest request) async {
    request.addHeader("Authorization", "token");

    if (HiNet._debug) {
      print("Url: ${request.path()}");
      print("method: ${request.httpMethod()}");
      print("header: ${request.header}");
    }

    HiNetAdapter adapter = MockAdapter();
    return adapter.send(request);
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch(e)  {
      error = e;
      response = e.data;
      print(e.message);
    } catch (e) {
      // 其他异常
      error = e;
      print(e);
    }
    
    if (response == null) {
      print(error);
      return null;
    }

    var result = response.data;
    print(result);

    var status = response.statusCode;
    switch (status) {
      case 200:
        return response;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(),data: result);
      default:
        throw HiNetError(status, result.toString(),data: result);
    }
  }
}
