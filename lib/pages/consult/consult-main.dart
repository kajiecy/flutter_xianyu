import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xianyu_app/service/http_request.dart';
import 'package:xianyu_app/model/CategoryType.dart';
import 'package:xianyu_app/model/ListDao4Page.dart';
import 'package:xianyu_app/model/CourseInfo.dart';
import 'package:xianyu_app/model/PageInfo.dart';
import 'package:xianyu_app/model/IndexExpert.dart';
import 'package:xianyu_app/pages/home/index_lesson_div.dart';
import 'dart:math';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';

// DropdownButton 默认按钮的实例
// isDisabled:是否是禁用，isDisabled 默认为true
var selectItValue;
var selectItemValue;

class ConsultMain extends StatefulWidget {
  @override
  _ConsultMainState createState() => _ConsultMainState();
}

class _ConsultMainState extends State<ConsultMain> with TickerProviderStateMixin {
  TextEditingController textController = TextEditingController();
  TabController _tabController;
  AnimationController _animationController;
  List<CategoryType> categoryTypeList = [];// 测评类型列表
  EasyRefreshController _easyRefreshController;
  int currentTypeId ;
  bool _loadState = false;

  List<IndexExpert> expertList = [];
  ListDao4Page<IndexExpert> expertInfoPage = ListDao4Page<IndexExpert>(null,PageInfo(pageSize: 10,currentPage: 1,last: false));

  List<DropdownMenuItem> generateItemList() {
    final List<DropdownMenuItem> items = List();
    final DropdownMenuItem item1 = DropdownMenuItem(value: '', child: Text('默认'));
    final DropdownMenuItem item2 = DropdownMenuItem(value: 'employmentYears', child: Text('从业时间'));
    final DropdownMenuItem item3 = DropdownMenuItem(value: 'weekReadNum', child: Text('热度'));
    final DropdownMenuItem item4 = DropdownMenuItem(value: 'settleTime', child: Text('时间'));
    items.add(item1);
    items.add(item2);
    items.add(item3);
    items.add(item4);
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
                            this.expertInfoPage = await HttpRequest().postExpertList(currPage: 1,pageSize: 10,typeId: this.currentTypeId,orderBy:selectItemValue);
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
                            Text('咨询',
                              style: TextStyle(
                                  fontSize:ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(205),
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
                                    this.expertInfoPage = await HttpRequest().postExpertList(currPage: 1,pageSize: 10,typeId: this.currentTypeId,orderBy:selectItemValue);
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
                              child: this.expertList.length!=0?EasyRefresh(
                                controller: _easyRefreshController,
                                child:
                                ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: this.expertList.length,
                                  itemBuilder: (context,index){
                                    return listItemWidget(this.expertList[index]);
                                  },
                                ),
                                bottomBouncing: !expertInfoPage.pageInfo.last,
                                onRefresh: () async {
                                  await initData();
                                },
                                onLoad: () async {
                                  this._loadState = true;
                                  await onloadListInfo(currentPage: expertInfoPage.pageInfo.currentPage+1);
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
        this.categoryTypeList.addAll(await HttpRequest().getXianYuTypeList(3));
      }
      this.expertInfoPage = await HttpRequest().postExpertList(currPage: 1,pageSize: 10,typeId: this.currentTypeId,orderBy:selectItemValue);
      this.expertList = this.expertInfoPage.infoList;
    }else{
      this._loadState = false;
    }
    return 'ok';
  }
  Future onloadListInfo({currentPage}) async {
    var _currentPage = currentPage!=null?currentPage:this.expertInfoPage.pageInfo.currentPage;
    this.expertInfoPage.pageInfo.currentPage = _currentPage;
    this.expertInfoPage = await HttpRequest().postExpertList(currPage: _currentPage,pageSize: 10,typeId: this.currentTypeId,orderBy:selectItemValue);
    this.expertList.addAll(this.expertInfoPage.infoList);
    if(this.expertInfoPage.pageInfo.last&&this.expertList.last.id != null){
      this.expertList.add(new IndexExpert());
    }else if(this.expertInfoPage.pageInfo.last&&this.expertList.last.id == null){
//      this._easyRefreshController.resetLoadStateCallBack();
    }
//    _easyRefreshController.resetRefreshState();
    setState((){});
    return 'ok';
  }
  String changeOrderText(String orderType){
    String resultText = '默认';
    switch (orderType){
      case "employmentYears":{resultText = '从业时间';}
      break;
      case "weekReadNum":{resultText = '热度';}
      break;
      case "settleTime":{resultText = '时间';}
      break;
    }
    return resultText;
  }

  Widget listItemWidget(IndexExpert itemInfo){
    if(itemInfo.id!=null){
      return
      Column(
        children: <Widget>[
        Container(
        width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(150),
                height: ScreenUtil().setHeight(150),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/img/placeholder135x180.png",
                    image: qiniuUrl+itemInfo.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:ScreenUtil().setWidth(530),
                      child:Row(
  //                      crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                    verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          Text.rich(TextSpan(
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(32),
                                fontWeight:FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                    text: itemInfo.name + ' · '
                                ),
                                TextSpan(
                                  text: '从业${itemInfo.employmentYears}年',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(24),
                                    color: Color(0xff666666),
                                  ),
                                )
                              ]
                          )),
                          Text(disposedExpertPrice(itemInfo),
                            style: TextStyle(
                              color: Color(0xffFF9C00),
                              fontSize: ScreenUtil().setSp(24),
                            ),)
                        ],
                      ),
  
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      width: ScreenUtil().setWidth(530),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            itemInfo.educationDescription,
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: ScreenUtil().setSp(24),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            itemInfo.employmentDescription,
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: ScreenUtil().setSp(24),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
              ),
            ),
          ],
        ),
      ),
          Divider()
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
  String disposedExpertPrice(IndexExpert itemInfo){
    String result = '';
    double max = 0;
    double min = 0;

    if(itemInfo.interviewPrice!=null){
      max = itemInfo.interviewPrice;
      min = itemInfo.interviewPrice;
    }
    if(itemInfo.phonePrice!=null){
      if(itemInfo.phonePrice>max){
        max = itemInfo.phonePrice;
      }
      if(itemInfo.phonePrice<min){
        min = itemInfo.phonePrice;
      }
    }
    if(itemInfo.videoPrice!=null){
      if(itemInfo.videoPrice>max){
        max = itemInfo.videoPrice;
      }
      if(itemInfo.videoPrice<min){
        min = itemInfo.videoPrice;
      }
    }
    if(max==min){
      result = max==0?'免费':max.toString();
    }else{
      result = '${min==0?'免费':min.toString()}~${max==0?'免费':max.toString()}';
    }
    return result;
  }
}

