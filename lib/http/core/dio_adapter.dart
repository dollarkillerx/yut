import 'package:dio/dio.dart';
import 'package:yut/http/core/hi_error.dart';
import 'package:yut/http/core/hi_net_adapter.dart';
import 'package:yut/http/request/base_request.dart';

import '../../common/logs/logs.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var options = Options(headers: request.header);
    Response? response;
    var error;
    Log.info("hello world 1111qewe1",StackTrace.current);

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
      Log.info("hello world 1111qeddddsfsdfwe1",StackTrace.current);
      error = e;
      response = e.response;
    }

    Log.info("hello world 11111",StackTrace.current);

    if (error != null) {
      Log.info("hello world 11111============ ${error}",StackTrace.current);
      throw HiNetError(response?.statusCode ?? -1, error.toString(), data: await buildRes(response, request));
    }

    Log.info("hello world 111112",StackTrace.current);


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
        statusMessage: response?.statusMessage,
        extra: response));
  }
}