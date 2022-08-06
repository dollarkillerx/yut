class CaptchaEntity {
  String? requestId;
  String? code;
  Data? data;

  CaptchaEntity({this.requestId, this.code, this.data});

  CaptchaEntity.fromJson(Map<String, dynamic> json) {
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
  String? base64Captcha;
  String? captchaId;

  Data({this.base64Captcha, this.captchaId});

  Data.fromJson(Map<String, dynamic> json) {
    base64Captcha = json['base64_captcha'];
    captchaId = json['captcha_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base64_captcha'] = this.base64Captcha;
    data['captcha_id'] = this.captchaId;
    return data;
  }
}
