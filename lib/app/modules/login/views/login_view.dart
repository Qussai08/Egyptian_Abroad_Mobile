import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          AppStrings.success.tr,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
