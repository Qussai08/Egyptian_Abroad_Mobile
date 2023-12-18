import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/dropdown_list_selector.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/grid_widget.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/no_data_widget.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/home/views/widgets/home_appbar.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeContoller) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const HomeAppBar(),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: homeContoller.userProfileLoading
                ? SizedBox(
                    height: fixDpiScreenHeight() * 0.8,
                    width: fixDpiScreenWidth(),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Styles.primaryColor,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // TODO: import user image from AppImages
                                Image.asset(
                                  'assets/icons/male.png',
                                  width: 36.w,
                                  fit: BoxFit.fitWidth,
                                ),

                                DropDownListSelector(
                                  decoration: const BoxDecoration(),
                                  blackHint: true,
                                  reverseArrowPosition: true,
                                  dropDownList: <DropdownMenuItem>[
                                    DropdownMenuItem(
                                      value: Routes.ViewACCOUNT,
                                      child:
                                          Text(AppStrings.viewAccountInfos.tr),
                                    ),
                                    DropdownMenuItem(
                                      value: Routes.EditACCOUNT,
                                      child:
                                          Text(AppStrings.editAccountInfos.tr),
                                    ),
                                    DropdownMenuItem(
                                      value: Routes.CHANGEPASSWORD,
                                      child: Text(AppStrings.changePassword.tr),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {
                                        controller.onLogout();
                                      },
                                      value: Routes.LOGIN,
                                      child: Text(AppStrings.logOut.tr),
                                    ),
                                  ],
                                  // value: residence,
                                  // TODO: Need to fix the name, and userProfile may be null here use null safety operator (?.) to avoid null exception error
                                  hint:
                                      "${AppStrings.hello.tr} ${controller.authService.getUserProfile?.shortName ?? ''} !",

                                  onChangeFunc: (val) async {
                                    // if (val == Routes.LOGIN) {
                                    //   await SecureStorageHelper.localRemove(
                                    //       'user');
                                    // }
                                    Get.toNamed(val);
                                    // _residenceCountry.value = val;
                                  },
                                ),
                                // DropDownListSelector(
                                //   decoration: const BoxDecoration(),
                                //   blackHint: true,
                                //   reverseArrowPosition: true,
                                //   dropDownList: <DropdownMenuItem>[
                                //     DropdownMenuItem(
                                //       value: Routes.EditACCOUNT,
                                //       child:
                                //           Text(AppStrings.viewAccountInfos.tr),
                                //     ),
                                //     DropdownMenuItem(
                                //       value: Routes.EditACCOUNT,
                                //       child:
                                //           Text(AppStrings.editAccountInfos.tr),
                                //     ),
                                //     DropdownMenuItem(
                                //       value: Routes.CHANGEPASSWORD,
                                //       child: Text(AppStrings.changePassword.tr),
                                //     ),
                                //     DropdownMenuItem(
                                //       onTap: () {
                                //         controller.onLogout();
                                //       },
                                //       value: Routes.LOGIN,
                                //       child: Text(AppStrings.logOut.tr),
                                //     ),
                                //   ],
                                //   // value: residence,
                                //   hint: "!${AppStrings.hello.tr} احمد ",
                                //   onChangeFunc: (val) {
                                //     Get.toNamed(val);
                                //     // _residenceCountry.value = val;
                                //   },
                                // ),

                                // Container(
                                //   margin: const EdgeInsets.symmetric(horizontal: 5),
                                //   child: Image.asset(
                                //     'assets/icons/arrow-down.png',
                                //     width: 16.w,
                                //     fit: BoxFit.fitWidth,
                                //   ),
                                // ),
                                // TitleText(
                                //   title: "${AppStrings.hello.tr} احمد" + "!",
                                //   fontSize: fixDpiFont(18),
                                //   color: const Color(0xff263238),
                                // )
                              ],
                            ),
                            // Container(
                            //   width: 133.w,
                            //   height: 37.h,
                            //   padding: const EdgeInsets.symmetric(horizontal: 10),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(28),
                            //       border: Border.all(color: const Color(0xffEBEBEB))),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Image.asset(
                            //         'assets/icons/location-icon.png',
                            //         height: 24.w,
                            //         width: 24.w,
                            //         fit: BoxFit.fitWidth,
                            //       ),
                            //       const SizedBox(
                            //         width: 5,
                            //       ),
                            //       Text(
                            //         'ميونيخ 🇩🇪',
                            //         style: TextStyle(
                            //             fontSize: fixDpiFont(14),
                            //             fontWeight: FontWeight.w400,
                            //             color: const Color(0xff263238),
                            //             fontFamily: 'baloo'),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      CustomTextFormField(
                        controller: controller.searchController,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Styles.primaryColor,
                        ),
                        inputData: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        onChangedFunc: (val) {
                          if (val.isEmpty) {
                            controller.keySearch = val;
                            controller.setKeySearch(controller.keySearch,
                                notifiy: true);
                            FocusScope.of(context).unfocus();
                          }
                        },
                        onFieldSubmitted: (val) {
                          controller.keySearch = val;
                          controller.setKeySearch(controller.keySearch,
                              notifiy: true);
                        },
                        hintTxt: AppStrings.searchForService.tr,
                        // TODO: need to handle TextStyle from Styles
                        hintStyle: TextStyle(
                            fontSize: fixDpiFont(14),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'baloo'),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 19.h),
                        height: 524.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(28, 76, 159, 0.15),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                              title: AppStrings.exploreServices.tr,
                              fontSize: fixDpiFont(18),
                            ),
                            TitleText(
                              title: AppStrings.allServices.tr,
                              fontSize: fixDpiFont(14),
                              // TODO: need to handle TextStyle from Styles
                              titleTextStyle: TextStyle(
                                  fontSize: fixDpiFont(14),
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(62, 60, 60, 0.71),
                                  fontFamily: 'baloo'),
                            ),
                            homeContoller.categoriesLoading ||
                                    homeContoller
                                        .displayedCategoriesList.isEmpty
                                ? const Spacer()
                                : Container(),
                            homeContoller.categoriesLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Styles.primaryColor,
                                    ),
                                  )
                                : homeContoller.displayedCategoriesList.isEmpty
                                    ? NoDataWidget(
                                        message: AppStrings.noServices.tr,
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: !controller.showMore
                                                ? 425.h
                                                : 385.h,
                                            child: GridView.builder(
                                              shrinkWrap: true,
                                              padding:
                                                  EdgeInsets.only(top: 15.h),
                                              gridDelegate:
                                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 125,
                                                childAspectRatio: 0.96,
                                              ),
                                              scrollDirection: Axis.vertical,
                                              itemCount: controller
                                                  .displayedCategoriesList
                                                  .length,
                                              itemBuilder: (ctx, i) =>
                                                  GridWidget(
                                                i,
                                                category: controller
                                                    .displayedCategoriesList[i],
                                              ),
                                            ),
                                          ),
                                          controller.showMore
                                              ? Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  padding: EdgeInsets.only(
                                                      bottom: 5.h, top: 5.h),
                                                  child: CustomButton(
                                                    type: ButtonType.secondary,
                                                    text:
                                                        AppStrings.showMore.tr,
                                                    width: 110.w,
                                                    height: 36.h,
                                                    fontSize: 10,
                                                    icon: Icons.arrow_forward,
                                                    iconSize: 13,
                                                    onPressed: () {
                                                      controller
                                                          .getMoreCategories();
                                                    },
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                            // TODO: kindly check this view on EN language, may spacing make issue with allignment
                            const Spacer(),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
