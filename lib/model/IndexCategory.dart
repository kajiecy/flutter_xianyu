class IndexCategory {
  int id;
  int categoryId;
  String typeId;
  double price;
  int testNum;
  int submitNum;
  int sort;
  int createTime;
  String status;
  int weekReadNum;
  int readNum;
  int resultReadNum;
  int isSelect;
  int selectSort;
  String categoryName;
  String categoryTitle;
  Null categoryTypeNames;
  String image;
  Null totalNum;
  String description;
  String listImage;
  Null countNum;
  Null countTestNum;
  Null countSubmitNum;
  Null countReadNum;
  Null countResultReadNum;

  IndexCategory(
      {this.id,
        this.categoryId,
        this.typeId,
        this.price,
        this.testNum,
        this.submitNum,
        this.sort,
        this.createTime,
        this.status,
        this.weekReadNum,
        this.readNum,
        this.resultReadNum,
        this.isSelect,
        this.selectSort,
        this.categoryName,
        this.categoryTitle,
        this.categoryTypeNames,
        this.image,
        this.totalNum,
        this.description,
        this.listImage,
        this.countNum,
        this.countTestNum,
        this.countSubmitNum,
        this.countReadNum,
        this.countResultReadNum});

  IndexCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    typeId = json['typeId'];
    price = json['price'];
    testNum = json['testNum'];
    submitNum = json['submitNum'];
    sort = json['sort'];
    createTime = json['createTime'];
    status = json['status'];
    weekReadNum = json['weekReadNum'];
    readNum = json['readNum'];
    resultReadNum = json['resultReadNum'];
    isSelect = json['isSelect'];
    selectSort = json['selectSort'];
    categoryName = json['categoryName'];
    categoryTitle = json['categoryTitle'];
    categoryTypeNames = json['categoryTypeNames'];
    image = json['image'];
    totalNum = json['totalNum'];
    description = json['description'];
    listImage = json['listImage'];
    countNum = json['countNum'];
    countTestNum = json['countTestNum'];
    countSubmitNum = json['countSubmitNum'];
    countReadNum = json['countReadNum'];
    countResultReadNum = json['countResultReadNum'];
  }
  static fromJsonList(List<dynamic> jsonList) {
    List<IndexCategory> categoryList = [];
    jsonList.forEach((item)=>{
      categoryList.add(IndexCategory.fromJson(item))
    });
    return categoryList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['typeId'] = this.typeId;
    data['price'] = this.price;
    data['testNum'] = this.testNum;
    data['submitNum'] = this.submitNum;
    data['sort'] = this.sort;
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    data['weekReadNum'] = this.weekReadNum;
    data['readNum'] = this.readNum;
    data['resultReadNum'] = this.resultReadNum;
    data['isSelect'] = this.isSelect;
    data['selectSort'] = this.selectSort;
    data['categoryName'] = this.categoryName;
    data['categoryTitle'] = this.categoryTitle;
    data['categoryTypeNames'] = this.categoryTypeNames;
    data['image'] = this.image;
    data['totalNum'] = this.totalNum;
    data['description'] = this.description;
    data['listImage'] = this.listImage;
    data['countNum'] = this.countNum;
    data['countTestNum'] = this.countTestNum;
    data['countSubmitNum'] = this.countSubmitNum;
    data['countReadNum'] = this.countReadNum;
    data['countResultReadNum'] = this.countResultReadNum;
    return data;
  }
}