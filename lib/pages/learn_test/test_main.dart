import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:xianyu_app/routers/application.dart';
import 'package:xianyu_app/routers/routers.dart';
import 'right_back_demo.dart';
main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: RightBackDemo(),
    );
  }
}