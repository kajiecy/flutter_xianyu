import 'package:flutter/material.dart';

class AppProvide with ChangeNotifier{
  int homeTabsIndex = 0;

  changeHomeTabsIndex(value){
    this.homeTabsIndex = value;
    notifyListeners();
  }
}