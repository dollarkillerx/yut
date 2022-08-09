import 'package:flutter/material.dart';
import 'package:yut/common/entity/banner.dart';
import 'package:yut/core/hi_state.dart';
import 'package:yut/widget/hi_banner.dart';
import '../common/entity/video.dart';
import '../common/logs/logs.dart';
import '../common/utils/toast.dart';
import '../http/dao/tops.dart';
import '../http/request/base_request.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  final String topic;

  const HomeTabPage({Key? key, required this.name, required this.topic})
      : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends HiState<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  var isLoad = true;
  List<VideoItem>? videoList;
  String? nextToken;

  var bannerList = [
    BannerMo(
        title: "にほんだいがく",
        img: "https://www.nihon-u.ac.jp/uploads/images/20220415185608.jpg",
        url: "https://www.nihon-u.ac.jp/"
    ),
    BannerMo(
        title: "とうようだいがく",
        img: "https://www.toyo.ac.jp/-/media/Images/Toyo/pickup/menu/enryo-coffee.ashx",
        url: "https://www.toyo.ac.jp/"
    ),
    BannerMo(
        title: "せんしゅうだいがく",
        img: "https://www.senshu-u.ac.jp/albums/9/abm00001213.png",
        url: "https://www.senshu-u.ac.jp/"
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    await this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _view(),
    );
  }

  _view() {
    if (this.isLoad) {
      return CircularProgressIndicator(
        color: Colors.cyan,
      );
    } else {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          child: _showB(),
        ),
      );
    }

    // ListView(
    //   // children: [if (widget.bannerList != null) _banner()],
    //   children: [_banner()],
    // )
    //   return ListView.builder(
    //       padding: EdgeInsets.all(10),
    //       shrinkWrap: true,
    //       itemCount: this.videoList?.length,
    //       itemBuilder: (context, index) {
    //         return ListTile(
    //           title: Image.network(
    //               "https://ggapi.mechat.live/api/v1/asset/${this.videoList![index].img}?token=${LoginDao.getBoardingPass()}"),
    //           subtitle: Text(this.videoList![index].title!),
    //         );
    //       });
    // }
  }

  _showA() {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          // QuiltedGridTile(1, 1),
          // QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Tile(index: index),
      ),
    );
  }

  _showB() {
    return SingleChildScrollView(
      /// 滚动控制器实现瀑布流
      // controller: _scrollController,
      /// 默认行为是，当列表高度不足以占满屏幕的时候，下拉刷新和瀑布流均失效
      /// 所以这里应该设置  始终允许刷新
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      /// VERY IMPOARTANT
      /// 引入插件 StaggeredGrid(0.6.1) 的使用
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        /// 列表滚动方向 默认向下
        axisDirection: AxisDirection.down,
        /// 由于选择了向下的列表方向，所以主轴上 item 间距是指 垂直方向上的边距
        mainAxisSpacing: 4,
        /// 由于选择了向下的列表方向，所以辅轴上 item 间距是指 水平方向上的边距
        crossAxisSpacing: 4,
        children: [
          /// VERY IMPOARTANT  StaggeredGridTile.fit
          /// 是指 不指定主轴方向该item占用的 单元格数目，而是由它自己设定的高度撑开
          /// Creates a [StaggeredGrid]'s tile that fits its main axis extent to its [child]'s content

          /// 如果存在banner，则 第一个item位置显示banner (HomePage 的 tab级别页面 切换栏)
          StaggeredGridTile.fit(
              crossAxisCellCount: 2,
              child: _banner(),
          ),

          // StaggeredGridTile.count(
          //   crossAxisCellCount: 2,
          //   mainAxisCellCount: 1,
          //   child: Tile(index: 1),
          // ),
          // StaggeredGridTile.count(
          //   crossAxisCellCount: 1,
          //   mainAxisCellCount: 1,
          //   child: Tile(index: 2),
          // ),
          // StaggeredGridTile.count(
          //   crossAxisCellCount: 1,
          //   mainAxisCellCount: 1,
          //   child: Tile(index: 3),
          // ),
        ],
      ),
    );
  }

  _loadData() async {
    setState(() {
      this.isLoad = false;
    });
    return;
    try {
      var result = await TopsDao.videos(topic: widget.topic);
      var err = NetTools.CheckError(result);
      if (err != null) {
        showWarnToast("$err");
        return;
      }
      VideoList loginResp = VideoList.fromJson(result);
      setState(() {
        nextToken = loginResp.data!.nextToken;
        videoList = loginResp.data!.item;
        isLoad = false;
      });
    } catch (e) {
      Log.info("$e", StackTrace.current);
      showWarnToast("$e");
      setState(() {
        isLoad = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(bannerList: [
        BannerMo(
            title: "にほんだいがく",
            img: "https://www.nihon-u.ac.jp/uploads/images/20220415185608.jpg",
            url: "https://www.nihon-u.ac.jp/"
        ),
        BannerMo(
            title: "とうようだいがく",
            img: "https://www.toyo.ac.jp/-/media/Images/Toyo/pickup/menu/enryo-coffee.ashx",
            url: "https://www.toyo.ac.jp/"
        ),
        BannerMo(
            title: "せんしゅうだいがく",
            img: "https://www.senshu-u.ac.jp/albums/9/abm00001213.png",
            url: "https://www.senshu-u.ac.jp/"
        ),
      ]),
    );
  }
}
const _defaultColor = Color(0xFF34568B);
class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? _defaultColor,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
