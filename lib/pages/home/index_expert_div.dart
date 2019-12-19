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
              height: ScreenUtil().setHeight(450),
              child:ListView.builder(
                scrollDirection: Axis.horizontal,
//                physics: NeverScrollableScrollPhysics(),
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
  // 专家咨询循环item
  Widget categoryItem(IndexExpert indexExpert){
    List<String> useList = [];

    checkFlag(String str,int index){
      if(index+1>=str.length){
        return;
      }
      int maoIndex = str.indexOf("：",index);
      int juIndex = str.indexOf("。",index)==-1?str.length-1:str.indexOf("。",index);
      //截取冒号和句号中间的字符
      String userOriginal = str.substring(maoIndex+1,juIndex);
      List<String> itemList = userOriginal.split("、");
      useList.addAll(itemList);
      if(useList.length<4){
        checkFlag(str,juIndex+1);
      }
    }
    checkFlag(indexExpert.expertiseField,0);
    List<Widget> getUseListWidget(){
      List<Widget> resultList = [];
      useList.forEach((item)=>{
        resultList.add(Container(
          child: Text(item,style: TextStyle(color: Color(0xff333333)),),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(7.5),vertical: ScreenUtil().setHeight(10)),
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),vertical: ScreenUtil().setHeight(3)),
          decoration: BoxDecoration(
            color: Color(0xffF3F7FA),
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
        ))
      });
      return resultList;
    }

    return Card(
      clipBehavior: Clip.antiAlias, // 根据设置裁剪内容
      elevation: 0.5,
      margin: EdgeInsets.only(top: 10,bottom: 20,left: 5,right: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)),side: BorderSide(width: 0.5,color: Colors.black12)),
      child: Container(
        width: ScreenUtil().setWidth(330.0),
        child: Stack(
          children: <Widget>[
            // 左上角的角标
            Positioned(
              child: Container(
                  child: Text(
                      '从业${indexExpert.employmentYears}年',
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                padding: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                decoration: BoxDecoration(
                    color:Color.fromRGBO(253,161,60,1),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6)),
                  boxShadow: [
                    new BoxShadow(
                      color: Color(0xffFF7200),//阴影颜色
                      blurRadius: 4.0,//阴影大小
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(330),
              child:Column(
//              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                    width: ScreenUtil().setWidth(120),
                    height: ScreenUtil().setHeight(120),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x66232D5D),
                          blurRadius: 5.0
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),

                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/img/placeholder135x180.png",
                        image: qiniuUrl+indexExpert.avatar,
                        fit: BoxFit.cover,

                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                    child: Text(indexExpert.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(32.0),
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(4,5,10,1),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                    child: Text('咨询时长:${indexExpert.consultHours}小时',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(24.0),
                        fontWeight: FontWeight.w500,
                        color: Color(0xff71859E),
                      ),
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(130),
//                    decoration: BoxDecoration(color: Colors.blue),
                    child: Wrap(
                      verticalDirection: VerticalDirection.down,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: getUseListWidget(),
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
