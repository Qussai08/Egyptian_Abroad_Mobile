import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../data/providers/change_password_provider.dart';
import '../../../core/helper/error_helper.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController oldPasswordTxtController =
      TextEditingController();
  final TextEditingController newPasswordTxtController =
      TextEditingController();
  final TextEditingController confirmNewPasswordTxtController =
      TextEditingController();

  final ChangePasswordProvider changePasswordProvider =
      Get.find<ChangePasswordProvider>();

  RxBool isLoading = false.obs;

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
    isLoading.value = true;
    changePasswordProvider.postChangePassword(oldPassword, newPassword).then(
        (value) {
      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: AppStrings.successPasswordChange.tr,
          toastTitle: AppStrings.confirm.tr,
          toastType: ToastType.success,
        ),
      );
      AuthService().logout();
      isLoading.value = false;
      Get.offAllNamed(Routes.LOGIN);
    }, onError: (error) {
      isLoading.value = false;
      handleError(error);
    });
  }

  void handleError(String error) {
    Get.showSnackbar(
      buildCustomToast(
        Get.context!,
        toastMsg: ErrorHelper.getErrorMessage(error),
        toastTitle: AppStrings.sorry.tr,
        toastType: ToastType.error,
      ),
    );
  }
}
