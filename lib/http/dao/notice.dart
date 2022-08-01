import 'package:yut/common/logs/logs.dart';
import 'package:yut/http/core/hi_net.dart';
import 'package:yut/http/request/notice.dart';

class NoticeDao {
  static notice(int pageIndex,int pageSize) async {
    if (pageIndex == 0) {
      pageIndex = 1;
    }
    if (pageSize>20 || pageSize <= 0) {
      pageSize = 20;
    }

    var request = NoticeRequest();
    request.query("pageIndex", pageIndex);
    request.query("pageSize", pageSize);
    request.addHeader("asdasd", "asdasd");
    var result = await HiNet.getInstance().fire(request);
    if (result['code'] == 0 && result['data'] != null) {
      Log.info("$result");
    }

    return result;
  }
}