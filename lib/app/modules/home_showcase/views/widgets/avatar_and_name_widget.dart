import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/dropdown_list_selector.dart';

import '../../../../core/helper/dpi_helper.dart';
import '../../../../core/language/app_string.dart';
import '../../../../core/theme/app_images.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/home_showcase_controller.dart';

class AvatarAndNameWidget extends StatelessWidget {
  const AvatarAndNameWidget({
    super.key,
    required this.homeContoller,
  });

  final HomeShowcaseController homeContoller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: fixDpiHeight(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Avatar Image
              Image.asset(
                AppImages.maleIcon,
                width: 36.w,
                fit: BoxFit.fitWidth,
              ),

              // Dropdown List
              DropDownListSelector(
                decoration: const BoxDecoration(),
                blackHint: true,
                reverseArrowPosition: true,
                dropDownList: <DropdownMenuItem>[
                  DropdownMenuItem(
                    value: Routes.ViewACCOUNT,
                    child: Text(AppStrings.viewAccountInfos.tr),
                  ),
                  DropdownMenuItem(
                    value: Routes.EditACCOUNT,
                    child: Text(AppStrings.editAccountInfos.tr),
                  ),
                  DropdownMenuItem(
                    value: Routes.CHANGEPASSWORD,
                    child: Text(AppStrings.changePassword.tr),
                  ),
                  DropdownMenuItem(
                    onTap: () {
                      homeContoller.onLogout();
                    },
                    value: Routes.LOGIN,
                    child: Text(AppStrings.logOut.tr),
                  ),
                ],
                hint:
                    "${AppStrings.hello.tr} ${homeContoller.authService.getUserProfile?.shortName ?? ''} !",
                onChangeFunc: (val) async {
                  Get.toNamed(val);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
