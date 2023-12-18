import 'package:egyptians_abroad/app/core/custom_widgets/custom_dialog.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../data/providers/change_password_provider.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController oldPasswordTxtController =
      TextEditingController();
  final TextEditingController newPasswordTxtController =
      TextEditingController();
  final TextEditingController confirmNewPasswordTxtController =
      TextEditingController();

  final ChangePasswordProvider changePasswordProvider =
      Get.find<ChangePasswordProvider>();

  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    if (oldPassword == newPassword) {
      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: AppStrings.oldEqualNew.tr,
          toastTitle: AppStrings.sorry.tr,
          toastType: ToastType.error,
        ),
      );
      return;
    }
    changePasswordProvider.postChangePassword(oldPassword, newPassword).then(
        (value) {
      if (value.isSuccess) {
        buildCustomDialog(
          dialogMsg: AppStrings.successPasswordChange.tr,
          dialogType: DialogType.success,
        );
        // OLD Code
        // Get.dialog(
        // CustomDialog(
        //   icon: const Icon(
        //     Icons.check_circle,
        //     color: Styles.green,
        //   ),
        //   text: AppStrings.successPasswordChange.tr)
        // );
        Future.delayed(const Duration(seconds: 3), () {
          AuthService().logout();
          Get.offAllNamed(Routes.LOGIN);
        });
      } else {
        handleError();
      }
    }, onError: (error) {
      handleError();
    });
  }

  void handleError() {
    Get.showSnackbar(
      buildCustomToast(
        Get.context!,
        toastMsg: AppStrings.invalidOldPassword.tr,
        toastTitle: AppStrings.sorry.tr,
        toastType: ToastType.error,
      ),
    );
  }
}
