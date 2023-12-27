import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/grid_widget.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/no_data_widget.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
        builder: (categoryController) {
          categoryController.servicesLoading
              ? context.loaderOverlay.show()
              : context.loaderOverlay.hide();
          return Scaffold(
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
                    title: Text(
                      widget.category!.categoryName,
                      textAlign: TextAlign.center,
                      style: Styles.getBoldStyle(
                          color: Styles.black, fontSize: fixDpiFont(26)),
                    ),
                  ),
                  body: Container(
                    height: fixDpiScreenHeight(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 40.h),
                        CustomTextFormField(
                          controller: _searchController,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Styles.primaryColor,
                          ),
                          inputData: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          hintTxt: "بحث",
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
                          height: 45.h,
                        ),
                        SizedBox(
                          height: fixDpiScreenHeight() * 0.7,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 18.h),
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    // categoryController.servicesLoading
                                    //     ? Container(
                                    //         height: fixDpiScreenHeight(),
                                    //         child: const Center(
                                    //           child: CircularProgressIndicator(
                                    //             color: Styles.primaryColor,
                                    //           ),
                                    //         ),
                                    //       )
                                    //     :
                                    categoryController
                                            .displayedServicesList.isEmpty
                                        ? NoDataWidget(
                                            message: AppStrings.noServices.tr,
                                            color: widget
                                                .category!.categoryColor!
                                                .toColor(),
                                          )
                                        : GridView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(top: 15.h),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 125.w,
                                              mainAxisSpacing: 20.h,
                                              childAspectRatio: 0.96,
                                            ),
                                            itemCount: categoryController
                                                .displayedServicesList.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (ctx, i) => GridWidget(
                                              i,
                                              category: widget.category,
                                              serviceItem: categoryController
                                                  .displayedServicesList[i],
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 50.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
