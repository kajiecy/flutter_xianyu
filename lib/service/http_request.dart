import 'package:xianyu_app/model/BannerInfo.dart';
import 'package:xianyu_app/model/TodayNews.dart';

import 'package:xianyu_app/service/service_method.dart';
import 'dart:convert';

const serviceUrl = 'http://192.168.16.254:7070';
const qiniuUrl = 'https://xfindcdn.xfindzp.com/';
const servicePath={
  'getSwiperList': serviceUrl+'/xianyu/indexImage/list', // 商家首页信息
  'todayNews': serviceUrl+'/xianyu/index/today/news', // 今日选文
};
class HttpRequest {
  Future reqSwiperList() async{
    List<BannerInfo> bannerInfoList = BannerInfo.fromJsonList((await request(servicePath['getSwiperList'], formData: {}))['list']);
    return bannerInfoList;
  }
  Future reqTodayNews() async{
//    List<BannerInfo> bannerInfoList = BannerInfo.fromJsonList(['list']);
    TodayNews todayNews = TodayNews.fromJson((await requestGet(servicePath['todayNews'], formData: null))[0]);
    return todayNews;
  }
}
