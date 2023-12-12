class NotificationModel {
  final String title;
  final String message;
  final String time; // You might want to use DateTime instead

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      time: json['time'] ?? '',
    );
  }

  // handel notification list
  static List<NotificationModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => NotificationModel.fromJson(item)).toList();
  }
}
