
// 單個數 => 萬
String countFormat(int count) {
  String views  = "";
  if (count > 9999) {
    views = "${(count/10000).toStringAsFixed(2)}萬";
  }else {
    views = count.toString();
  }

  return views;
}

// 時間轉換為分鐘或秒
String durationTransform(int seconds) {
  int m = (seconds/60).truncate();
  int s = seconds-m*60;
  if (s < 10) {
    return '$m:0$s';
  }

  return '$m:$s';
}