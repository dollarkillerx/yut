class BannerMo {
  String? title;
  String? img;
  String? url;
  String? type;

  BannerMo({this.title, this.img, this.url, this.type});

  BannerMo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    img = json['img'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['img'] = this.img;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}
