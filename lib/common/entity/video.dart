class VideoModel {
  int vid;

  VideoModel(this.vid);
}

class SearchVideo {
  String? keyword;
  String? topic;
  String? pageToken;

  SearchVideo({this.keyword, this.topic, this.pageToken});

  SearchVideo.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    topic = json['topic'];
    pageToken = json['page_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyword'] = this.keyword;
    data['topic'] = this.topic;
    data['page_token'] = this.pageToken;
    return data;
  }
}

class VideoList {
  String? requestId;
  String? code;
  VideoItemData? data;

  VideoList({this.requestId, this.code, this.data});

  VideoList.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    code = json['code'];
    data = json['data'] != null ? new VideoItemData.fromJson(json['data']) : null;
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

class VideoItemData {
  List<VideoItem>? item;
  String? nextToken;

  VideoItemData({this.item, this.nextToken});

  VideoItemData.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <VideoItem>[];
      json['item'].forEach((v) {
        item!.add(new VideoItem.fromJson(v));
      });
    }
    nextToken = json['next_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    data['next_token'] = this.nextToken;
    return data;
  }
}

class VideoItem {
  String? channelId;
  String? channelTitle;
  String? publishedAt;
  String? videoId;
  String? title;
  String? description;
  String? img;

  VideoItem(
      {this.channelId,
        this.channelTitle,
        this.publishedAt,
        this.videoId,
        this.title,
        this.description,
        this.img});

  VideoItem.fromJson(Map<String, dynamic> json) {
    channelId = json['channelId'];
    channelTitle = json['channelTitle'];
    publishedAt = json['publishedAt'];
    videoId = json['videoId'];
    title = json['title'];
    description = json['description'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelId'] = this.channelId;
    data['channelTitle'] = this.channelTitle;
    data['publishedAt'] = this.publishedAt;
    data['videoId'] = this.videoId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['img'] = this.img;
    return data;
  }
}

