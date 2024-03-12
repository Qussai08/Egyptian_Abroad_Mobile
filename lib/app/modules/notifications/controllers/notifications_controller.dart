import 'package:get/get.dart';

import '../data/models/notifications_model/notifications_model.dart';
import '../data/providers/notifications_provider.dart';

class NotificationsController extends GetxController
    with StateMixin<List<NotificationsModel>> {
  final NotificationsProvider notificationsProvider =
      Get.find<NotificationsProvider>();

  RxList<NotificationsModel> notificationsList = <NotificationsModel>[].obs;
  RxBool isLoading = false.obs;

  int openNotificationId = (Get.arguments != null) ? Get.arguments[0] : -1;

  @override
  void onInit() {
    super.onInit();
    // loadNotifications();
    // Call the method to load notifications when the controller is initialized
  }

  // Method to simulate loading notifications
  Future<void> loadNotifications() async {
    isLoading.value = true;
    notificationsList.clear();
    // change([], status: RxStatus.loading());
    await notificationsProvider.getNotificationHistory().then((value) {
      if (value.isSuccess) {
        if (value.body != null) {
          if (value.body!.isEmpty) {
            change(null, status: RxStatus.empty());
            isLoading.value = false;
            return;
          }
          notificationsList.addAll(value.body ?? []);
          notificationsList.value.sort((a, b) {
            var adate = DateTime.parse(a.originalsentDate!);
            var bdate = DateTime.parse(b.originalsentDate!);
            return bdate.compareTo(adate);
          });
          change(value.body, status: RxStatus.success());
          isLoading.value = false;
        } else {
          isLoading.value = false;
          change(null, status: RxStatus.empty());
        }
      } else {
        isLoading.value = false;
        change(null, status: RxStatus.error('حدث خطأ ما'));
        // change(null, status: RxStatus.error('${value.error}'));
      }
    }, onError: (error) {
      isLoading.value = false;
      change(null, status: RxStatus.error('حدث خطأ ما'));
      // change(null, status: RxStatus.error('$error'));
    });
  }

  Future<void> retry() async {
    // change([], status: RxStatus.loading());
    isLoading.value = true;
    openNotificationId = (Get.arguments != null) ? Get.arguments[0] : -1;
    print(openNotificationId);
    await loadNotifications();
    isLoading.value = false;
  }
}
