import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/grid_widget.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/no_data_widget.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryView extends StatefulWidget {
  final Category? category;
  const CategoryView({super.key, this.category});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  String _keySearch = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController(widget.category!.id));
    AuthService authService = Get.find();

    return NetworkIndicator(
      child: GetBuilder<CategoryController>(
        builder: (categoryController) => Scaffold(
          //   resizeToAvoidBottomInset: false,
          body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  widget.category!.categoryColor!.toColor(),
                  Colors.white
                ],
              )),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: CustomAppBar(
                  title: widget.category!.categoryName,
                ),
                body: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    height: fixDpiScreenHeight() * 0.95,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15.h),
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.maleIcon,
                                width: 36.w,
                                fit: BoxFit.fitWidth,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              TitleText(
                                title:
                                    "${AppStrings.hello.tr} ${authService.getUserProfile?.shortName ?? ''} !",
                                fontSize: fixDpiFont(18),
                                color: const Color(0xff263238),
                              )
                            ],
                          ),
                        ),
                        CustomTextFormField(
                          controller: _searchController,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Styles.primaryColor,
                          ),
                          inputData: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          hintTxt: "بتدور على ايه؟",
                          hintStyle: TextStyle(
                              fontSize: fixDpiFont(14),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'baloo'),
                          onChangedFunc: (val) {
                            if (val.isEmpty) {
                              _keySearch = val;
                              controller.setKeySearch(_keySearch,
                                  notifiy: true);
                              FocusScope.of(context).unfocus();
                            }
                          },
                          onFieldSubmitted: (val) {
                            _keySearch = val;
                            controller.setKeySearch(_keySearch, notifiy: true);
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Image.network(
                          widget.category!.categoryIcon!,
                          width: 180.w,
                          height: 180.w,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 18.h),
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                categoryController.servicesLoading ||
                                        categoryController
                                            .displayedServicesList.isEmpty
                                    ? const Spacer()
                                    : Container(),
                                categoryController.servicesLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Styles.primaryColor,
                                        ),
                                      )
                                    : categoryController
                                            .displayedServicesList.isEmpty
                                        ? NoDataWidget(
                                            message: AppStrings.noServices.tr,
                                            color: widget
                                                .category!.categoryColor!
                                                .toColor(),
                                          )
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: !controller.showMore
                                                    ? 350.h
                                                    : fixDpiHeight(320),
                                                child: GridView.builder(
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.only(
                                                      top: 15.h),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 125,
                                                    childAspectRatio: 0.96,
                                                  ),
                                                  itemCount: categoryController
                                                      .displayedServicesList
                                                      .length,
                                                  // physics:
                                                  //     const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (ctx, i) =>
                                                      GridWidget(
                                                    i,
                                                    category: widget.category,
                                                    serviceItem: categoryController
                                                        .displayedServicesList[i],
                                                  ),
                                                ),
                                              ),
                                              categoryController.showMore
                                                  ? Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      padding: EdgeInsets.only(
                                                          bottom: controller
                                                                      .displayedServicesList
                                                                      .length ==
                                                                  6
                                                              ? 30.h
                                                              : 10.h,
                                                          top: 5.h),
                                                      child: CustomButton(
                                                        type: ButtonType
                                                            .secondary,
                                                        text: AppStrings
                                                            .showMore.tr,
                                                        width: 96,
                                                        height: 36.h,
                                                        fontSize: 10,
                                                        icon:
                                                            Icons.arrow_forward,
                                                        iconSize: 13,
                                                        onPressed: () {
                                                          controller
                                                              .getMoreServices();
                                                        },
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
