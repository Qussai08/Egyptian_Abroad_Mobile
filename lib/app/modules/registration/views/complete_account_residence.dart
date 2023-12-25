import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/views/widgets/progress_indicator_widget.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

class CompleteAccountView extends StatefulWidget {
  const CompleteAccountView({Key? key}) : super(key: key);

  @override
  State<CompleteAccountView> createState() => _CompleteAccountViewState();
}

class _CompleteAccountViewState extends State<CompleteAccountView>
    with ValidationMixin {
  bool intialRun = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (intialRun) {
      var controller = Get.put(RegistrationController());
      controller.loadResidenceData();
      intialRun = false;
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: SingleChildScrollView(
              child: GetBuilder<RegistrationController>(
                builder: (registrationController) => Form(
                  key: _formKey,
                  child: registrationController.residenceLoading
                      ? Container(
                          height: fixDpiScreenHeight(),
                          width: fixDpiScreenWidth(),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Styles.primaryColor,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 18.h,
                            ),
                            Image.asset(
                              'assets/images/user.png',
                              width: 56.w,
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TitleText(
                                title: AppStrings.completeAccountTitle.tr),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                ProgressIndicatorWidget(step: '1'),
                                SizedBox(width: 8.w),
                                // todo: translate
                                Text('بيانات الإقامة',
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
                                title: AppStrings.egPassportNum.tr,
                                hasSubTitle: false),
                            CustomTextFormField(
                              controller: registrationController
                                  .egPassportNumTxtController,
                              validationFunc: (val) => validateEgyptionPassport(
                                  registrationController
                                      .egPassportNumTxtController.text),
                              inputData: TextInputType.text,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFieldTitle(
                                title: AppStrings.residenceType.tr,
                                hasSubTitle: false),
                            ValueListenableBuilder<int?>(
                                valueListenable:
                                    registrationController.residenceType,
                                builder: (_, residenceTP, __) {
                                  return Column(
                                    children: [
                                      DropDownListSelector(
                                        dropDownList: registrationController
                                            .residenceTypeList
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(e.name),
                                                  value: e.id,
                                                ))
                                            .toList(),
                                        value: residenceTP,
                                        hint: "",
                                        onChangeFunc: (val) {
                                          registrationController
                                              .residenceType.value = val;
                                        },
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      if (residenceTP == 1)
                                        TextFieldTitle(
                                            title:
                                                AppStrings.residenceNumber.tr,
                                            hasSubTitle: false),
                                      if (residenceTP == 1)
                                        CustomTextFormField(
                                          controller: registrationController
                                              .residenceNumTxtController,
                                          inputData: TextInputType.text,
                                          validationFunc: (val) =>
                                              maxLenghtValidation(
                                                  registrationController
                                                      .residenceNumTxtController
                                                      .text,
                                                  20),
                                        ),
                                      if (residenceTP == 1)
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                      if (residenceTP == 2)
                                        TextFieldTitle(
                                            title:
                                                AppStrings.forignPassportNum.tr,
                                            hasSubTitle: false),
                                      if (residenceTP == 2)
                                        CustomTextFormField(
                                          controller: registrationController
                                              .forignPassportNumTxtController,
                                          inputData: TextInputType.text,
                                          validationFunc: (val) =>
                                              maxLenghtValidation(
                                                  registrationController
                                                      .residenceNumTxtController
                                                      .text,
                                                  20),
                                        ),
                                      if (residenceTP == 2)
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                    ],
                                  );
                                }),
                            // TextFieldTitle(
                            //     title: AppStrings.residenceAddress.tr,
                            //     hasSubTitle: false),
                            // CustomTextFormField(
                            //   controller: registrationController
                            //       .residenceAddressTxtController,
                            //   inputData: TextInputType.text,
                            //   validationFunc: (val) => maxLenghtValidation(
                            //       registrationController
                            //           .residenceNumTxtController.text,
                            //       200),
                            // ),
                            SizedBox(
                              height: 150.h,
                            ),
                            CustomButton(
                              text: AppStrings.next.tr,
                              icon: Icons.arrow_forward,
                              type: ButtonType.primary,
                              width: 300.w,
                              height: 50.h,
                              onPressed: () {
                                // registrationController.loadResidenceData();
                                if (_formKey.currentState!.validate()) {
                                  Get.toNamed(Routes.COMPLETEACCOUNTWORK);
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
                              height: 50.h,
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
