import 'package:flutter/material.dart';
import 'package:yut/common/color/color.dart';
import 'package:yut/common/navigator/hi_navigator.dart';
import 'package:yut/page/favorite.dart';
import 'package:yut/page/home.dart';
import 'package:yut/page/prfile.dart';
import 'package:yut/page/ranking.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defalutColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;
  static int initialPage = 0;
  final PageController _controller = PageController(initialPage: initialPage);
  late List<Widget> _pages;
  bool _hasBuild = false;

  @override
  Widget build(BuildContext context) {
    _pages = [
      HomePage(),
      RankingPage(),
      FavoritePage(),
      ProfilePage(),
    ];

    // 地面第一次打開時 通知是哪一個 tab
    if (!_hasBuild) {
      HiNavigator.getInstance().onBottomTabChange(initialPage, _pages[initialPage]);
      _hasBuild = true;
    }

    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          HomePage(),
          RankingPage(),
          FavoritePage(),
          ProfilePage(),
        ],
        onPageChanged: (index)=>_onJumpTo(index,pageChange: true),
        physics: NeverScrollableScrollPhysics(), // 禁止滾動
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index)=>_onJumpTo(index),
        selectedItemColor: _activeColor,
        items: [
          _bottomItem('Home', Icons.home, 0),
          _bottomItem('Ranking', Icons.local_fire_department_rounded, 1),
          _bottomItem('Favorite', Icons.favorite, 2),
          _bottomItem('My', Icons.live_tv, 3),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _defalutColor,
      ),
      activeIcon: Icon(
        icon,
        color: _activeColor,
      ),
      label: title,
    );
  }

  void _onJumpTo(int index,{pageChange=false}) {
    if (!pageChange) {
      _controller.jumpToPage(index);
    }else {
      HiNavigator.getInstance().onBottomTabChange(index, _pages[index]);
    }
    setState(() {
      _currentIndex = index;
    });
  }
}
