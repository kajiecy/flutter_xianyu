import 'package:xianyu_app/model/BannerInfo.dart';

import 'package:xianyu_app/service/service_method.dart';


const serviceUrl = 'http://192.168.16.254:7070';
const servicePath={
  'getSwiperList': serviceUrl+'/xianyu/indexImage/list', // 商家首页信息
};
class HttpRequest {
  Future<List<BannerInfo>> getSwiperList() async{
    List<BannerInfo> bannerInfoList = BannerInfo.fromJsonList((await request(servicePath['getSwiperList'], formData: {}))['list']);
    return bannerInfoList;
  }
}
