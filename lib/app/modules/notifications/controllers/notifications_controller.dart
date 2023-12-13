import 'package:get/get.dart';

import '../data/models/notifications_model/notifications_model.dart';
import '../data/providers/notifications_provider.dart';

class NotificationsController extends GetxController
    with StateMixin<List<NotificationsModel>> {
  final NotificationsProvider notificationsProvider =
      Get.find<NotificationsProvider>();

  RxList<NotificationsModel> notificationsList = <NotificationsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications(); // Call the method to load notifications when the controller is initialized
  }

  @override
  void onReady() {
    super.onReady();
    print('NotificationsController is ready');
  }

  // Method to simulate loading notifications
  Future<void> loadNotifications() async {
    notificationsList.clear();
    change([], status: RxStatus.loading());
    await notificationsProvider.getNotificationHistory().then((value) {
      if (value.isSuccess) {
        if (value.body != null) {
          notificationsList.addAll(value.body ?? []);
          change(value.body, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error('${value.error}'));
      }
    }, onError: (error) {
      change(null, status: RxStatus.error('$error'));
    });

    // notificationsList.addAll([
    //   NotificationModel(
    //     title: 'عنوان الإشعار الأول' * 10,
    //     message: 'هذا هو وصف إشعار لإعلان النظام' * 10,
    //     time: '7:00 صباحاً',
    //   ),
    //   NotificationModel(
    //     title: 'عنوان الإشعار الثاني',
    //     message: 'محتوى الإشعار يمكن أن يكون هنا',
    //     time: '8:15 صباحاً',
    //   ),
    //   NotificationModel(
    //     title: 'عنوان الإشعار الثالث',
    //     message: 'محتوى الإشعار يمكن أن يكون هنا',
    //     time: '9:00 صباحاً',
    //   ),
    //   NotificationModel(
    //     title: 'عنوان الإشعار الرابع',
    //     message: 'محتوى الإشعار يمكن أن يكون هنا',
    //     time: '10:00 صباحاً',
    //   ),
    //   NotificationModel(
    //     title: 'عنوان الإشعار الخامس',
    //     message: 'محتوى الإشعار يمكن أن يكون هنا',
    //     time: '11:00 صباحاً',
    //   ),
    //   NotificationModel(
    //     title: 'عنوان الإشعار السادس',
    //     message: 'محتوى الإشعار يمكن أن يكون هنا',
    //     time: '12:00 مساءً',
    //   ),

    //   // Add as many notifications as you want
    // ]);
  }

  Future<void> retry() async {
    change([], status: RxStatus.loading());
    await loadNotifications();
  }
}
