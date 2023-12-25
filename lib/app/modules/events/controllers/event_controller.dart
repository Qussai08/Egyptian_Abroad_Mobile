import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsController extends GetxController {
  String keySearch = '';
  final TextEditingController searchController = TextEditingController();
}
    // with StateMixin<List<NotificationsModel>> {
  // final NotificationsProvider notificationsProvider =
  //     Get.find<NotificationsProvider>();

  // RxList<NotificationsModel> notificationsList = <NotificationsModel>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   loadNotifications(); // Call the method to load notifications when the controller is initialized
  // }

  // // Method to simulate loading notifications
  // Future<void> loadNotifications() async {
  //   notificationsList.clear();
  //   change([], status: RxStatus.loading());
  //   await notificationsProvider.getNotificationHistory().then((value) {
  //     if (value.isSuccess) {
  //       if (value.body != null) {
  //         if (value.body!.isEmpty) {
  //           change(null, status: RxStatus.empty());
  //           return;
  //         }
  //         notificationsList.addAll(value.body ?? []);
  //         notificationsList.value = notificationsList.value.reversed.toList();
  //         change(value.body, status: RxStatus.success());
  //       } else {
  //         change(null, status: RxStatus.empty());
  //       }
  //     } else {
  //       change(null, status: RxStatus.error('حدث خطأ ما'));
  //       // change(null, status: RxStatus.error('${value.error}'));
  //     }
  //   }, onError: (error) {
  //     change(null, status: RxStatus.error('حدث خطأ ما'));
  //     // change(null, status: RxStatus.error('$error'));
  //   });
  // }

  // Future<void> retry() async {
  //   change([], status: RxStatus.loading());
  //   await loadNotifications();
  // }
// }
