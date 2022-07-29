// 网络异常基类
class HiNetError implements Exception {
  late final int code;
  late final String message;
  final dynamic? data;

  HiNetError(this.code,this.message,{this.data});
}

// login error
class NeedLogin extends HiNetError {
  NeedLogin({int code: 401, String message: "请先登陆"}) : super(code, message);
}

// auth error
class NeedAuth extends HiNetError {
  NeedAuth(String message, {int code: 403, dynamic data}): super(code,message,data: data);
}