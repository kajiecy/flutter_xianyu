import 'package:flutter/material.dart';

class TestMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      elevation: 0.5,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Text('1111',style: TextStyle(color: Colors.black),),
      toolbarOpacity: 0.0,
    ),);
  }
}
