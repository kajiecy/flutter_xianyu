import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianyu_app/routers/application.dart';

//class RightBackDemo extends StatefulWidget {
//  @override
//  _RightBackDemoState createState() => _RightBackDemoState();
//}
//
//class _RightBackDemoState extends State<RightBackDemo> {
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}


class RightBackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          width: 100,
          height: 100,
          color: CupertinoColors.activeBlue,
          child: CupertinoButton(
            child: Icon(CupertinoIcons.add,color: Color.fromARGB(333, 333, 333, 333),),
            // 触发事件
            onPressed: (){
//              Navigator.of(context).push(
//                  CupertinoPageRoute(builder: (BuildContext context){
//                    // 每次点击再打开一次当前的页面
//                    return RightBackDemo();
//                  })
//              );
              print('用fluaro打开2');
              Application.router.navigateTo(context, '/right_back_demo',);

            },
          ),
        ),
      ),
    );
  }
}