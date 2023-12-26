class EventsModel {
  EventsModel({
    required this.isSuccess,
    required this.data,
    required this.errors,
  });
  late final bool isSuccess;
  late final Data data;
  late final List<dynamic> errors;

  EventsModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = Data.fromJson(json['data']);
    errors = List.castFrom<dynamic, dynamic>(json['errors']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isSuccess'] = isSuccess;
    _data['data'] = data.toJson();
    _data['errors'] = errors;
    return _data;
  }
}

class Data {
  Data({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.events,
  });
  late final int currentPage;
  late final int totalPages;
  late final int pageSize;
  late final int totalCount;
  late final List<Event> events;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    events = List.from(json['events']).map((e) => Event.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['currentPage'] = currentPage;
    _data['totalPages'] = totalPages;
    _data['pageSize'] = pageSize;
    _data['totalCount'] = totalCount;
    _data['events'] = events.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Event {
  Event({
    this.eventName,
    this.eventDescription,
    this.eventAddress,
    this.startDate,
    this.endDate,
    this.link,
    this.notifyBefore,
    this.jobCategoryIdList,
    this.residencyTypeList,
    this.residenceCountryIdList,
    this.isActive,
  });
  String? eventName;
  String? eventDescription;
  String? eventAddress;
  String? startDate;
  String? endDate;
  String? link;
  int? notifyBefore;
  String? jobCategoryIdList;
  int? residencyTypeList;
  int? residenceCountryIdList;
  bool? isActive;

  Event.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    eventDescription = json['eventDescription'];
    eventAddress = json['eventAddress'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    link = json['link'];
    notifyBefore = json['notifyBefore'];
    jobCategoryIdList = json['jobCategoryIdList'];
    residencyTypeList = null;
    residenceCountryIdList = null;
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['eventName'] = eventName;
    _data['eventDescription'] = eventDescription;
    _data['eventAddress'] = eventAddress;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['link'] = link;
    _data['notifyBefore'] = notifyBefore;
    _data['jobCategoryIdList'] = jobCategoryIdList;
    _data['residencyTypeList'] = residencyTypeList;
    _data['residenceCountryIdList'] = residenceCountryIdList;
    _data['isActive'] = isActive;
    return _data;
  }
}
