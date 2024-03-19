import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/more/controllers/more_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_card_widget.dart';
import 'widgets/header_widget.dart';
import 'package:flutter/material.dart';

class AboutUsView extends GetView<MoreController> {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          children: [
            HeaderWidget(
                imageAsset: AppImages.mediumLogo, text: AppStrings.aboutUs.tr),
            SizedBox(height: 64.h),
            CustomCardWidget(
              child: ListView(
                children: [
                  Text(
                    'رؤية و رسالة الوزارة\n',
                    style: Styles.getBoldStyle(
                      color: Styles.mediumBlack,
                      fontSize: fixDpiFont(16),
                    ),
                  ),
                  Text(
                    'الهجرة ظاهرة طبيعية وهى بمفهومها الحالى تعتبر وسيلة هامة لمواجهة المصاعب التى تعانى منها بعض الدول، ومع أن مصر حديثة العهد بالهجرة، إلا أن سياسة الحكومة المصرية تجاه الهجرة مرت بالعديد من المراحل، فقد عرفت مصر نظام الهجرة إبتداء من الخمسينيات بأعداد محدودة إلى أن تزايدت أعداد المهاجرين إعتبارا من أواخر الستينيات حيث بدأت مصر تصعيد الإهتمام بأبنائها المهاجرين فى الخارج.\n\nوزارة الهجرة وشئون المصريين بالخارج التى تم إنشاؤها فى التاسع عشر من سبتمبر عام 2015 تعد هى الجهة المختصة بإدارة ورعاية شئون المصريين المقيمين خارج الحدود الجغرافية للدولة المصرية فى إطار من التنسيق والتعاون مع الوزارات والهيئات والجهات التى تهتم بذات الشأن فى ظل رعاية مجلس الوزراء، وتعتبر الجهة الرئيسية للتواصل مع المصريين بالخارج ، فهى وزارة مستحدثة جاءت تلبية لنداءات المصريين بالخارج بهدف تكوين راى عام وطنى يساند القضايا الوطنية والقومية والإستفادة من خبرات المصريين فى الخارج فى شتى مجالات التنمية ولتدعيم الروابط القومية والسياسية والإجتماعية والإقتصادية بينهم وبين الوطن الام وبينهم وبين بعضهم البعض ولكى يضع سياسة شاملة لهجرة المصريين للخارج فى ضوء أهداف التنمية القومية وصالح البلاد.',
                    textAlign: TextAlign.justify,
                    style: Styles.getMediumStyle(
                      color: Styles.mediumBlack,
                      fontSize: fixDpiFont(16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
