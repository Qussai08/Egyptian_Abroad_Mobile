class NotificationsModel {
  int? notificationId;
  String? userId;
  String? title;
  String? message;
  String? sentDate;

  NotificationsModel({
    this.notificationId,
    this.userId,
    this.title,
    this.message,
    this.sentDate,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      notificationId: json['notificationId'] as int?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      sentDate:
          (json['sentDate'] != null) ? formatDate(json['sentDate']) : null,
    );
  }

  static List<NotificationsModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => NotificationsModel.fromJson(item)).toList();
  }

  static String formatDate(String dateTimestamp) {
    DateTime date = DateTime.parse(dateTimestamp);

    String time = date.hour == 0 && date.minute == 0
        ? '12:00 ${date.hour > 12 ? 'مساءا' : 'صباحا'}'
        : '${date.hour}:${date.minute} ${date.hour > 12 ? 'مساءا' : 'صباحا'}';
    return '${date.day} ${date.month} ${date.year} $time';
  }
}
