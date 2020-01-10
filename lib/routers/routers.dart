import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes{
  static String root = '/';
  static String searchIndex = '/search_index';
  static String newsIndex = '/news_index';
  static String rightBackDemo = '/right_back_demo';
  static String newsContent = '/news_content';
  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc:(BuildContext context,Map<String,List<String>> params){
        print('error ===> root was not found！！');
      }
    );
    router.define(searchIndex, handler: searchIndexHandler,transitionType: TransitionType.cupertino);
    router.define(newsIndex, handler: newsIndexHandler,transitionType: TransitionType.cupertino);
    router.define(rightBackDemo, handler: testHandler,transitionType: TransitionType.cupertino);
    router.define(newsContent, handler: newsHandler,transitionType: TransitionType.cupertino);
  }
}