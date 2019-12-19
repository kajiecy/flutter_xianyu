import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:xianyu_app/pages/home/search/search_index.dart';
import 'package:xianyu_app/pages/home/news/news_index.dart';
import 'package:xianyu_app/pages/learn_test/right_back_demo.dart';

Handler searchIndexHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
//    String goodsId = params['id'].first;
    return SearchIndex();
  },
);
Handler newsIndexHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
//    String goodsId = params['id'].first;
    return NewsIndex();
  },
);

Handler testHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
//    String goodsId = params['id'].first;
    return RightBackDemo();
  },
);
