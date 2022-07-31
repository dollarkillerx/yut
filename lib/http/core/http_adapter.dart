import 'package:yut/http/request/base_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'hi_error.dart';
import 'hi_net_adapter.dart';

class HttpAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    http.Response? response;
    var error;

    try {
      switch (request.httpMethod()) {
        case HttpMethod.GET:
          response = await http.get(request.uri(),headers: request.header);
          break;
        case HttpMethod.POST:
          response = await http.post(request.uri(),body: request.params,headers: request.header,);
          break;
        case HttpMethod.DELETE:
          response = await http.delete(request.uri(),body: request.params,headers: request.header);
          break;
      }
    }on http.ClientException catch(e) {
      error = e;
    } catch(e) {
      error = e;
    }

    if (error != null) {
      throw HiNetError(response?.statusCode ?? -1, error.toString(), data: await buildRes(response, request));
    }

    return buildRes(response, request);
  }

  ///构建HiNetResponse
  Future<HiNetResponse<T>> buildRes<T>(http.Response? response,
      BaseRequest request) {
    return Future.value(HiNetResponse(
        data: response != null?convert.jsonDecode(response.body):null,
        request: request,
        statusCode: response?.statusCode ?? 0,
        extra: response));
  }
}