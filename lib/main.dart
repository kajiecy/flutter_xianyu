import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';
import './provide/app_provide.dart';
//import './provide/child_category.dart';
//import './provide/category_goods_list_store.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';
//import './provide/goods_detail_provide.dart';
//import './provide/car_provide.dart';

void main(){
  var appProvide = AppProvide();
//  var childCategory = ChildCategory();
//  var categoryGoodsList = CategoryGoodsListStore();
//  var goodsDetailProvide = GoodsDetailProvide();
//  var carProvide = CarProvide();
  // 全局状态管理
  final providers = Providers();


  // 将自类状态注入到provider实例中
  providers
    ..provide(Provider<AppProvide>.value(appProvide))
  ;
  runApp(ProviderNode(providers: providers,child: MyApp(),));
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '贤于测评',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          primaryColor: Color.fromRGBO( 54, 115, 238,1),
        ),
        home: IndexPage(),
      ),
    );
  }
}