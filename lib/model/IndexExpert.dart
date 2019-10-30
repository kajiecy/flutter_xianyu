class IndexExpert {
  int id;
  String name;
  int sex;
  int birth;
  String phone;
  String place;
  String phoneConsult;
  double phonePrice;
  String videoConsult;
  double videoPrice;
  String interviewConsult;
  double interviewPrice;
  String status;
  Null createTime;
  int settleTime;
  String educationDescription;
  String employmentDescription;
  int employmentYears;
  String expertiseField;
  String consultObject;
  int consultHours;
  String orderTimeDescription;
  String avatar;
  String personImage;
  String personProfile;
  Null weekReadNum;
  int typeId;
  int isSelect;
  Null selectSort;
  Null count;
  Null countOrder;
  Null countOrderSuccess;
  Null countOrderOver;
  Null typeName;

  IndexExpert(
      {this.id,
        this.name,
        this.sex,
        this.birth,
        this.phone,
        this.place,
        this.phoneConsult,
        this.phonePrice,
        this.videoConsult,
        this.videoPrice,
        this.interviewConsult,
        this.interviewPrice,
        this.status,
        this.createTime,
        this.settleTime,
        this.educationDescription,
        this.employmentDescription,
        this.employmentYears,
        this.expertiseField,
        this.consultObject,
        this.consultHours,
        this.orderTimeDescription,
        this.avatar,
        this.personImage,
        this.personProfile,
        this.weekReadNum,
        this.typeId,
        this.isSelect,
        this.selectSort,
        this.count,
        this.countOrder,
        this.countOrderSuccess,
        this.countOrderOver,
        this.typeName});

  IndexExpert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sex = json['sex'];
    birth = json['birth'];
    phone = json['phone'];
    place = json['place'];
    phoneConsult = json['phoneConsult'];
    phonePrice = json['phonePrice'];
    videoConsult = json['videoConsult'];
    videoPrice = json['videoPrice'];
    interviewConsult = json['interviewConsult'];
    interviewPrice = json['interviewPrice'];
    status = json['status'];
    createTime = json['createTime'];
    settleTime = json['settleTime'];
    educationDescription = json['educationDescription'];
    employmentDescription = json['employmentDescription'];
    employmentYears = json['employmentYears'];
    expertiseField = json['expertiseField'];
    consultObject = json['consultObject'];
    consultHours = json['consultHours'];
    orderTimeDescription = json['orderTimeDescription'];
    avatar = json['avatar'];
    personImage = json['personImage'];
    personProfile = json['personProfile'];
    weekReadNum = json['weekReadNum'];
    typeId = json['typeId'];
    isSelect = json['isSelect'];
    selectSort = json['selectSort'];
    count = json['count'];
    countOrder = json['countOrder'];
    countOrderSuccess = json['countOrderSuccess'];
    countOrderOver = json['countOrderOver'];
    typeName = json['typeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sex'] = this.sex;
    data['birth'] = this.birth;
    data['phone'] = this.phone;
    data['place'] = this.place;
    data['phoneConsult'] = this.phoneConsult;
    data['phonePrice'] = this.phonePrice;
    data['videoConsult'] = this.videoConsult;
    data['videoPrice'] = this.videoPrice;
    data['interviewConsult'] = this.interviewConsult;
    data['interviewPrice'] = this.interviewPrice;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['settleTime'] = this.settleTime;
    data['educationDescription'] = this.educationDescription;
    data['employmentDescription'] = this.employmentDescription;
    data['employmentYears'] = this.employmentYears;
    data['expertiseField'] = this.expertiseField;
    data['consultObject'] = this.consultObject;
    data['consultHours'] = this.consultHours;
    data['orderTimeDescription'] = this.orderTimeDescription;
    data['avatar'] = this.avatar;
    data['personImage'] = this.personImage;
    data['personProfile'] = this.personProfile;
    data['weekReadNum'] = this.weekReadNum;
    data['typeId'] = this.typeId;
    data['isSelect'] = this.isSelect;
    data['selectSort'] = this.selectSort;
    data['count'] = this.count;
    data['countOrder'] = this.countOrder;
    data['countOrderSuccess'] = this.countOrderSuccess;
    data['countOrderOver'] = this.countOrderOver;
    data['typeName'] = this.typeName;
    return data;
  }

  static fromJsonList(List<dynamic> jsonList) {
    List<IndexExpert> resultList = [];
    jsonList.forEach((item)=>{
      resultList.add(IndexExpert.fromJson(item))
    });
    return resultList;
  }
}