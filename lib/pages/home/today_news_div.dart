import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianyu_app/model/TodayNews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xianyu_app/service/http_request.dart';
import 'package:xianyu_app/routers/application.dart';
import 'package:xianyu_app/pages/home/search/search_index.dart';

// 今日选文
class TodayNewsDiv extends StatelessWidget {
  final TodayNews todayNews;
  TodayNewsDiv({this.todayNews});
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, // 根据设置裁剪内容
      elevation: 3.0,
      margin: EdgeInsets.only(top: 20,bottom: 5,left: 15,right: 15),

      child:Container(
        padding: EdgeInsets.all(10.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 今日选文的标题
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '今日选文',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(105),
                  height: ScreenUtil().setHeight(50),
                  child:OutlineButton(
                    child: Text('更多',style: TextStyle(fontSize: ScreenUtil().setSp(22)),),
                    borderSide: BorderSide(color: Color(0xdd3673EE)),
                    textColor: Color(0xff3673EE),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)),side: BorderSide(width: 0.5)),
                    onPressed: (){
                      Application.router.navigateTo(context, '/news_index',transition: TransitionType.cupertino);
                    },
                  ),
                ),
              ],
            ),
            Divider(),
            // 今日选文的主体部分
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5),horizontal: ScreenUtil().setWidth(0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 今日选文的左侧图片
                  Container(
                    width: ScreenUtil().setWidth(135),
                    height: ScreenUtil().setHeight(180),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/img/placeholder135x180.png",
                        image: qiniuUrl+todayNews.pic,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // 今日选文的右侧信息展示
                  Container(
                    width: ScreenUtil().setWidth(510),
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0)),
                    height: ScreenUtil().setHeight(180),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(todayNews.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(32.0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text.rich(TextSpan(
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(26.0),
                              color: Color(0xff525156),
                            ),
                            children: [
                              TextSpan(
                                  text: todayNews.author
                              ),
                              TextSpan(
                                  text: ' | '
                              ),
                              TextSpan(
                                  text: todayNews.src
                              ),
                            ]
                        )
                        ),
                        Text(todayNews.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xff88898B),
                            fontSize: ScreenUtil().setSp(24.0),
                          ),
                        ),
                        Text(todayNews.readTimes.toString()+'人阅读',
                          style: TextStyle(
                            color: Color(0xffFF9C00),
                            fontSize: ScreenUtil().setSp(24.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}