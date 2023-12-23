import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_showcase_controller.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_view_body_widget.dart';

class HomeShowcaseView extends GetView<HomeShowcaseController> {
  const HomeShowcaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeShowcaseController>(
      builder: (homeContoller) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const HomeAppBar(),
        body: HomeViewBodyWidget(),
      ),
    );
  }
}
