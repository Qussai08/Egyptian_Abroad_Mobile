import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/grid_widget.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/no_data_widget.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_container.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/helper/localization_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/category/views/widgets/category_appbar.dart';
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
                appBar: CategoryAppBar(
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
                                'assets/icons/male.png',
                                width: 36.w,
                                fit: BoxFit.fitWidth,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              TitleText(
                                title: "${AppStrings.hello.tr} احمد" + "!",
                                fontSize: fixDpiFont(18),
                                color: const Color(0xff263238),
                              )
                            ],
                          ),
                        ),
                        TextFieldContainer(
                          width: double.infinity,
                          height: 50,
                          borderColor: const Color(0xffEBEBEB),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: const Icon(
                                  Icons.search,
                                  color: Styles.primaryColor,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _searchController,
                                  textDirection: LocalizationHelper.isArabic()
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  scrollPadding:
                                      const EdgeInsets.only(bottom: 120),
                                  keyboardType: TextInputType.text,
                                  onChanged: (val) {
                                    if (val.isEmpty) {
                                      _keySearch = val;
                                      controller.setKeySearch(_keySearch,
                                          notifiy: true);
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  onFieldSubmitted: (val) {
                                    _keySearch = val;
                                    controller.setKeySearch(_keySearch,
                                        notifiy: true);
                                  },
                                  textAlign: LocalizationHelper.isArabic()
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'baloo'),
                                  decoration: Styles().inputDecoration.copyWith(
                                        hintText: "بتدور على ايه؟",
                                        hintStyle: TextStyle(
                                            fontSize: fixDpiFont(14),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'baloo'),
                                        fillColor: const Color(0xffEBEBEB),
                                        contentPadding: const EdgeInsets.only(
                                            right: 10, left: 10, bottom: 5),
                                      ),
                                  textInputAction: TextInputAction.search,
                                ),
                              ),
                            ],
                          ),
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
                                            message: 'لا توجد خدمات',
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
                                                        text: 'عرض المزيد',
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
                // floatingActionButtonLocation:
                //     FloatingActionButtonLocation.centerFloat,
                // floatingActionButton: categoryController.showMore
                //     ? Visibility(
                //         visible:
                //             MediaQuery.of(context).viewInsets.bottom == 0.0,
                //         child: Padding(
                //           padding: EdgeInsets.only(bottom: 20.h),
                //           child: CustomButton(
                //             type: ButtonType.secondary,
                //             text: 'عرض المزيد',
                //             width: 95.w,
                //             height: 36.h,
                //             fontSize: 10,
                //             icon: Icons.arrow_forward,
                //             iconSize: 13,
                //             onPressed: () {
                //               controller.getMoreServices();
                //             },
                //           ),
                //         ),
                //       )
                //     : Container(),
              )),
        ),
      ),
    );
  }
}
