//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_easyrefresh/easy_refresh.dart';
//import 'package:flutter_easyrefresh/phoenix_header.dart';
//
//import 'package:xianyu_app/service/http_request.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
//import 'package:xianyu_app/model/BannerInfo.dart';
//
//class HomeMain extends StatefulWidget {
//  _HomeMainState createState() => _HomeMainState();
//}
//
//class _HomeMainState extends State<HomeMain> with SingleTickerProviderStateMixin {
//  ScrollController _scrollViewController;
//  List<BannerInfo> bannerInfoList = [];
//  @override
//  void initState() {
//    super.initState();
//    _scrollViewController = ScrollController(initialScrollOffset: ScreenUtil().setHeight(0));
//  }
//
//  @override
//  void dispose() {
//    _scrollViewController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
////    this.bannerInfoList = this.getBannerList();
//    return
//      FutureBuilder(
//          future:HttpRequest().getSwiperList(),
//          builder: (context,snapshot){
//            if(snapshot.hasData){
//              this.bannerInfoList = snapshot.data;
//              return Container(
//                height: ScreenUtil().setHeight(1300),
//                child: Scaffold(
//                  body: NestedScrollView(
//                    controller: _scrollViewController,
//                    headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
//                      return <Widget>[
//                        HomeHeader(boxIsScrolled),
//                      ];
//                    },
//                    // 首页下拉刷新页面
//                    body: EasyRefresh(
//                      child: ListView(
//                        children: <Widget>[
//                          SwiperDiv(bannerInfoList:this.bannerInfoList),
//                        ],
//                      ),
//                      bottomBouncing: false,
//                      onRefresh: () async {
//                        print('触发onRefresh');
//                      },
//                      header: PhoenixHeader(),
//                    ),
//                  ),
//                ),
//              );
//            }else{
//              return Center(
//                child: Text('没有数据'),
//              );
//            }
//          }
//      );
//  }
//  Future initData() async{
//    this.bannerInfoList =await HttpRequest().getSwiperList();
//    return 'ok';
//  }
//}
//// 首页的头部搜索框
//class HomeHeader extends StatelessWidget {
//  final bool boxIsScrolled;
//  HomeHeader(this.boxIsScrolled);
//  @override
//  Widget build(BuildContext context) {
//    return SliverAppBar(
//        title: Container(
//          padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
//          color: Color(0xffFBFBFB),
//          child: new TextField(
//            decoration: InputDecoration(
//              contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(15.0)),
//              hintText: '输入标题或内容',
//              hintStyle: TextStyle(
//                  color: Color(0xffC8C8C7),
//                  fontSize: ScreenUtil().setSp(32)),
//              prefixIcon: Icon(
//                Icons.search,
//                color: Color(0xffCACACB),
//                size: ScreenUtil().setSp(60),
//              ),
//              border: OutlineInputBorder(
//                  borderRadius:
//                  BorderRadius.circular(ScreenUtil().setSp(60)),
//                  borderSide: BorderSide.none),
//              filled: true,
//              fillColor: Color(0xffF4F4F4),
//            ),
//          ),
//        ),
//        pinned: true,
//        floating: true,
//        forceElevated: boxIsScrolled,
//        expandedHeight: ScreenUtil().setHeight(110),
//        flexibleSpace: Container(
//          color: Colors.white,
//        ),
//        bottom: PreferredSize(
//            child: Container(), preferredSize: Size(0, 0)));
//  }
//}
//
//// 首页轮播
//class SwiperDiv extends StatelessWidget {
//  final List<BannerInfo> bannerInfoList;
//  const SwiperDiv({this.bannerInfoList});
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: ScreenUtil().setHeight(320),
//      width: ScreenUtil().setWidth(750),
//      child: Swiper(
//        itemBuilder: (BuildContext context, int index) {
//          return InkWell(child: Image.network("${qiniuUrl+bannerInfoList[index].image}", fit: BoxFit.fill,),
//            onTap: () {
////              Application.router.navigateTo(context, '/detail?id=${swiperDataList[index]['goodsId']}');
//            },
//          );
//        },
//        itemCount: bannerInfoList.length,
//        pagination: SwiperPagination(),
//        autoplay: true,
//      ),
//    );
//  }
//}
//// 今日选文
