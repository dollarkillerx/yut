import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  late SharedPreferences? prefs;

  static HiCache? _instance;


  HiCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  // 預初始化,防止調用時prefs還未初始化
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  static HiCache getInstance()  {
    if (_instance == null) {
      HiCache._();
    }

    return _instance!;
  }

  HiCache._() {
    init();
  }

  init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    prefs!.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs!.setDouble(key, value);
  }

  setBool(String key, bool value) {
    prefs!.setBool(key, value);
  }

  setInt(String key, int value) {
    prefs!.setInt(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs!.setStringList(key, value);
  }

  /// 获取返回为bool的内容
  Future<bool?> getBool(String key) async {
    bool? value = prefs!.getBool(key);
    return value;
  }

  /// 获取返回为double的内容
  Future<double?> getDouble(String key) async {
    double? value = prefs!.getDouble(key);
    return value;
  }

  /// 获取返回为int的内容
  Future<int?> getInt(String key) async {
    int? value = prefs!.getInt(key);
    return value;
  }

  /// 获取返回为String的内容
  Future<String?> getString(String key) async {
    String? value = prefs!.getString(key);
    return value;
  }

  /// 获取返回为StringList的内容
  Future<List<String>?> getStringList(String key) async {
    List<String>? value = prefs!.getStringList(key);
    return value;
  }

  /// 移除单个
  remove(String key) async {
    await prefs!.remove(key);
  }

  /// 清空所有
  clear() async {
    await prefs!.clear();
  }
}