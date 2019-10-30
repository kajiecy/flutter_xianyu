import 'package:flutter/material.dart';
import 'package:xianyu_app/model/BannerInfo.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xianyu_app/service/http_request.dart';

// 首页轮播
class SwiperDiv extends StatelessWidget {
  final List<BannerInfo> bannerInfoList;

  const SwiperDiv({this.bannerInfoList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Image.network(
              "${qiniuUrl + bannerInfoList[index].image}",
              fit: BoxFit.fill,
            ),
            onTap: () {
              print('index is ${index}');
            },
          );
        },
        itemCount: bannerInfoList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}