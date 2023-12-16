import 'package:egyptians_abroad/app/modules/more/views/more_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreController extends GetxController {
  Rx content = Container(child: const MoreListView()).obs;

  changeView(var content) {
    this.content.value = Container(child: content);
  }
}
