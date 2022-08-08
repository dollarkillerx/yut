import 'package:flutter/material.dart';

// 一面狀態異常管理
abstract class HiState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    // 防止頁面已經刪除了也執行改操作
    if (mounted) {
      super.setState(fn);
    }else {
      print("HiState: 頁面已經 銷毀 本次setState 不執行: ${toString()}");
    }
  }
}