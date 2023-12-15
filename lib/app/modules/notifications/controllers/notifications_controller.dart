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

  // Method to simulate loading notifications
  Future<void> loadNotifications() async {
    notificationsList.clear();
    change([], status: RxStatus.loading());
    await notificationsProvider.getNotificationHistory().then((value) {
      if (value.isSuccess) {
        if (value.body != null) {
          if (value.body!.isEmpty) {
            change(null, status: RxStatus.empty());
            return;
          }
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
  }

  Future<void> retry() async {
    change([], status: RxStatus.loading());
    await loadNotifications();
  }
}
