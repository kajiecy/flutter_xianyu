import 'package:flutter/material.dart';
import 'package:xianyu_app/model/IndexExpert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xianyu_app/service/http_request.dart';

// 专家咨询
class IndexExpertDiv extends StatelessWidget {
  final List<IndexExpert> expertList;
  IndexExpertDiv({this.expertList});
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
                  '专家咨询',
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
              height: ScreenUtil().setHeight(695),
              child:ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: expertList.length,
                itemBuilder: (context,index){
                  return categoryItem(expertList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // 精选测评循环item
  Widget categoryItem(IndexExpert indexExpert){
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
                  width: ScreenUtil().setWidth(120),
                  height: ScreenUtil().setHeight(120),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/img/placeholder135x180.png",
                      image: qiniuUrl+indexExpert.avatar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // 今日选文的右侧信息展示
                Container(
                  width: ScreenUtil().setWidth(492),
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0)),
                  height: ScreenUtil().setHeight(128),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(indexExpert.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(32.0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                          width: ScreenUtil().setWidth(500),
                          child: Text(indexExpert.employmentDescription,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                color: Color(0xff88898B)
                            ),
                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                          width: ScreenUtil().setWidth(500),
                          child: Text('咨询时长:${indexExpert.consultHours}小时',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                color: Color(0xff88898B)
                            ),
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