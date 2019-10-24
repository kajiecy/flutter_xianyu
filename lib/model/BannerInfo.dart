class BannerInfo {
  int id;
  String image;
  int linkType;
  String linkUrl;
  int sort;
  String remark;

  BannerInfo(
      {this.id,
        this.image,
        this.linkType,
        this.linkUrl,
        this.sort,
        this.remark});

  BannerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    linkType = json['linkType'];
    linkUrl = json['linkUrl'];
    sort = json['sort'];
    remark = json['remark'];
  }
  static fromJsonList(List<dynamic> jsonList) {
    List<BannerInfo> bannerInfoList = [];
    jsonList.forEach((item)=>{
      bannerInfoList.add(BannerInfo.fromJson(item))
    });
    return bannerInfoList;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['linkType'] = this.linkType;
    data['linkUrl'] = this.linkUrl;
    data['sort'] = this.sort;
    data['remark'] = this.remark;
    return data;
  }
}
