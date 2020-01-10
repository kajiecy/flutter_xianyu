import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xianyu_app/service/http_request.dart';
import 'package:xianyu_app/model/CategoryType.dart';
import 'package:xianyu_app/model/ListDao4Page.dart';
import 'package:xianyu_app/model/CategoryInfo.dart';
import 'package:xianyu_app/model/PageInfo.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';

// DropdownButton 默认按钮的实例
// isDisabled:是否是禁用，isDisabled 默认为true
var selectItValue;
var selectItemValue;

class TestMain extends StatefulWidget {
  @override
  _TestMainState createState() => _TestMainState();
}

class _TestMainState extends State<TestMain> with TickerProviderStateMixin {
  TextEditingController textController = TextEditingController();
  TabController _tabController;
  AnimationController _animationController;
  List<CategoryType> categoryTypeList = [];// 测评类型列表
  ListDao4Page<CategoryInfo> categoryInfoPage = ListDao4Page<CategoryInfo>(null,PageInfo(pageSize: 10,currentPage: 1,last: false));
  EasyRefreshController _easyRefreshController;
  int currentTypeId ;
  bool _loadState = false;
  List<CategoryInfo> categoryList = [];

  List<DropdownMenuItem> generateItemList() {
    final List<DropdownMenuItem> items = List();
    final DropdownMenuItem item1 =
    DropdownMenuItem(value: '', child: Text('默认'));
    final DropdownMenuItem item2 =
    DropdownMenuItem(value: 'testNum', child: Text('人数'));
    final DropdownMenuItem item3 =
    DropdownMenuItem(value: 'weekReadNum', child: Text('热度'));
    final DropdownMenuItem item4 =
    DropdownMenuItem(value: 'createTime', child: Text('时间'));
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
                            this.categoryInfoPage = await HttpRequest().categoryList(currPage: 1,pageSize: 10,typeId: this.currentTypeId,orderBy:selectItemValue);
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
                            Text('贤于测评',
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
                                    this.categoryInfoPage = await HttpRequest().categoryList(currPage: 1,pageSize: 10,typeId: this.currentTypeId,orderBy:selectItemValue);
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
                              child: this.categoryList.length!=0?EasyRefresh(
                                controller: _easyRefreshController,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: this.categoryList.length,
                                  itemBuilder: (context,index){
                                    return listItemWidget(this.categoryList[index]);
                                  },
                                ),
                                bottomBouncing: !categoryInfoPage.pageInfo.last,
                                onRefresh: () async {
                                  await initData();
                                },
                                onLoad: () async {
                                  this._loadState = true;
                                  await onloadListInfo(currentPage: categoryInfoPage.pageInfo.currentPage+1);
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
//        this.categoryTypeList.addAll(await HttpRequest().categoryTypeList(currPage: 0,pageSize: 8));
        this.categoryTypeList.addAll(await HttpRequest().getXianYuTypeList(2));
      }
      this.categoryInfoPage = await HttpRequest().categoryList(currPage: 1,pageSize: 10,typeId: this.currentTypeId,orderBy:selectItemValue);
      this.categoryList = this.categoryInfoPage.infoList;
    }else{
      this._loadState = false;
    }
    return 'ok';
  }
  Future onloadListInfo({currentPage}) async {
    var _currentPage = currentPage!=null?currentPage:this.categoryInfoPage.pageInfo.currentPage;
    this.categoryInfoPage.pageInfo.currentPage = _currentPage;
    this.categoryInfoPage = await HttpRequest().categoryList(currPage: _currentPage,pageSize: 10,typeId: this.currentTypeId,orderBy:selectItemValue);
    this.categoryList.addAll(this.categoryInfoPage.infoList);
    if(this.categoryInfoPage.pageInfo.last&&this.categoryList.last.id != null){
      this.categoryList.add(new CategoryInfo());
    }else if(this.categoryInfoPage.pageInfo.last&&this.categoryList.last.id == null){
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

  Widget listItemWidget(CategoryInfo itemInfo){
    if(itemInfo.id!=null){
      return
        Column(
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(200),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.amberAccent
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10
                    ),
                    width:ScreenUtil().setWidth(500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height:ScreenUtil().setHeight(115),
                          child: Text(
                            itemInfo.categoryName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          itemInfo.categoryTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Color(0xff88898B),
                            fontSize: ScreenUtil().setSp(28),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(150),
                    decoration: BoxDecoration(
//                      color: Colors.orange
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child:ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/img/placeholder135x180.png",
                              image: "${qiniuUrl + itemInfo.image}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: ScreenUtil().setWidth(190),
                          height: ScreenUtil().setHeight(110),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(40),
                          width: ScreenUtil().setWidth(190),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5))
                          ),
                          child: Text(itemInfo.testNum.toString()+'人测过',style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

