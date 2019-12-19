import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:xianyu_app/routers/application.dart';

import 'package:xianyu_app/service/http_request.dart';

import 'package:xianyu_app/model/BannerInfo.dart';
import 'package:xianyu_app/model/TodayNews.dart';
import 'package:xianyu_app/model/IndexCategory.dart';
import 'package:xianyu_app/model/IndexExpert.dart';
import 'package:xianyu_app/model/IndexLesson.dart';

import 'swiper_div.dart';
import 'today_news_div.dart';
import 'index_category_div.dart';
import 'index_expert_div.dart';
import 'index_lesson_div.dart';

class HomeMain extends StatefulWidget {
  _HomeMainState createState() => _HomeMainState();
}
class _HomeMainState extends State<HomeMain>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  // banner信息
  List<BannerInfo> bannerInfoList = [];
  // 今日选文
  TodayNews todayNews = TodayNews();
  // 精选测评
  List<IndexCategory> categoryList = [];
  // 专家咨询
  List<IndexExpert> expertList = [];
  // 推荐课程
  List<IndexLesson> lessonList = [];
  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: ScreenUtil().setHeight(0));
  }
  @override
  void dispose() {
    _scrollViewController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
//    this.bannerInfoList = this.getBannerList();
    return FutureBuilder(
        future: initData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
//            this.bannerInfoList = snapshot.data;
            return Container(
              height: ScreenUtil().setHeight(1300),
              child: Scaffold(
                body: NestedScrollView(
                  controller: _scrollViewController,
                  headerSliverBuilder:(BuildContext context, bool boxIsScrolled) {
                    return <Widget>[
                      HomeHeader(boxIsScrolled),
                    ];
                  },
//                  physics: NeverScrollableScrollPhysics(),
                  // 首页下拉刷新页面
                  body: EasyRefresh(
                    child: ListView(
                      children: <Widget>[
                        SwiperDiv(bannerInfoList: this.bannerInfoList),
                        TodayNewsDiv(todayNews: this.todayNews),
                        IndexCategoryDiv(categoryList: this.categoryList,),
                        IndexExpertDiv(expertList: this.expertList,),
                        IndexLessonDiv(lessonList: this.lessonList,),
                      ],
                    ),
                    bottomBouncing: false,
                    onRefresh: () async {
                      print('触发onRefresh');
                      await initData();
                    },
                    header: PhoenixHeader(),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text('没有数据'),
            );
          }
        });
  }

  Future initData() async {
    setState((){});
    this.bannerInfoList = await HttpRequest().reqSwiperList();
    this.todayNews = await HttpRequest().reqTodayNews();
    this.categoryList = await HttpRequest().indexSelectCategory();
    this.expertList = await HttpRequest().indexExpert();
    this.lessonList = await HttpRequest().indexLesson();
    return 'ok';
  }
}
// 首页的头部搜索框
class HomeHeader extends StatelessWidget {
  final bool boxIsScrolled;
  TextEditingController textController = TextEditingController();

  HomeHeader(this.boxIsScrolled);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        title: Container(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(0)),
          color: Color(0xffFFFfFf),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: ScreenUtil().setWidth(50.0),maxWidth: ScreenUtil().setWidth(750.0)),
            child:new TextField(
              controller: textController,
              onTap: (){
                print('open');
              },
              onSubmitted: (value){
                print('submit:${value}');
              },
              decoration: InputDecoration(
                contentPadding:EdgeInsets.only(left: ScreenUtil().setWidth(0.0)),
                hintText: '输入标题或内容',
                hintStyle: TextStyle(color: Color(0xffC8C8C7), fontSize: ScreenUtil().setSp(24)),
                prefixIcon: Icon(Icons.search,color: Color(0xffCACACB),size: ScreenUtil().setSp(36)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(ScreenUtil().setSp(12)),borderSide: BorderSide.none),
                filled: true,
                fillColor: Color(0xffF4F4F4),
              ),
            ),
          ),
        ),
        pinned: true,
        floating: true,
        forceElevated: boxIsScrolled,
        expandedHeight: ScreenUtil().setHeight(80),
        flexibleSpace: Container(
          color: Colors.white,
        ),
        bottom: PreferredSize(child: Container(), preferredSize: Size(0, 0)));
  }
}
