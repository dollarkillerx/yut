import 'package:dio/dio.dart';
import 'package:yut/http/core/hi_error.dart';
import 'package:yut/http/core/hi_net_adapter.dart';
import 'package:yut/http/request/base_request.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var options = Options(headers: request.header);
    Response? response;
    var error;

    try {
      switch (request.httpMethod()) {
        case HttpMethod.GET:
          response = await Dio().get(request.url(), options: options);
          break;
        case HttpMethod.POST:
          response = await Dio().post(
              request.url(), data: request.params, options: options);
          break;
        case HttpMethod.DELETE:
          response = await Dio().delete(
              request.url(), data: request.params, options: options);
          break;
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    } catch(e) {
      error = e;
    }

    if (error != null) {
      throw HiNetError(response?.statusCode ?? -1, error.toString(), data: await buildRes(response, request));
    }

    return buildRes(response, request);
  }

  ///构建HiNetResponse
  Future<HiNetResponse<T>> buildRes<T>(Response? response,
      BaseRequest request) {
    return Future.value(HiNetResponse(
      //?.防止response为空
        data: response?.data,
        request: request,
        statusCode: response?.statusCode ?? 0,
        // statusMessage: response?.statusMessage,
        extra: response));
  }
}