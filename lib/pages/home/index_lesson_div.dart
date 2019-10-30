import 'package:flutter/material.dart';
import 'package:xianyu_app/model/IndexLesson.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xianyu_app/service/http_request.dart';

// 精选测评
class IndexLessonDiv extends StatelessWidget {
  final List<IndexLesson> lessonList;
  IndexLessonDiv({this.lessonList});
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
            // 精选测评的标题
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '贤于课堂',
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
                    onPressed: (){},
                  ),
                ),
              ],
            ),
            Divider(),
            // 精选测评的主体部分
            Container(
              height: ScreenUtil().setHeight(905),
              child:ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: lessonList.length,
                itemBuilder: (context,index){
                  return categoryItem(lessonList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // 精选测评循环item
  Widget categoryItem(IndexLesson item){
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5),horizontal: ScreenUtil().setWidth(0)),
      child:
      Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10),top: ScreenUtil().setHeight(5)),
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
                      image: qiniuUrl+item.listPic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // 今日选文的右侧信息展示
                Container(
                  width: ScreenUtil().setWidth(522),
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0)),
                  height: ScreenUtil().setHeight(180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text(item.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(32.0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        width: ScreenUtil().setWidth(475),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            verticalDirection: VerticalDirection.up,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/img/lesson/mic.png',width: ScreenUtil().setSp(30),height: ScreenUtil().setSp(30),),
                              Text(item.author,
                                style: TextStyle(
                                  color: Color(0xff525156),
                                  fontSize: ScreenUtil().setSp(24),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '免费',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(26),
                              color: Color(0xffFF9C00),
                            ),
                          )
                        ],
                      ),
                      ),
                      Expanded(
                        child: Text(item.description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xff88898B),
                            fontSize: ScreenUtil().setSp(24.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset('assets/img/lesson/play1.png',width: ScreenUtil().setSp(30),height: ScreenUtil().setSp(30),),
                                Text(' '),
                                Text(item.playTimes!=null ?item.playTimes.toString()+'次播放': '0次播放',
                                  style: TextStyle(
                                    color: Color(0xff88898B),
                                    fontSize: ScreenUtil().setSp(24),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(item.fileType==1?'assets/img/lesson/audio.png':'assets/img/lesson/video.png',width: ScreenUtil().setSp(30),height: ScreenUtil().setSp(30),),
                                  Text(item.fileType==1?' 音频':' 视频',
                                    style: TextStyle(
                                      color: Color(0xff88898B),
                                      fontSize: ScreenUtil().setSp(24),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}