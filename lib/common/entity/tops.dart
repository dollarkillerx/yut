class Tops {
  String? requestId;
  String? code;
  List<TopsItem>? data;

  Tops({this.requestId, this.code, this.data});

  Tops.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    code = json['code'];
    if (json['data'] != null) {
      data = <TopsItem>[];
      json['data'].forEach((v) {
        data!.add(new TopsItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopsItem {
  String? name;
  String? key;

  TopsItem({this.name, this.key});

  TopsItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['key'] = this.key;
    return data;
  }
}
