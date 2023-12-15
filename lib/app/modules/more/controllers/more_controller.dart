import 'package:egyptians_abroad/app/modules/more/views/more_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreController extends GetxController {
  //TODO: Implement MoreController

  Rx content = Container(
    child: MoreListView(),
  ).obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  changeView(var content) {
    this.content.value = Container(child: content);
  }
}
