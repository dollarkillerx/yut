import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';
import 'package:yut/common/color/color.dart';
import 'package:yut/common/navigator/hi_navigator.dart';
import 'package:yut/page/home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late RouteChangeListener listener;
  var tabs = ["推薦", "熱門", "追番", "影視", "搞笑", "日常", "綜合", "手機游戲"];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // tabController 需要 with TickerProviderStateMixin
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    HiNavigator.getInstance().addListener(listener = (current, pre) {
      print('current: ${current.page}');
      print('pre: ${pre?.page}');

      if (current.page == widget || current is HomePage) {
        print("打開首頁了: onResume");
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print("打開首頁了: onPause");
      }
    });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: _tabBar(),
          ),
          Flexible(
              child: TabBarView(
            controller: _tabController,
            children: tabs.map((e) {
              return HomeTabPage(name: e);
            }).toList(),
          ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      // 是否可以滾動
      labelColor: Colors.black,
      indicator: UnderlineIndicator(
        strokeCap: StrokeCap.round,
        borderSide: BorderSide(color: primary, width: 3),
        insets: EdgeInsets.only(left: 15, right: 15),
      ),
      // 圓角指示器
      tabs: tabs.map<Tab>((tab) {
        return Tab(
            child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(
            tab,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ));
      }).toList(),
    );
  }
}
