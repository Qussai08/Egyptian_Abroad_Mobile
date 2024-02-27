import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/custom_widgets/main_button.dart';
import '../../../../core/theme/styles.dart';
import '../../controllers/home_showcase_controller.dart';

class CustoumShowcase1Widget extends StatelessWidget {
  CustoumShowcase1Widget({
    super.key,
  });
  final homeController = Get.find<HomeShowcaseController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240.w,
      height: 160.h,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 13.h,
            child: Container(
              width: 240.w,
              height: 130.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFFAFAFA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x1E000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 16.h, right: 11.w, left: 11.w, bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // logo image info
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Image.asset(AppImages.icInfo,
                              width: 16.w, height: 16.h),
                        ),

                        Expanded(
                          child: Text(
                              ' لتعديل بيانات حسابك و الاطلاع على ملفك الشخصى المتابعة من هنا',
                              style: Styles.getMediumStyle(
                                color: Styles.black,
                                fontSize: fixDpiFont(15),
                              ),
                              maxLines: 2,
                              textScaler: TextScaler.noScaling,
                              overflow: TextOverflow.visible),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    // Divider line
                    const Divider(
                      height: 0,
                      color: Styles.dividerColor,
                      thickness: 1,
                    ),
                    SizedBox(height: 13.h),

                    Row(
                      children: [
                        SizedBox(
                          width: 75.w,
                          height: 32.h,
                          child: MainButton(
                              enable: true,
                              text: Text(
                                'التالي',
                                style: Styles.getBoldStyle(
                                    color: Styles.white,
                                    fontSize: fixDpiFont(11)),
                              ),
                              onPress: () async {
                                await homeController.nextShowCase();
                              }),
                        ),
                        // space 12
                        SizedBox(width: 12.w),

                        SizedBox(
                          width: 75.w,
                          height: 32.h,
                          child: MainButton(
                              enable: true,
                              color: Styles.secondaryButtonColor,
                              text: Text(
                                'تخطى',
                                style: Styles.getBoldStyle(
                                    color: Styles.black,
                                    fontSize: fixDpiFont(11)),
                              ),
                              onPress: () {
                                homeController.dismissShowCase(context);
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // top arrow
          Positioned(
            right: 24.w,
            top: 0,
            child: Container(
              width: 24.w,
              height: 24.h,
              decoration: const ShapeDecoration(
                color: Color(0xFFFAFAFA),
                shape: StarBorder.polygon(
                  pointRounding: 0.5,
                  sides: 3,
                  // borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustoumShowcase2Widget extends StatelessWidget {
  CustoumShowcase2Widget({
    super.key,
  });
  final homeController = Get.find<HomeShowcaseController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 331.w,
      height: 169.h,
      child: Stack(
        children: [
          Positioned(
            top: 13.h,
            child: Container(
              width: 331.w,
              height: 153.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFFAFAFA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x1E000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 11.h, left: 13.w, right: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(AppImages.icInfo,
                              width: 16, height: 16),
                        ),
                        Expanded(
                          child: Text(
                            ' يتم إضافة الخدمات المفضلة لديك فى هذه القائمة و يمكنك الحذف و الاضافة من خلال الضغط على علامة المفضلة',
                            style: Styles.getMediumStyle(
                              color: Styles.black,
                              fontSize: fixDpiFont(15),
                            ),
                            textAlign: TextAlign.justify,
                            textScaler: TextScaler.noScaling,
                            maxLines: 5,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // Divider line
                    const Divider(
                      height: 0,
                      color: Styles.dividerColor,
                      thickness: 1,
                    ),
                    SizedBox(height: 13.h),

                    Row(
                      children: [
                        SizedBox(
                          height: 32.h,
                          width: 75.w,
                          child: MainButton(
                              enable: true,
                              text: Text(
                                'التالي',
                                style: Styles.getBoldStyle(
                                    color: Styles.white,
                                    fontSize: fixDpiFont(11)),
                              ),
                              onPress: () async {
                                await homeController.nextShowCase(
                                    isScroll: true);
                              }),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 32.h,
                          width: 75.w,
                          child: MainButton(
                              enable: true,
                              color: Styles.secondaryButtonColor,
                              text: Text(
                                'تخطى',
                                style: Styles.getBoldStyle(
                                    color: Styles.black,
                                    fontSize: fixDpiFont(11)),
                              ),
                              onPress: () {
                                homeController.dismissShowCase(context);
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // top arrow
          Positioned(
            right: 16.w,
            top: 0,
            child: Container(
              width: 24.w,
              height: 24.h,
              decoration: const ShapeDecoration(
                color: Color(0xFFFAFAFA),
                shape: StarBorder.polygon(
                  pointRounding: 0.5,
                  sides: 3,
                  // borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustoumShowcase3Widget extends StatelessWidget {
  CustoumShowcase3Widget({
    super.key,
  });
  final homeController = Get.find<HomeShowcaseController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 334.w,
      height: 150.h,
      child: Stack(
        children: [
          Positioned(
            top: 13.h,
            child: Container(
              width: 331.w,
              height: 125.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFFAFAFA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x1E000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 8.h, right: 10.w, left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Image.asset(AppImages.icInfo,
                              width: 16.w, height: 16.h),
                        ),
                        Expanded(
                          child: Text(
                            ' لعرض كل الخدمات يرجى الضغط على زر عرض كل الخدمات',
                            // textAlign: TextAlign.justify,
                            style: Styles.getMediumStyle(
                              color: Styles.black,
                              fontSize: fixDpiFont(15),
                            ),
                            textScaler: TextScaler.noScaling,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),
                    // Divider line
                    const Divider(
                      height: 0,
                      color: Styles.dividerColor,
                      thickness: 1,
                    ),
                    SizedBox(height: 13.h),

                    SizedBox(
                      width: 75.w,
                      height: 32.h,
                      child: MainButton(
                          enable: true,
                          text: Text(
                            'تم',
                            style: Styles.getBoldStyle(
                                color: Styles.white, fontSize: fixDpiFont(11)),
                          ),
                          onPress: () {
                            homeController.dismissShowCase(context);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // top arrow
          Positioned(
            right: 18.w,
            bottom: 0,
            // rotate arrow
            child: Transform.flip(
              flipY: true,
              child: Container(
                width: 24.w,
                height: 24.h,
                decoration: const ShapeDecoration(
                  color: Color(0xFFFAFAFA),
                  shape: StarBorder.polygon(
                    pointRounding: 0.5,
                    sides: 3,
                    // borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
