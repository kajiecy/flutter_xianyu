import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xianyu_app/service/http_request.dart';
import 'package:xianyu_app/model/CategoryType.dart';
import 'package:xianyu_app/model/ListDao4Page.dart';
import 'package:xianyu_app/model/CourseInfo.dart';
import 'package:xianyu_app/model/PageInfo.dart';
import 'package:xianyu_app/model/IndexLesson.dart';
import 'package:xianyu_app/pages/home/index_lesson_div.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';

// DropdownButton 默认按钮的实例
// isDisabled:是否是禁用，isDisabled 默认为true
var selectItValue;
var selectItemValue;

class CourseMain extends StatefulWidget {
  @override
  _CourseMainState createState() => _CourseMainState();
}

class _CourseMainState extends State<CourseMain> with TickerProviderStateMixin {
  TextEditingController textController = TextEditingController();
  TabController _tabController;
  AnimationController _animationController;
  List<CategoryType> categoryTypeList = [];// 测评类型列表
  EasyRefreshController _easyRefreshController;
  int currentTypeId ;
  bool _loadState = false;

  List<IndexLesson> courseList = [];
  ListDao4Page<IndexLesson> courseInfoPage = ListDao4Page<IndexLesson>(null,PageInfo(pageSize: 10,currentPage: 1,last: false));

  List<DropdownMenuItem> generateItemList() {
    final List<DropdownMenuItem> items = List();
    final DropdownMenuItem item1 =
    DropdownMenuItem(value: 'sort', child: Text('默认'));
    final DropdownMenuItem item2 =
    DropdownMenuItem(value: 'playTimes', child: Text('播放'));
    items.add(item1);
    items.add(item2);
    return items;
  }
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
              body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      // 头部的输入框 start
                      Container(
                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20)),
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
                            this.courseInfoPage = await HttpRequest().requestCourseList(currPage: 1,pageSize: 10,lessonTypeId: this.currentTypeId,orderBy:selectItemValue);
                          },
                        ),
                      ),

                      // 内容标题 及 排序选择
                      Container(
                        width: ScreenUtil().setWidth(750),
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20),vertical: ScreenUtil().setHeight(20)),
                        margin: EdgeInsets.only(bottom: 1),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Color(0xffeeeeee),offset: Offset(1, 1),spreadRadius: 0),
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('贤于课堂',
                              style: TextStyle(
                                  fontSize:ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(165),
                              height: ScreenUtil().setHeight(54),
                              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow:[new BoxShadow(color: Color(0xffcccccc),blurRadius: 2.0,offset: Offset(0.5, 1.5))],
                              ),
                              child:DropdownButtonHideUnderline(
                                child:DropdownButton(
                                  hint: Text(changeOrderText(selectItemValue)),
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                  ),
                                  icon: Icon(Icons.arrow_drop_down,color: Color(0xff0E7EFF),),
                                  iconSize: ScreenUtil().setSp(52),
                                  value: selectItemValue,
                                  items: generateItemList(),
                                  onChanged: (T) async {
                                    setState(() {
                                      selectItemValue=T;
                                    });
                                    this.courseInfoPage = await HttpRequest().requestCourseList(currPage: 1,pageSize: 10,lessonTypeId: this.currentTypeId,orderBy:selectItemValue);
                                  },
                                ),
                              ),
                            ),
                          ],
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
                              height: ScreenUtil().setHeight(874),
                              child: this.courseList.length!=0?EasyRefresh(
                                controller: _easyRefreshController,
                                child:
                                ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: this.courseList.length,
                                  itemBuilder: (context,index){
                                    return listItemWidget(this.courseList[index]);
                                  },
                                ),


                                bottomBouncing: !courseInfoPage.pageInfo.last,
                                onRefresh: () async {
                                  await initData();
                                },
                                onLoad: () async {
                                  this._loadState = true;
                                  await onloadListInfo(currentPage: courseInfoPage.pageInfo.currentPage+1);
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
          return Center(child: Text('暂无数据'),);
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
        this.categoryTypeList.addAll(await HttpRequest().getXianYuTypeList(1));
      }
      this.courseInfoPage = await HttpRequest().requestCourseList(currPage: 1,pageSize: 10,lessonTypeId: this.currentTypeId,orderBy:selectItemValue);
      this.courseList = this.courseInfoPage.infoList;


    }else{
      this._loadState = false;
    }
    return 'ok';
  }
  Future onloadListInfo({currentPage}) async {
    var _currentPage = currentPage!=null?currentPage:this.courseInfoPage.pageInfo.currentPage;
    this.courseInfoPage.pageInfo.currentPage = _currentPage;
    this.courseInfoPage = await HttpRequest().requestCourseList(currPage: _currentPage,pageSize: 10,lessonTypeId: this.currentTypeId,orderBy:selectItemValue);
    this.courseList.addAll(this.courseInfoPage.infoList);
    if(this.courseInfoPage.pageInfo.last&&this.courseList.last.id != null){
      this.courseList.add(new IndexLesson());
    }else if(this.courseInfoPage.pageInfo.last&&this.courseList.last.id == null){
//      this._easyRefreshController.resetLoadStateCallBack();
    }
//    _easyRefreshController.resetRefreshState();
    setState((){});
    return 'ok';
  }
  String changeOrderText(String orderType){
    String resultText = '默认';
    switch (orderType){
      case "playTimes":{resultText = '播放';}
      break;
    }
    return resultText;
  }

  Widget listItemWidget(IndexLesson itemInfo){
    if(itemInfo.id!=null){
      String fileTypeIconName = itemInfo.fileType==1?'assets/icon/audio.png':'assets/icon/video.png';
      return
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5),horizontal: ScreenUtil().setWidth(0)),
              child:
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10),top: ScreenUtil().setHeight(5)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // 今日选文的左侧图片
                        Container(
                          width: ScreenUtil().setWidth(284),
                          height: ScreenUtil().setHeight(160),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/img/placeholder135x180.png",
                              image: qiniuUrl+itemInfo.infoPic,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(420),
                          padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  itemInfo.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize:ScreenUtil().setSp(32),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                height: ScreenUtil().setHeight(110),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      itemInfo.playTimes!=null ?itemInfo.playTimes.toString()+'次播放': '0次播放',
                                      style: TextStyle(
                                        color: Color(0xff71859E),
                                        fontSize: ScreenUtil().setSp(24),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "免费",
                                      style: TextStyle(
                                        color: Color(0xffC49347),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10),horizontal: ScreenUtil().setWidth(20)),
                                    decoration: BoxDecoration(
//                              color: Color(0xF7F7F7),
                                        color: Color(0xffF7F7f7),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
            itemInfo.vipPrice!=null&&itemInfo.vipPrice!=''?Positioned(
              top: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15),vertical: ScreenUtil().setHeight(5)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFFEBC766), Color(0xFFD69C00)],),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(5)
                  ),
                ),
                child: Text('VIP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            ):Container(),
            Positioned(
              top: 73,
              left: 123,
              child: Container(
                width: ScreenUtil().setWidth(52),
                height: ScreenUtil().setHeight(28),
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(3),vertical: ScreenUtil().setHeight(3)),
                decoration: BoxDecoration(
                    color: Color(0x99cccccc),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Image.asset(fileTypeIconName,),

              ),
            ),
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

