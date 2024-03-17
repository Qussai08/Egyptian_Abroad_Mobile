import 'package:intl/intl.dart';

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

  bool? isActive;

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventName = json['eventName'];
    eventDescription = json['eventDescription'];
    eventAddress = json['eventAddress'];
    startDate = (json['eventStartDate'] != null)
        ? dateFormatter(json['eventStartDate'])
        : (json['startDate'] != null)
            ? dateFormatter(json['startDate'])
            : '';

    endDate = (json['eventEndtDate'] != null)
        ? dateFormatter(json['eventEndtDate'])
        : (json['endDate'] != null)
            ? dateFormatter(json['endDate'])
            : '';

    link = json['link'];
    notifyBefore = json['notifyBefore'];
    isActive = json['isActive'] ?? false;
  }

  static List<Event> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => Event.fromJson(item)).toList();
  }

  static String dateFormatter(String date, {bool dateOnly = false}) {
    DateTime myDateTime = DateTime.parse(date);
    String month = DateFormat('MMMM', 'ar_EG').format(myDateTime).toString();

    if (dateOnly) {
      String formattedDate =
          DateFormat('dd MMMM yyyy', 'ar_EG').format(myDateTime);

      // String formatWithEngNums = "${myDateTime.day} $month ${myDateTime.year}";
      return formattedDate;
    } else {
      String formattedDate =
          DateFormat('dd MMMM yyyy hh:mm a', 'ar_EG').format(myDateTime);

      String formatWithEngNums =
          "${myDateTime.day} $month ${myDateTime.year} ${myDateTime.hour.toString().padLeft(2, '0')}:${myDateTime.minute.toString().padLeft(2, '0')} ${formattedDate.split(' ').last.contains('ص') ? 'صباحًا' : 'مساءً'}";
      return formatWithEngNums;
    }
  }
}
