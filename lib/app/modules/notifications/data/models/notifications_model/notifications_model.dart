import 'package:intl/intl.dart';

class NotificationsModel {
  int? notificationId;
  String? userId;
  String? title;
  String? message;
  String? sentDate;
  int? notificationTypeId;
  String? eventID;
  String? eventDescription;

  NotificationsModel(
      {this.notificationId,
      this.userId,
      this.title,
      this.message,
      this.sentDate,
      this.notificationTypeId,
      this.eventID,
      this.eventDescription});

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
        notificationId: json['notificationId'] as int?,
        userId: json['userId'] as String?,
        title: json['title'] as String?,
        message: json['message'] as String?,
        sentDate:
            (json['sentDate'] != null) ? formatDate(json['sentDate']) : null,
        notificationTypeId: json['notificationTypeId'],
        eventID: json['routeId'],
        eventDescription: json['eventDescription']);
  }

  static List<NotificationsModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => NotificationsModel.fromJson(item)).toList();
  }

  static String formatDate(String dateTimestamp) {
    DateTime myDateTime = DateTime.parse(dateTimestamp);

    String month = DateFormat('MMMM', 'ar_EG').format(myDateTime).toString();

    String formattedDate =
        DateFormat('dd MMMM yyyy hh:mm a', 'ar_EG').format(myDateTime);

    String formatWithEngNums =
        "${myDateTime.day} $month ${myDateTime.year} ${myDateTime.hour.toString().padLeft(2, '0')}:${myDateTime.minute.toString().padLeft(2, '0')} ${formattedDate.split(' ').last.contains('ص') ? 'صباحًا' : 'مساءً'}";

    return formatWithEngNums;
  }
}
