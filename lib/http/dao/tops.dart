import '../../common/entity/video.dart';
import '../core/hi_net.dart';
import '../request/tops.dart';

class TopsDao {
  static tops() async {
    var request = TopsRequest();
    var result = await HiNet.getInstance().fire(request);
    return result;
  }

  static videos({String? keyword, String? topic, String? pageToken}) async {
    var request = TopsVideos();
    request.setParam(SearchVideo(
      keyword: keyword,
      topic: topic,
      pageToken: pageToken,
    ).toJson());
    var result = await HiNet.getInstance().fire(request);
    return result;
  }
}
