import 'package:flutter/material.dart';
import 'package:xianyu_app/pages/consult/consult-main.dart';
import 'package:xianyu_app/pages/course/course_main.dart';
import 'package:xianyu_app/pages/home/home_main.dart';
import 'package:xianyu_app/pages/test/test_main.dart';
import 'package:xianyu_app/pages/user/user_main.dart';

class AppProvide with ChangeNotifier{
  int homeTabsIndex = 0;
  bool searchShow = false;
  final List<Widget> tabBodies = [
    HomeMain(),
    TestMain(),
    CourseMain(),
    ConsultMain(),
    UserMain(),
  ];
  var currentPage;

  changeHomeTabsIndex(value){
    this.homeTabsIndex = value;
    this.currentPage = this.tabBodies[this.homeTabsIndex];
    notifyListeners();
  }
  changeSearchShow(){
    this.searchShow = !this.searchShow;
    notifyListeners();
  }
}