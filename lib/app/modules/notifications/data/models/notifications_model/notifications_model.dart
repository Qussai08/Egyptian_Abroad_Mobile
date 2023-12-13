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
      sentDate: json['sentDate'] as String?,
    );
  }

  static List<NotificationsModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => NotificationsModel.fromJson(item)).toList();
  }
}
