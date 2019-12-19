import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xianyu_app/service/http_request.dart';
import 'package:xianyu_app/model/CategoryType.dart';
import 'package:xianyu_app/model/ListDao4Page.dart';
import 'package:xianyu_app/model/CategoryInfo.dart';


// DropdownButton 默认按钮的实例
// isDisabled:是否是禁用，isDisabled 默认为true
var selectItValue;
var selectItemValue;

class TestMain extends StatefulWidget {
  @override
  _TestMainState createState() => _TestMainState();
}

class _TestMainState extends State<TestMain> with SingleTickerProviderStateMixin {
  TextEditingController textController = TextEditingController();
  TabController _tabController;
  List<CategoryType> categoryList = [];// 测评类型列表
  ListDao4Page<CategoryInfo> categoryInfoPage;

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
            _tabController = TabController(vsync: this, length: this.categoryList.length);
          }
          return Scaffold(
              body: SafeArea(
                  child: Column(
                    children: <Widget>[
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
                          tabs: categoryList.map((item){return Tab(text: item.name,);}).toList(),
                          onTap: (index){
                            print(index);
                          },
                        ),
                      ),
  //                ------------tab标签 end------------
                      Container(
                        width: ScreenUtil().setWidth(750),
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20),vertical: ScreenUtil().setHeight(10)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: ScreenUtil().setWidth(750),
                              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),vertical: ScreenUtil().setHeight(20)),
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
                                            color: Color(0xff000000)
                                        ),
                                        icon: Icon(Icons.arrow_drop_down,color: Color(0xff0E7EFF),),
                                        iconSize: ScreenUtil().setSp(52),
                                        value: selectItemValue,
                                        items: generateItemList(),
                                        onChanged: (T) {
                                          setState(() {
                                            selectItemValue=T;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text('111'),
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
  Future initData() async {
    setState((){});
    this.categoryList = await HttpRequest().categoryTypeList(currPage: 0,pageSize: 8);
    this.categoryInfoPage = await HttpRequest().categoryList(currPage: 1,pageSize: 10,typeId: '');

//    _tabController.length = this.categoryList.length;
//    _tabController = TabController(vsync: this, length: categoryList.length);

//    this.todayNews = await HttpRequest().reqTodayNews();
//    this.categoryList = await HttpRequest().indexSelectCategory();
//    this.expertList = await HttpRequest().indexExpert();
//    this.lessonList = await HttpRequest().indexLesson();
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

  void listItemWidget(){

  }
}

//class TabWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}
