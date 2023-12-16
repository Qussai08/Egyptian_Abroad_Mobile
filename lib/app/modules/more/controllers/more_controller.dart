import 'package:egyptians_abroad/app/modules/more/views/more_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreController extends GetxController {
  //TODO: Implement MoreController

  Rx content = Container(
    child: const MoreListView(),
  ).obs;

  final count = 0.obs;

  void increment() => count.value++;

  changeView(var content) {
    this.content.value = Container(child: content);
  }
}
