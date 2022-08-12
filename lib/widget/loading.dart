import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingContainer extends StatelessWidget{
  final Widget child;
  final bool isLoading;
  // 加載動畫是否覆蓋在原有界面上
  final bool cover;

  LoadingContainer({Key? key,required this.child, required this.isLoading, this.cover = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [
          child, this.isLoading?_loadingView:Container()
        ],
      );
    }else {
      print(this.isLoading);
      return this.isLoading?_loadingView:child;
    }
  }


  Widget get _loadingView {
    return Center(
      child: Lottie.asset('assets/loading_v1.json'),
    );
  }
}
