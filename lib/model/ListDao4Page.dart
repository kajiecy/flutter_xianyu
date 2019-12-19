import 'package:xianyu_app/model/PageInfo.dart';

class ListDao4Page<T> {
  List<T> infoList;
  PageInfo pageInfo;
  ListDao4Page(
      this.infoList,
      this.pageInfo,
  );
  ListDao4Page.fromJson(List<T> infoList,PageInfo pageInfo) {
    this.infoList = infoList;
    this.pageInfo = pageInfo;
  }
}