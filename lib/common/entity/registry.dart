class RegistryRequestEntity {
  String? captchaId;
  String? captchaCode;
  String? account;
  String? name;
  String? password;

  RegistryRequestEntity(
      {this.captchaId,
        this.captchaCode,
        this.account,
        this.name,
        this.password});

  RegistryRequestEntity.fromJson(Map<String, dynamic> json) {
    captchaId = json['captcha_id'];
    captchaCode = json['captcha_code'];
    account = json['account'];
    name = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['captcha_id'] = this.captchaId;
    data['captcha_code'] = this.captchaCode;
    data['account'] = this.account;
    data['name'] = this.name;
    data['password'] = this.password;
    return data;
  }
}
