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
    _instance ??= HiNet._();

    return _instance!;
  }

  Future<dynamic?> send<T>(BaseRequest request) async {

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
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      Log.warning(e.message);
    } catch (e) {
      //其它异常
      error = e;
      Log.warning("$e");
    }
    if (response == null) {
      Log.warning("$error");
    }
    var result = response?.data;
    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status ?? -1, result.toString(), data: result);
    }
  }
}
