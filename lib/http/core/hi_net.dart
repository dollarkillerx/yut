import 'package:yut/http/core/dio_adapter.dart';
import 'package:yut/http/core/hi_net_adapter.dart';
import 'package:yut/http/request/base_request.dart';
import '../../common/logs/logs.dart';
import 'hi_error.dart';

class HiNet {
  HiNet._();

  static bool _debug = true;
  static HiNet? _instance;

  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }

    return _instance!;
  }

  Future<dynamic?> send<T>(BaseRequest request) async {
    request.addHeader("auth-token", "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa");
    request.addHeader("course-flag","fa");

    if (HiNet._debug) {
      Log.info("Url: ${request.path()}", StackTrace.current);
      Log.info("method: ${request.httpMethod()}", StackTrace.current);
      Log.info("header: ${request.header}", StackTrace.current);
    }

    HiNetAdapter adapter = DioAdapter();
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
      Log.warning("${e.message}", StackTrace.current);
    } catch (e) {
      // 其他异常
      error = e;
      Log.warning("$e", StackTrace.current);
    }
    
    if (response == null) {
      Log.warning("$error", StackTrace.current);
    }

    var result = response?.data;

    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        if (result != null) {
          throw NeedAuth(result.toString(), data: result);
        }else {
          throw NeedAuth("403", data: result);
        }
      default:
        if (result != null) {
          throw HiNetError(status ?? -1, result.toString(), data: result);
        }else {
          throw HiNetError(status ?? -1, "", data: result);
        }
    }
  }
}
