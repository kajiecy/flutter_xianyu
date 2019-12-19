class PageInfo {
  int totalResultSize;
  int totalPageSize;
  int pageSize;
  int currentPage;
  int startRow;
  bool first;
  bool last;
  int pageNum;
  List<int> pageNums;
  int startRecord;
  int endRecord;

  PageInfo(
      {this.totalResultSize,
        this.totalPageSize,
        this.pageSize,
        this.currentPage,
        this.startRow,
        this.first,
        this.last,
        this.pageNum,
        this.pageNums,
        this.startRecord,
        this.endRecord});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalResultSize = json['totalResultSize'];
    totalPageSize = json['totalPageSize'];
    pageSize = json['pageSize'];
    currentPage = json['currentPage'];
    startRow = json['startRow'];
    first = json['first'];
    last = json['last'];
    pageNum = json['pageNum'];
    pageNums = json['pageNums'].cast<int>();
    startRecord = json['startRecord'];
    endRecord = json['endRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResultSize'] = this.totalResultSize;
    data['totalPageSize'] = this.totalPageSize;
    data['pageSize'] = this.pageSize;
    data['currentPage'] = this.currentPage;
    data['startRow'] = this.startRow;
    data['first'] = this.first;
    data['last'] = this.last;
    data['pageNum'] = this.pageNum;
    data['pageNums'] = this.pageNums;
    data['startRecord'] = this.startRecord;
    data['endRecord'] = this.endRecord;
    return data;
  }
}