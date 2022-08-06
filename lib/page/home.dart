import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/entity/video.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel>? onJumpToDetail;

  const HomePage({Key? key, this.onJumpToDetail}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("Home"),
            MaterialButton(child: Text("詳情"), onPressed: () {
              widget.onJumpToDetail!(VideoModel(111));
            })
          ],
        ),
      ),
    );
  }
}
