import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home/home_main.dart';
import 'test/test_main.dart';
import 'consult/consult-main.dart';
import 'course/course_main.dart';
import 'user/user_main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/app_provide.dart';


class IndexPage extends StatefulWidget {

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Image.asset("assets/img/tabs/home.png",width: 24.0,height: 24.0,),
      activeIcon: Image.asset("assets/img/tabs/home-1.png",width: 24.0,height: 24.0,),
      title: Text('首页',
        style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontSize: 12
        ),
      ),
    ),
    BottomNavigationBarItem(
      icon: Image.asset("assets/img/tabs/test.png",width: 24.0,height: 24.0,),
      activeIcon: Image.asset("assets/img/tabs/test-1.png",width: 24.0,height: 24.0,),

      title: Text('测评',
        style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontSize: 12
        ),
      ),
    ),
    BottomNavigationBarItem(
      icon: Image.asset("assets/img/tabs/class.png",width: 24.0,height: 24.0,),
      activeIcon: Image.asset("assets/img/tabs/class-1.png",width: 24.0,height: 24.0,),
      title: Text('课堂',
        style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontSize: 12
        ),
      ),
    ),
    BottomNavigationBarItem(
      icon: Image.asset("assets/img/tabs/mes.png",width: 24.0,height: 24.0,),
      activeIcon: Image.asset("assets/img/tabs/mes-1.png",width: 24.0,height: 24.0,),
      title: Text('咨询',
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.6),
          fontSize: 12
        ),
      ),
    ),
    BottomNavigationBarItem(
      icon: Image.asset("assets/img/tabs/my.png",width: 24.0,height: 24.0,),
      activeIcon: Image.asset("assets/img/tabs/my-1.png",width: 24.0,height: 24.0,),
      title: Text('我的',
        style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontSize: 12
        ),
      ),
    ),
  ];
  final List<Widget> tabBodies = [
    HomeMain(),
    TestMain(),
    CourseMain(),
    ConsultMain(),
    UserMain(),
  ];
  int currentIndex = 0;
//  int currentIndex = Provide.value<AppProvide>(context);
  var currentPage;


  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Scaffold(

      appBar: PreferredSize(
          child: AppBar(
//            backgroundColor: Colors.transparent,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            bottomOpacity: 0,
              elevation:0,
          ),
          preferredSize: Size(double.infinity, 0)),
      backgroundColor: Color(0xffF4F4F4),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          setState((){
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}
