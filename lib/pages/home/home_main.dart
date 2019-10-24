import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:xianyu_app/config/service_url.dart';
import 'package:xianyu_app/model/BannerInfo.dart';

class HomeMain extends StatefulWidget {
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: ScreenUtil().setHeight(120));
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.getBannerList();
    return Container(
      height: ScreenUtil().setHeight(1300),
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              HomeHeader(boxIsScrolled),
            ];
          },
          body: HomePageBody(),
        ),
      ),
    );
  }

  getBannerList() async {
    List<BannerInfo> bannerInfoList = await HttpRequest().getSwiperList();
    print('goodListStr ${bannerInfoList}');
  }
}
// 首页的头部搜索框
class HomeHeader extends StatelessWidget {
  final bool boxIsScrolled;
  HomeHeader(this.boxIsScrolled);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        title: Container(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: new TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: '输入标题或内容',
              hintStyle: TextStyle(
                  color: Color(0xffC8C8C7),
                  fontSize: ScreenUtil().setSp(32)),
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xffCACACB),
                size: ScreenUtil().setSp(60),
              ),
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(ScreenUtil().setSp(60)),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Color(0xffF4F4F4),
            ),
          ),
        ),
        pinned: true,
        floating: true,
        forceElevated: boxIsScrolled,
        expandedHeight: ScreenUtil().setHeight(120),
        flexibleSpace: Container(
          color: Colors.white,
        ),
        bottom: PreferredSize(
            child: Container(), preferredSize: Size(0, 0)));
  }
}


// 首页内容框架
class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      child: ListView(
        itemExtent: 250.0,
        children: <Widget>[
          Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(5.0),
            color: 1 % 2 == 0 ? Colors.cyan : Colors.deepOrange,
            child: Center(
              child: Text(1.toString()),
            ),
          ),
        ],
      ),
      bottomBouncing: false,
      onRefresh: () async {
        print('触发onRefresh');
      },
      header: PhoenixHeader(),
    );

//      ListView.builder(
//      itemExtent: 250.0,
//      itemBuilder: (context, index) => Container(
//        padding: EdgeInsets.all(10.0),
//        child: Material(
//          elevation: 4.0,
//          borderRadius: BorderRadius.circular(5.0),
//          color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
//          child: Center(
//            child: Text(index.toString()),
//          ),
//        ),
//      ),
//    );
  }
}
