class IndexLesson {
  int id;
  int fileType;
  String title;
  int lessonTypeId;
  String author;
  String price;
  int createTime;
  int playTimes;
  String listPic;
  String infoPic;
  String description;
  int isIndexShow;
  int showSort;
  String introduction;
  Null coursewareList;
  Null lessonTypeName;
  Null coursewareCount;
  Null commentCount;
  Null reportCount;
  Null collectionCount;
  Null buyCount;

  IndexLesson(
      {this.id,
        this.fileType,
        this.title,
        this.lessonTypeId,
        this.author,
        this.price,
        this.createTime,
        this.playTimes,
        this.listPic,
        this.infoPic,
        this.description,
        this.isIndexShow,
        this.showSort,
        this.introduction,
        this.coursewareList,
        this.lessonTypeName,
        this.coursewareCount,
        this.commentCount,
        this.reportCount,
        this.collectionCount,
        this.buyCount});

  IndexLesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileType = json['fileType'];
    title = json['title'];
    lessonTypeId = json['lessonTypeId'];
    author = json['author'];
    price = json['price'];
    createTime = json['createTime'];
    playTimes = json['playTimes'];
    listPic = json['listPic'];
    infoPic = json['infoPic'];
    description = json['description'];
    isIndexShow = json['isIndexShow'];
    showSort = json['showSort'];
    introduction = json['introduction'];
    coursewareList = json['coursewareList'];
    lessonTypeName = json['lessonTypeName'];
    coursewareCount = json['coursewareCount'];
    commentCount = json['commentCount'];
    reportCount = json['reportCount'];
    collectionCount = json['collectionCount'];
    buyCount = json['buyCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fileType'] = this.fileType;
    data['title'] = this.title;
    data['lessonTypeId'] = this.lessonTypeId;
    data['author'] = this.author;
    data['price'] = this.price;
    data['createTime'] = this.createTime;
    data['playTimes'] = this.playTimes;
    data['listPic'] = this.listPic;
    data['infoPic'] = this.infoPic;
    data['description'] = this.description;
    data['isIndexShow'] = this.isIndexShow;
    data['showSort'] = this.showSort;
    data['introduction'] = this.introduction;
    data['coursewareList'] = this.coursewareList;
    data['lessonTypeName'] = this.lessonTypeName;
    data['coursewareCount'] = this.coursewareCount;
    data['commentCount'] = this.commentCount;
    data['reportCount'] = this.reportCount;
    data['collectionCount'] = this.collectionCount;
    data['buyCount'] = this.buyCount;
    return data;
  }
  static fromJsonList(List<dynamic> jsonList) {
    List<IndexLesson> resultList = [];
    jsonList.forEach((item)=>{
      resultList.add(IndexLesson.fromJson(item))
    });
    return resultList;
  }
}