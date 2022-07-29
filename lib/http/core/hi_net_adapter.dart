import 'dart:convert';

import 'package:yut/http/request/base_request.dart';

// 网络请求抽象类
abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

// 同意返回格式
class HiNetResponse<T> {
  T? data;  // data
  late BaseRequest request;
  late int statusCode;
  String? statusMessage;
  dynamic extra; // 其他数据

  HiNetResponse(
  {this.data, required this.request, required this.statusCode, this.statusMessage, this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }

    return data.toString();
  }
}