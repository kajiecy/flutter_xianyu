import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:xianyu_app/model/IndexCategory.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xianyu_app/provide/app_provide.dart';
import 'package:xianyu_app/service/http_request.dart';

// 精选测评
class IndexCategoryDiv extends StatelessWidget {
  final List<IndexCategory> categoryList;
  IndexCategoryDiv({this.categoryList});
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
                  '精选测评'+Provide.value<AppProvide>(context).homeTabsIndex.toString(),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(105),
                  height: ScreenUtil().setHeight(50),
                  child: Provide<AppProvide>(builder: (builder, child, appProvide) {
                    return OutlineButton(
                      child: Text('更多',style: TextStyle(fontSize: ScreenUtil().setSp(22)),),
                      borderSide: BorderSide(color: Color(0xdd3673EE)),
                      textColor: Color(0xff3673EE),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)),side: BorderSide(width: 0.5)),
                      onPressed: (){
                        appProvide.changeHomeTabsIndex(1);
                      },
                    );
                  }),
                ),
              ],
            ),
            Divider(),
            // 精选测评的主体部分
            Container(
              height: ScreenUtil().setHeight(790),
              child:ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: categoryList.length,
                itemBuilder: (context,index){
                  return categoryItem(categoryList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // 精选测评循环item
  Widget categoryItem(IndexCategory indexCategory){
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
                  width: ScreenUtil().setWidth(150),
                  height: ScreenUtil().setHeight(150),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/img/placeholder135x180.png",
                      image: qiniuUrl+indexCategory.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // 今日选文的右侧信息展示
                Container(
                  width: ScreenUtil().setWidth(492),
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0)),
                  height: ScreenUtil().setHeight(150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(indexCategory.categoryName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(32.0),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            width: ScreenUtil().setWidth(332),
                          ),
                          Container(
                            child: Text(indexCategory.testNum.toString()+'人测过',
                              style: TextStyle(
                                color: Color(0xffFF9C00),
                                fontSize: ScreenUtil().setSp(24.0),
                              ),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                          width: ScreenUtil().setWidth(500),
//                    height: ScreenUtil().sw,
                          child: Text(indexCategory.description,
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