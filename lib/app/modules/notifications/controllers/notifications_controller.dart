import 'package:get/get.dart';

import '../data/notification_model.dart';

class NotificationsController extends GetxController {
  RxList<NotificationModel> notificationsList = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications(); // Call the method to load notifications when the controller is initialized
  }

  // Method to simulate loading notifications
  void loadNotifications() {
    notificationsList.addAll([
      NotificationModel(
        title: 'عنوان الإشعار الأول' * 10,
        message: 'هذا هو وصف إشعار لإعلان النظام' * 10,
        time: '7:00 صباحاً',
      ),
      NotificationModel(
        title: 'عنوان الإشعار الثاني',
        message: 'محتوى الإشعار يمكن أن يكون هنا',
        time: '8:15 صباحاً',
      ),
      NotificationModel(
        title: 'عنوان الإشعار الثالث',
        message: 'محتوى الإشعار يمكن أن يكون هنا',
        time: '9:00 صباحاً',
      ),
      NotificationModel(
        title: 'عنوان الإشعار الرابع',
        message: 'محتوى الإشعار يمكن أن يكون هنا',
        time: '10:00 صباحاً',
      ),
      NotificationModel(
        title: 'عنوان الإشعار الخامس',
        message: 'محتوى الإشعار يمكن أن يكون هنا',
        time: '11:00 صباحاً',
      ),
      NotificationModel(
        title: 'عنوان الإشعار السادس',
        message: 'محتوى الإشعار يمكن أن يكون هنا',
        time: '12:00 مساءً',
      ),

      // Add as many notifications as you want
    ]);
  }
}
