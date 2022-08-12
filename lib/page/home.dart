import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';
import 'package:yut/common/color/color.dart';
import 'package:yut/common/navigator/hi_navigator.dart';
import 'package:yut/core/hi_state.dart';
import 'package:yut/page/home_tab.dart';
import 'package:yut/widget/loading.dart';
import '../common/entity/tops.dart';
import '../common/logs/logs.dart';
import '../common/utils/toast.dart';
import '../http/dao/tops.dart';
import '../http/request/base_request.dart';
import '../widget/navigation_bar.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumTo;
  const HomePage({Key? key, this.onJumTo}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late RouteChangeListener listener;
  List<TopsItem> tabs = [];
  TabController? _tabController;
  var isLoad = true;

  @override
  void initState() {
    super.initState();
    // tabController 需要 with TickerProviderStateMixin

    // HiNavigator.getInstance().addListener(listener = (current, pre) {
    //   print('current: ${current.page}');
    //   print('pre: ${pre?.page}');
    //
    //   if (current.page == widget || current is HomePage) {
    //     print("打開首頁了: onResume");
    //   } else if (widget == pre?.page || pre?.page is HomePage) {
    //     print("打開首頁了: onPause");
    //   }
    // });

    _asyncMethod();
  }

  _asyncMethod() async {
    try {
      var result = await TopsDao.tops();
      var err = NetTools.CheckError(result);
      if (err != null) {
        showWarnToast("$err");
        return;
      }
      Tops loginResp = Tops.fromJson(result);
      setState(() {
        tabs = loginResp.data!;
        _tabController = TabController(
          length: tabs.length,
          vsync: this,
        );

        isLoad = false;
      });
    } catch (e) {
      Log.info("$e", StackTrace.current);
      showWarnToast("$e");
    }
  }

  // @override
  // void dispose() {
  //   HiNavigator.getInstance().removeListener(listener);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: _view(),
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
            tab.name!,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ));
      }).toList(),
    );
  }

  _view() {
    return LoadingContainer(
      child: Column(
      children: [
        MyNavigationBar(
          height: 50,
          child: _appBar(),
          color: Colors.white,
          statusStyle: StatusStyle.DARK_CONTENT,
        ),
        Container(
          color: Colors.white,
          child: _tabBar(),
        ),
        Flexible(
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((e) {
                return HomeTabPage(
                  name: e.name!,
                  topic: e.key!,
                );
              }).toList(),
            ))
      ],
    ),
      isLoading: this.isLoad,);

    // if (isLoad) {
    //   return Center(
    //     child: CircularProgressIndicator(
    //       color: Colors.cyan,
    //     ),
    //   );
    // } else {
    //   return Column(
    //     children: [
    //       MyNavigationBar(
    //         height: 50,
    //         child: _appBar(),
    //         color: Colors.white,
    //         statusStyle: StatusStyle.DARK_CONTENT,
    //       ),
    //       Container(
    //         color: Colors.white,
    //         child: _tabBar(),
    //       ),
    //       Flexible(
    //           child: TabBarView(
    //         controller: _tabController,
    //         children: tabs.map((e) {
    //           return HomeTabPage(
    //             name: e.name!,
    //             topic: e.key!,
    //           );
    //         }).toList(),
    //       ))
    //     ],
    //   );
    // }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumTo != null) {
                print("on jumto");
                widget.onJumTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                width: 46,
                height: 46,
                image: AssetImage('images/avatar.png'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  decoration: BoxDecoration(color: Colors.grey[100]),
                ),
              ),
            ),
          ),
          Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
