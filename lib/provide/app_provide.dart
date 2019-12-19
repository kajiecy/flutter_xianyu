import 'package:flutter/material.dart';

class AppProvide with ChangeNotifier{
  int homeTabsIndex = 0;
  bool searchShow = false;

  changeHomeTabsIndex(value){
    this.homeTabsIndex = value;
    notifyListeners();
  }
  changeSearchShow(){
    this.searchShow = !this.searchShow;
    notifyListeners();
  }
}