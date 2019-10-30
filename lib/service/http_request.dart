import 'package:xianyu_app/model/BannerInfo.dart';
import 'package:xianyu_app/model/TodayNews.dart';
import 'package:xianyu_app/model/IndexCategory.dart';
import 'package:xianyu_app/model/IndexExpert.dart';

import 'package:xianyu_app/service/service_method.dart';
import 'dart:convert';

const serviceUrl = 'https://delphis.cn';
const qiniuUrl = 'https://xfindcdn.xfindzp.com/';
const servicePath={
  'getSwiperList': serviceUrl+'/xianyu/indexImage/list', // 商家首页信息
  'todayNews': serviceUrl+'/xianyu/index/today/news', // 今日选文
  'indexSelectCategory': serviceUrl+'/xianyu/index/select/category', // 精选测评
  'indexSelectExpert': serviceUrl+'/xianyu/index/select/expert', // 精选测评
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
  Future indexSelectCategory() async{
    List<IndexCategory> indexCategoryList = IndexCategory.fromJsonList(await request(servicePath['indexSelectCategory'], formData: []));
//    var result = ;
    return indexCategoryList;
  }
  Future indexExpert() async{
    List<IndexExpert> indexExpertList = IndexExpert.fromJsonList(await request(servicePath['indexSelectExpert'], formData: []));
    return indexExpertList;
  }
}
