import 'package:flutter/material.dart';
import 'package:xianyu_app/service/http_request.dart';
import 'package:xianyu_app/model/TodayNews.dart';
import 'package:xianyu_app/model/PageInfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

int newsId_common;
class NewsContent extends StatefulWidget {
  NewsContent({@required int newsId}){
    newsId_common = newsId;
  }
  @override
  _NewsContentState createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent> {
  TodayNews newsInfo = TodayNews();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initData(),
      builder: (context,snapshot){
        if(snapshot.hasData){
//          if(_tabController==null){
//            _animationController = AnimationController(vsync: this);
//            _tabController = TabController(vsync: this, length: this.categoryTypeList.length);
//          }
          return Scaffold(
            backgroundColor: Color(0xffffffff),
              appBar: AppBar(title: Text(newsInfo.title,maxLines: 1,overflow: TextOverflow.ellipsis,),),
              body:ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30),horizontal: ScreenUtil().setWidth(20)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // 今日选文的左侧图片
                        Container(
                          width: ScreenUtil().setWidth(70),
                          height: ScreenUtil().setHeight(90),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/img/placeholder135x180.png",
                              image: qiniuUrl+newsInfo.pic,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // 今日选文的右侧信息展示
                        Container(
                          width: ScreenUtil().setWidth(510),
                          padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0)),
                          height: ScreenUtil().setHeight(90),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(newsInfo.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(36.0),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(newsInfo.readTimes.toString()+'人阅读',
                                style: TextStyle(
                                  color: Color(0xff888888),
                                  fontSize: ScreenUtil().setSp(24.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Html(data: newsInfo.content)
                ],
              )
          );
        }else{
          return Scaffold(appBar: AppBar(title: Text('精选文章'),),
            body: Center(child: Text('暂无数据'),),
          );
        }
      },
    );
  }
  Future initData({currentPage}) async {
    this.newsInfo = await HttpRequest().postNewsInfo(id: newsId_common,userId: 20);
//    await HttpRequest().postNewsPageList(currPage: 1,pageSize: 10,orderBy:selectItemValue);
    return 'ok';
  }
}
