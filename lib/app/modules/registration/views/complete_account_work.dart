import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/progress_indicator_widget.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

class CompleteAccountWorkView extends StatefulWidget {
  const CompleteAccountWorkView({Key? key}) : super(key: key);

  @override
  State<CompleteAccountWorkView> createState() =>
      _CompleteAccountWorkViewState();
}

class _CompleteAccountWorkViewState extends State<CompleteAccountWorkView>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: CustomAppBar(
            toolbarHeight: 100,
            title: Column(
              children: [
                Image.asset(
                  AppImages.user,
                  width: 56.w,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 24.h),
                Text(
                  AppStrings.completeAccountTitle.tr,
                  style: Styles.getBoldStyle(
                      color: Styles.black, fontSize: fixDpiFont(24)),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: SingleChildScrollView(
              child: GetBuilder<RegistrationController>(
                builder: (registrationController) => Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          const ProgressIndicatorWidget(
                            step: '2',
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          // todo: translate
                          Text('بيانات المهنة',
                              style: TextStyle(
                                  fontFamily: 'baloo',
                                  fontSize: fixDpiFont(17),
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff3F3D56)))
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      TextFieldTitle(
                          title: AppStrings.jobCategory.tr, hasSubTitle: false),
                      ValueListenableBuilder<int?>(
                          valueListenable: registrationController.jobCategory,
                          builder: (_, category, __) {
                            return DropDownListSelector(
                              dropDownList: (registrationController
                                          .jobCategoryList.length ==
                                      0)
                                  ? <DropdownMenuItem>[]
                                  : registrationController.jobCategoryList
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e.name),
                                            value: e.id,
                                          ))
                                      .toList(),
                              value: category,
                              hint: "",
                              onChangeFunc: (val) {
                                registrationController.jobCategory.value = val;
                              },
                            );
                          }),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFieldTitle(
                          title: AppStrings.jobTitle.tr, hasSubTitle: false),
                      CustomTextFormField(
                        controller:
                            registrationController.jobTitleTxtController,
                        validationFunc: (val) => maxLenghtValidation(
                            registrationController.jobTitleTxtController.text,
                            100),
                        inputData: TextInputType.text,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFieldTitle(
                        title: AppStrings.egPhoneNum.tr,
                        hasSubTitle: false,
                      ),
                      CustomTextFormField(
                        controller:
                            registrationController.egptionPhoneNumTxtController,
                        validationFunc: (val) => validateEgyptionPhoneNum(
                            registrationController
                                .egptionPhoneNumTxtController.text),
                        inputData: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          TextFieldTitle(
                              title: AppStrings.forignPhoneNum.tr,
                              hasSubTitle: false,
                              hasHorizontalMargin: false),
                          TextFieldTitle(
                            title: AppStrings.forignPhoneNumHint.tr,
                            fontSize: 10,
                            hasSubTitle: false,
                            hasHorizontalMargin: false,
                          ),
                        ],
                      ),
                      CustomTextFormField(
                        controller:
                            registrationController.forignPhoneNumTxtController,
                        validationFunc: (val) => maxLenghtValidation(
                            registrationController
                                .forignPhoneNumTxtController.text,
                            15),
                        inputData: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFieldTitle(
                          title: AppStrings.msgsAddress.tr, hasSubTitle: false),
                      CustomTextFormField(
                        controller:
                            registrationController.msgsAddressTxtController,
                        validationFunc: (val) => maxLenghtValidation(
                            registrationController
                                .msgsAddressTxtController.text,
                            200),
                        inputData: TextInputType.text,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      CustomButton(
                        text: AppStrings.next.tr,
                        icon: Icons.arrow_forward,
                        type: ButtonType.primary,
                        width: 300.w,
                        height: 50,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await registrationController.completeAccount(
                                isEdit: false);
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomButton(
                        text: AppStrings.skip.tr,
                        type: ButtonType.secondary,
                        width: 300.w,
                        height: 50,
                        onPressed: () {
                          Get.toNamed(Routes.REGITSRATIONSELECTAVATAR);
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
