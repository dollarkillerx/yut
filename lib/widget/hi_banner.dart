import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:yut/common/navigator/hi_navigator.dart';
import '../common/entity/banner.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double height;
  final EdgeInsetsGeometry? padding;

  const HiBanner({Key? key, required this.bannerList, this.height = 160, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal??0)/2;

        return Swiper(
          itemCount: bannerList.length,
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {

              },
              child: _image(bannerList[index]),
            );
          },
          pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(right: right,bottom: 10),
            builder: DotSwiperPaginationBuilder(
              color: Colors.white60,
              size: 6,
              activeSize: 6,
            )
          ),
        );
  }

  _image(BannerMo bannerMo) {
    return InkWell(
      onTap: () {
        _handleClick(bannerMo);
        print("on tap: ${bannerMo.title}");
      },
      child: Container(
        padding: padding,
        child: ClipRRect( // 圓角
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: Image.network(bannerMo.img!,fit: BoxFit.cover,),
        ),
      ),
    );
  }

  void _handleClick(BannerMo bannerMo) {
    switch (bannerMo.type) {
      case "video":
        HiNavigator.getInstance().onJumpTo(RouteStatus.detail,args: {"video": bannerMo.url});
        break;
      default:
        print("todo");
    }
  }
}
