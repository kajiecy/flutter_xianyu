import 'package:xianyu_app/model/BannerInfo.dart';
import 'package:xianyu_app/model/TodayNews.dart';
import 'package:xianyu_app/model/IndexCategory.dart';
import 'package:xianyu_app/model/IndexExpert.dart';
import 'package:xianyu_app/model/IndexLesson.dart';
import 'package:xianyu_app/model/CategoryType.dart';
import 'package:xianyu_app/model/PageInfo.dart';
import 'package:xianyu_app/model/CategoryInfo.dart';
import 'package:xianyu_app/model/ListDao4Page.dart';


import 'package:xianyu_app/service/service_method.dart';
import 'dart:convert';

//const serviceUrl = 'https://delphis.cn';
const serviceUrl = 'https://api.xfindzp.com';
const qiniuUrl = 'https://xfindcdn.xfindzp.com/';
const servicePath={
  'getSwiperList': serviceUrl+'/xianyu/indexImage/list', // 商家首页信息
  'todayNews': serviceUrl+'/xianyu/index/today/news', // 今日选文
  'indexSelectCategory': serviceUrl+'/xianyu/index/select/category', // 精选测评
  'indexSelectExpert': serviceUrl+'/xianyu/index/select/expert', // 精选测评
  'indexSelectLesson': serviceUrl+'/xianyu/index/select/lesson', // 精选课程
  'categoryTypeList': serviceUrl + '/xianyu/categoryType/list',//获取测评分类列表
  'categoryList': serviceUrl + '/xianyu/categoryXianyu/list',//获取课程列表
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
    var respondData = await request(servicePath['indexSelectExpert'], formData: []);
    List<IndexExpert> indexExpertList = IndexExpert.fromJsonList(respondData);
    return indexExpertList;
  }
  Future indexLesson() async{
    var response = await request(servicePath['indexSelectLesson'], formData: []);
    String responseStr = json.encode(response);
    var indexExpertList =  IndexLesson.fromJsonList(response);
//  List<IndexExpert> indexExpertList = IndexExpert.fromJsonList(await request(servicePath['indexSelectLesson'], formData: []));
    return indexExpertList;
  }
  Future categoryTypeList({int currPage,int pageSize}) async{
    var response = await request(servicePath['categoryTypeList'], formData: {'currPage':currPage,'pageSize':pageSize});
    List<CategoryType> fromJsonList = CategoryType.fromJsonList(response['list']);
    return fromJsonList;
  }
  Future categoryList({int currPage,int pageSize,String typeId}) async{
    var response = await request(servicePath['categoryList'], formData: {'currPage':currPage,'pageSize':pageSize,'typeId':typeId});
//    String responseStr = json.encode(response);
    ListDao4Page<CategoryInfo> result = ListDao4Page.fromJson(
        CategoryInfo.fromJsonList(response['list']),
        PageInfo.fromJson(response['page'])
    );
    return result;
  }

}
