class LoginRequestEntity {
  String? captchaId;
  String? captchaCode;
  String? account;
  String? password;

  LoginRequestEntity({this.captchaId, this.captchaCode, this.account, this.password});

  LoginRequestEntity.fromJson(Map<String, dynamic> json) {
    captchaId = json['captcha_id'];
    captchaCode = json['captcha_code'];
    account = json['account'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['captcha_id'] = this.captchaId;
    data['captcha_code'] = this.captchaCode;
    data['account'] = this.account;
    data['password'] = this.password;
    return data;
  }
}

class LoginResponseEntity {
  String? requestId;
  String? code;
  Data? data;

  LoginResponseEntity({this.requestId, this.code, this.data});

  LoginResponseEntity.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? jwt;

  Data({this.jwt});

  Data.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    return data;
  }
}

