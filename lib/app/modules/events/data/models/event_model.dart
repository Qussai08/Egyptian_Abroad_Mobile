class EventsModel {
  EventsModel({
    required this.isSuccess,
    required this.data,
    required this.errors,
  });
  late final bool isSuccess;
  late final EventData data;
  late final List<dynamic> errors;

  EventsModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = EventData.fromJson(json['data']);
    errors = List.castFrom<dynamic, dynamic>(json['errors']);
  }
}

class EventData {
  EventData({
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

  EventData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'] ?? 0;
    totalPages = json['totalPages'] ?? 0;
    pageSize = json['pageSize'] ?? 0;
    totalCount = json['totalCount'] ?? 0;
    events = List.from(json['data']).map((e) => Event.fromJson(e)).toList();
  }
}

class Event {
  Event({
    this.eventId,
    this.eventName,
    this.eventDescription,
    this.eventAddress,
    this.startDate,
    this.endDate,
    this.link,
    this.notifyBefore,
    // this.jobCategoryIdList,
    // this.residencyTypeList,
    // this.residenceCountryIdList,
    this.isActive = true,
  });
  int? eventId;
  String? eventName;
  String? eventDescription;
  String? eventAddress;
  String? startDate;
  String? endDate;
  String? link;
  int? notifyBefore;
  // dynamic jobCategoryIdList;
  // dynamic residencyTypeList;
  // dynamic residenceCountryIdList;
  bool? isActive;

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventName = json['eventName'];
    eventDescription = json['eventDescription'];
    eventAddress = json['eventAddress'];
    startDate = (json['eventStartDate'] != null)
        ? formatDate(json['eventStartDate'])
        : (json['startDate'] != null)
            ? formatDate(json['startDate'])
            : '';

    endDate = (json['eventEndtDate'] != null)
        ? formatDate(json['eventEndtDate'])
        : (json['endDate'] != null)
            ? formatDate(json['endDate'])
            : '';

    link = json['link'];
    notifyBefore = json['notifyBefore'];
    // jobCategoryIdList = json['jobCategoryIdList'];
    // residencyTypeList = json['residencyTypeList'];
    // residenceCountryIdList = json['residenceCountryIdList'];
    isActive = json['isActive'] ?? false;
  }

  static List<Event> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => Event.fromJson(item)).toList();
  }

  static String formatDate(String dateTimestamp) {
    DateTime date = DateTime.parse(dateTimestamp);

    String time = date.hour == 0 && date.minute == 0
        ? '12:00 ${date.hour > 12 ? 'م' : 'ص'}'
        : '${date.hour}:${date.minute} ${date.hour > 12 ? 'م' : 'ص'}';
    return '${date.day} ${date.month} ${date.year} $time';
  }
}
