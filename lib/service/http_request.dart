import 'package:xianyu_app/model/BannerInfo.dart';
import 'package:xianyu_app/model/TodayNews.dart';
import 'package:xianyu_app/model/IndexCategory.dart';
import 'package:xianyu_app/model/IndexExpert.dart';
import 'package:xianyu_app/model/IndexLesson.dart';
import 'package:xianyu_app/model/CategoryType.dart';
import 'package:xianyu_app/model/PageInfo.dart';
import 'package:xianyu_app/model/CategoryInfo.dart';
import 'package:xianyu_app/model/CourseInfo.dart';
import 'package:xianyu_app/model/ListDao4Page.dart';


import 'package:xianyu_app/service/service_method.dart';
import 'dart:convert';

//const serviceUrl = 'https://delphis.cn';
//const serviceUrl = 'https://api.xfindzp.com';
const serviceUrl = 'http://192.168.16.88:8090';

const qiniuUrl = 'https://xfindcdn.xfindzp.com/';
const servicePath={
  'getSwiperList': serviceUrl+'/xianyu/indexImage/list', // 商家首页信息
  'todayNews': serviceUrl+'/xianyu/index/today/news', // 今日选文
  'indexSelectCategory': serviceUrl+'/xianyu/index/select/category', // 精选测评
  'indexSelectExpert': serviceUrl+'/xianyu/index/select/expert', // 精选测评
  'indexSelectLesson': serviceUrl+'/xianyu/index/select/lesson', // 精选课程
  'categoryTypeList': serviceUrl + '/xianyu/categoryType/list',// 获取测评分类列表
  'categoryList': serviceUrl + '/xianyu/categoryXianyu/list',// 获取测评列表
  'getCourseType': serviceUrl + "/xianyu/lessonType/list?query=''",// 获取课程类型
  'getCourseList': serviceUrl + "/xianyu/lesson/pageList",// 获取课程列表
  'expertTypeList': serviceUrl + "/xianyu/xyexperttype/list",// 获取专家类型
  'expertList': serviceUrl + "/xianyu/expert/list",// 获取专家列表
  'newsTypeList': serviceUrl + "/xianyu/xynewstype/list",// 获取新闻类型
  'newsPageList': serviceUrl + "/xianyu/news/pageList",// 获取文章的列表信息
  'newsPageInfo': serviceUrl + "/xianyu/news/info",// 获取文章的详细信息


};
class HttpRequest {
  Future reqSwiperList() async{
    List<BannerInfo> bannerInfoList = BannerInfo.fromJsonList((await request(servicePath['getSwiperList'], formData: {}))['list']);
    return bannerInfoList;
  }
  Future reqTodayNews() async{
    TodayNews todayNews = TodayNews.fromJson((await requestGet(servicePath['todayNews'], formData: null))[0]);
    return todayNews;
  }
  Future indexSelectCategory() async{
    List<IndexCategory> indexCategoryList = IndexCategory.fromJsonList(await request(servicePath['indexSelectCategory'], formData: []));
    return indexCategoryList;
  }
  Future indexExpert() async{
    var respondData = await request(servicePath['indexSelectExpert'], formData: []);
    List<IndexExpert> indexExpertList = IndexExpert.fromJsonList(respondData);
    return indexExpertList;
  }
  Future indexLesson() async{
    var response = await request(servicePath['indexSelectLesson'], formData: []);
    var indexExpertList =  IndexLesson.fromJsonList(response);
    return indexExpertList;
  }

  Future categoryList({int currPage,int pageSize,int typeId,String orderBy}) async{
    var response = await request(servicePath['categoryList'], formData: {'currPage':currPage,'pageSize':pageSize,'typeId':typeId,'orderBy':orderBy});
    ListDao4Page<CategoryInfo> result = ListDao4Page.fromJson(
        CategoryInfo.fromJsonList(response['list']),
        PageInfo.fromJson(response['page'])
    );
    return result;
  }

  Future requestCourseList({int currPage,int pageSize,int typeId,int lessonTypeId,String orderBy = "sort"}) async{
    var response = await request(servicePath['getCourseList'], formData: {'query':{'lessonTypeId':lessonTypeId,'orderBy':orderBy, 'online': 1},'currPage': currPage , 'pageSize':pageSize});
    ListDao4Page<IndexLesson> result = ListDao4Page.fromJson(
        IndexLesson.fromJsonList(response['list']),
        PageInfo.fromJson(response['page'])
    );
    return result;
  }
  // type 类型 1 获取测评类型 2 获取课程类型 3 获取专家类型
  getXianYuTypeList(int type) async {
    String urlName = 'getCourseType';
    if(type==1){
      urlName = 'getCourseType';
    }else if(type==2){
      urlName = 'categoryTypeList';
    }else if(type==3){
      urlName = 'expertTypeList';
    }else if(type==4){
      urlName = 'newsTypeList';
    }
    var result = await request(servicePath[urlName], formData: {});
    List<CategoryType> fromJsonList;
    if(type==4){
      fromJsonList = CategoryType.fromJsonList(result);
    }else{
      fromJsonList = CategoryType.fromJsonList(result['list']);
    }
    return fromJsonList;
  }
  Future postExpertList({int currPage,int pageSize,int typeId,String orderBy = "sort"}) async{
    var response = await request(servicePath['expertList'], formData: {'query':{},'currPage': currPage , 'pageSize':pageSize,'typeId':typeId,'orderBy':orderBy, 'status': 1});
    ListDao4Page<IndexExpert> result = ListDao4Page.fromJson(
        IndexExpert.fromJsonList(response['list']),
        PageInfo.fromJson(response['page'])
    );
    return result;
  }
  Future postNewsPageList({int currPage,int pageSize,int typeId}) async{
    var response = await request(servicePath['newsPageList'], formData: {'query':{'typeId':typeId},'currPage': currPage , 'pageSize':pageSize});
//    String str = json.encode(response['list'][0]);
    ListDao4Page<TodayNews> result = ListDao4Page.fromJson(
        TodayNews.fromJsonList(response['list']),
        PageInfo.fromJson(response['page'])
    );
    return result;
  }
  Future postNewsInfo({int id,int userId}) async{
    var response = await request(servicePath['newsPageInfo'], formData: {'query':{'userId':userId,'id':id}});
    return TodayNews.fromJson(response);
  }
}
