class TodayNews {
  int id;
  String title;
  int typeId;
  String author;
  String src;
  int readTimes;
  int isTodaySelect;
  int todaySelectTime;
  int createTime;
  String pic;
  String description;
  String content;
  String newsTypeName;
  int reportCount;
  int readCount;
  int commentCount;
  int likeCount;

  TodayNews(
      { this.id,
        this.title,
        this.typeId,
        this.author,
        this.src,
        this.readTimes,
        this.isTodaySelect,
        this.todaySelectTime,
        this.createTime,
        this.pic,
        this.description,
        this.content,
        this.newsTypeName,
        this.reportCount,
        this.readCount,
        this.commentCount,
        this.likeCount});
  TodayNews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    typeId = json['typeId'];
    author = json['author'];
    src = json['src'];
    readTimes = json['readTimes'];
    isTodaySelect = json['isTodaySelect'];
    todaySelectTime = json['todaySelectTime'];
    createTime = json['createTime'];
    pic = json['pic'];
    description = json['description'];
    content = json['content'];
    newsTypeName = json['newsTypeName'];
    reportCount = json['reportCount'];
    readCount = json['readCount'];
    commentCount = json['commentCount'];
    likeCount = json['likeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['typeId'] = this.typeId;
    data['author'] = this.author;
    data['src'] = this.src;
    data['readTimes'] = this.readTimes;
    data['isTodaySelect'] = this.isTodaySelect;
    data['todaySelectTime'] = this.todaySelectTime;
    data['createTime'] = this.createTime;
    data['pic'] = this.pic;
    data['description'] = this.description;
    data['content'] = this.content;
    data['newsTypeName'] = this.newsTypeName;
    data['reportCount'] = this.reportCount;
    data['readCount'] = this.readCount;
    data['commentCount'] = this.commentCount;
    data['likeCount'] = this.likeCount;
    return data;
  }
  static fromJsonList(List<dynamic> jsonList) {
    List<TodayNews> resultList = [];
    jsonList.forEach((item)=>{
      resultList.add(TodayNews.fromJson(item))
    });
    return resultList;
  }
}