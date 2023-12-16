import 'package:egyptians_abroad/app/core/custom_widgets/custom_dialog.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    // if (oldPassword == newPassword) {
    //   Get.showSnackbar(
    //     buildCustomToast(
    //       Get.context!,
    //       toastMsg: AppStrings.oldEqualNew.tr,
    //       toastTitle: AppStrings.sorry.tr,
    //       toastType: ToastType.error,
    //     ),
    //   );
    // }
    changePasswordProvider.postChangePassword(oldPassword, newPassword).then(
        (value) {
      if (value.isSuccess) {
        Get.dialog(CustomDialog(
            icon: Image.asset(AppImages.checkIcon, width: 24.w),
            text: AppStrings.successPasswordChange.tr));
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

  // Future<void> changePassword(
  //     {required String oldPassword, required String newPassword}) async {
  //   AppResponse response = await UserRepository().changePasswordReq(
  //       {"oldPassword": oldPassword, "newPassword": newPassword});
  //   if (response.status) {

  //     Get.dialog(CustomDialog(
  //         icon: const Icon(
  //           Icons.check_circle,
  //           color: Styles.green,
  //         ),
  //         text: AppStrings.successPasswordChange.tr));

  //     Future.delayed(const Duration(seconds: 3), () {
  //       AuthService().logout();
  //       Get.offAllNamed('/login');
  //     });

  //     // Get.showSnackbar(buildCustomToast(Get.context!,
  //     //     toastMsg: AppStrings.success,
  //     //     toastTitle: AppStrings.success,
  //     //     toastType: ToastType.success));
  //   } else {
  //     Get.showSnackbar(
  //       buildCustomToast(
  //         Get.context!,
  //         toastMsg: AppStrings.invalidOldPassword.tr,
  //         toastTitle: AppStrings.sorry.tr,
  //         toastType: ToastType.error,
  //       ),
  //     );
  //   }
  // }
}
