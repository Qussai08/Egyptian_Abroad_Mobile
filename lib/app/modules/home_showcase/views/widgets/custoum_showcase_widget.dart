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
      width: 340.w,
      height: 200.h,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 13,
            child: Container(
              width: 240,
              // height: 131,
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' لتعديل بيانات حسابك و الاطلاع على ملفك الشخصى المتابعة من هنا',
                      textAlign: TextAlign.justify,
                      style: Styles.getMediumStyle(
                        color: Styles.black,
                        fontSize: 15,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Divider line
                    const Divider(
                      color: Styles.dividerColor,
                      thickness: 2,
                    ),

                    MainButton(
                        enable: true,
                        text: Text(
                          'التالي',
                          style: Styles.getBoldStyle(color: Styles.white),
                        ),
                        onPress: () {
                          homeController.nextShowCase(Get.context!);
                        }),
                  ],
                ),
              ),
            ),
          ),

          // top arrow
          Positioned(
            left: 192,
            top: 0,
            child: Container(
              width: 24,
              height: 24.h,
              decoration: const ShapeDecoration(
                color: Color(0xFFFAFAFA),
                shape: StarBorder.polygon(
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
      width: 340.w,
      height: 180.h,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 13,
            child: Container(
              width: 240,
              // height: 131,
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'لعرض كل الخدمات يرجى الضغط على زر عرض كل الخدمات',
                      textAlign: TextAlign.justify,
                      style: Styles.getMediumStyle(
                        color: Styles.black,
                        fontSize: 15,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Divider line
                    const Divider(
                      color: Styles.dividerColor,
                      thickness: 2,
                    ),

                    MainButton(
                        enable: true,
                        text: Text(
                          'تم',
                          style: Styles.getBoldStyle(color: Styles.white),
                        ),
                        onPress: () {
                          homeController.dismissShowCase(context);
                        }),
                  ],
                ),
              ),
            ),
          ),

          // top arrow
          Positioned(
            left: 192,
            bottom: 5,
            // rotate arrow
            child: Transform.flip(
              flipY: true,
              child: Container(
                width: 24,
                height: 24.h,
                decoration: const ShapeDecoration(
                  color: Color(0xFFFAFAFA),
                  shape: StarBorder.polygon(
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
