import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xianyu_app/service/http_request.dart';
import 'package:xianyu_app/model/CategoryType.dart';
import 'package:xianyu_app/model/ListDao4Page.dart';
import 'package:xianyu_app/model/TodayNews.dart';
import 'package:xianyu_app/model/PageInfo.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:xianyu_app/routers/application.dart';
import 'package:fluro/fluro.dart';

// DropdownButton 默认按钮的实例
// isDisabled:是否是禁用，isDisabled 默认为true
var selectItValue;
var selectItemValue;

class NewsIndex extends StatefulWidget {
  @override
  _NewsIndexState createState() => _NewsIndexState();
}

class _NewsIndexState extends State<NewsIndex> with TickerProviderStateMixin {
  TabController _tabController;
  AnimationController _animationController;
  List<CategoryType> categoryTypeList = [];// 类型列表
  
  ListDao4Page<TodayNews> newsInfoPage = ListDao4Page<TodayNews>(null,PageInfo(pageSize: 10,currentPage: 1,last: false));
  List<TodayNews> newsInfoList = [];

  EasyRefreshController _easyRefreshController;
  int currentTypeId ;
  bool _loadState = false;


  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initData(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          if(_tabController==null){
            _animationController = AnimationController(vsync: this);
            _tabController = TabController(vsync: this, length: this.categoryTypeList.length);
          }
          return Scaffold(
            appBar: AppBar(title: Text('精选文章'),),
              body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      //                ------------tab标签 start------------
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TabBar(
                          isScrollable: true,
                          controller: _tabController,
                          labelColor: Colors.black,
                          indicatorColor: Color(0xff0E7EFF),
                          indicatorPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
                          unselectedLabelColor: Color(0xff3333333),
                          labelStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(34.0),
                              fontWeight: FontWeight.w500
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: ScreenUtil().setSp(28.0),
                          ),
                          tabs: categoryTypeList.map((item){return Tab(text: item.name,);}).toList(),
                          onTap: (index) async {
                            setState((){
                              this.currentTypeId = categoryTypeList[index].id;
                            });
                            this.newsInfoPage = await HttpRequest().postNewsPageList(currPage: 1,pageSize: 10,typeId: this.currentTypeId);
                          },
                        ),
                      ),
                      // 正文内容
                      Container(
                        width: ScreenUtil().setWidth(750),
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20),vertical: ScreenUtil().setHeight(10)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(0),
                              alignment: Alignment.topLeft,
//                              decoration: BoxDecoration(color: Colors.amberAccent),
                              height: ScreenUtil().setHeight(1060),
                              child: this.newsInfoList.length!=0?EasyRefresh(
                                controller: _easyRefreshController,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: this.newsInfoList.length,
                                  itemBuilder: (context,index){
                                    return listItemWidget(this.newsInfoList[index]);
                                  },
                                ),
                                bottomBouncing: !newsInfoPage.pageInfo.last,
                                onRefresh: () async {
                                  await initData();
                                },
                                onLoad: () async {
                                  this._loadState = true;
                                  await onloadListInfo(currentPage: newsInfoPage.pageInfo.currentPage+1);
                                },
                                header: MaterialHeader(
                                  valueColor: ColorTween(
                                    begin: Color(0xff0E7EFF),
                                    end: Color(0xff0E7EFF),
                                  ).animate(
                                    CurvedAnimation(
                                      parent: _animationController,
                                      curve: Interval(
                                        0.5,
                                        0.75,
                                        curve: Curves.linear,
                                      ),
                                    ),
                                  ),
                                ),
                                footer: BallPulseFooter(),
                              )
                                  :Center(child: Text('暂无数据'),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              )
          );
        }else{
          return Scaffold(appBar: AppBar(title: Text('精选文章'),),
            body: Center(child: Text('暂无数据'),),
          );
        }
      },
    );
  }
  Future initData({currentPage}) async {
    this._loadState;
    if(this._loadState==false){
      setState((){});
      if(this.categoryTypeList.length==0){
        this.categoryTypeList.add(new CategoryType(id: null,name: '全部'));
//        this.categoryTypeList.addAll(await HttpRequest().categoryTypeList(currPage: 0,pageSize: 8));
        this.categoryTypeList.addAll(await HttpRequest().getXianYuTypeList(4));
      }
      this.newsInfoPage = await HttpRequest().postNewsPageList(currPage: 1,pageSize: 10,typeId: this.currentTypeId);
      this.newsInfoList = this.newsInfoPage.infoList;
    }else{
      this._loadState = false;
    }
//    await HttpRequest().postNewsPageList(currPage: 1,pageSize: 10,orderBy:selectItemValue);
    return 'ok';
  }
  Future onloadListInfo({currentPage}) async {
    var _currentPage = currentPage!=null?currentPage:this.newsInfoPage.pageInfo.currentPage;
    this.newsInfoPage.pageInfo.currentPage = _currentPage;
    this.newsInfoPage = await HttpRequest().postNewsPageList(currPage: _currentPage,pageSize: 10,typeId: this.currentTypeId);
    this.newsInfoList.addAll(this.newsInfoPage.infoList);
    if(this.newsInfoPage.pageInfo.last&&this.newsInfoList.last.id != null){
      this.newsInfoList.add(new TodayNews());
    }else if(this.newsInfoPage.pageInfo.last&&this.newsInfoList.last.id == null){
//      this._easyRefreshController.resetLoadStateCallBack();
    }
//    _easyRefreshController.resetRefreshState();
    setState((){});
    return 'ok';
  }
  String changeOrderText(String orderType){
    String resultText = '默认';
    switch (orderType){
      case "testNum":{resultText = '人数';}
      break;
      case "weekReadNum":{resultText = '热度';}
      break;
      case "createTime":{resultText = '时间';}
      break;
    }
    return resultText;
  }

  Widget listItemWidget(TodayNews itemInfo){
    if(itemInfo.id!=null){
      return
        Column(
          children: <Widget>[
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20),horizontal: ScreenUtil().setWidth(0)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 今日选文的左侧图片
                    Container(
                      width: ScreenUtil().setWidth(135),
                      height: ScreenUtil().setHeight(180),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/img/placeholder135x180.png",
                          image: qiniuUrl+itemInfo.pic,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // 今日选文的右侧信息展示
                    Container(
                      width: ScreenUtil().setWidth(510),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0)),
                      height: ScreenUtil().setHeight(180),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(itemInfo.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32.0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text.rich(TextSpan(
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(26.0),
                                color: Color(0xff525156),
                              ),
                              children: [
                                TextSpan(
                                    text: itemInfo.author
                                ),
                                TextSpan(
                                    text: ' | '
                                ),
                                TextSpan(
                                    text: itemInfo.src
                                ),
                              ]
                          )
                          ),
                          Text(itemInfo.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xff88898B),
                              fontSize: ScreenUtil().setSp(24.0),
                            ),
                          ),
                          Text(itemInfo.readTimes.toString()+'人阅读',
                            style: TextStyle(
                              color: Color(0xffFF9C00),
                              fontSize: ScreenUtil().setSp(24.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: (){
                print(itemInfo.id);
                Application.router.navigateTo(context, '/news_content?newsId=${itemInfo.id}',transition: TransitionType.cupertino);
              },
            ),
            Divider(height: 1,),
          ],
        );
    }else{
      return
        Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
          child: Center(
            child: Text('已经到最底了~！',style: TextStyle(fontSize: ScreenUtil().setSp(32)),),
          ),
        );
    }
  }
}

