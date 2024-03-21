import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/app_images.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/more/controllers/more_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart' as html;

import 'widgets/column_element_widget.dart';
import '../../../core/custom_widgets/custom_card_widget.dart';
import 'widgets/header_widget.dart';
import 'package:flutter/material.dart';

class ContactUsView extends GetView<MoreController> {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          children: [
            HeaderWidget(
                imageAsset: AppImages.callIcon, text: AppStrings.contactUs.tr),
            SizedBox(height: 64.h),
            CustomCardWidget(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.callUsVia.tr,
                  style: Styles.getRegularStyle(
                      color: Styles.lightBlack, fontSize: fixDpiFont(16)),
                ),
                SizedBox(height: 16.h),
                ContactElementWidget(
                  onTap: () => null,
                  isRichText: true,
                  richText: html.Html(
                    data:
                        '<a href="02220543415">02220543415</a> - <a href="02220543414">02220543414</a> - <a href="19787">19787</a>',
                    onLinkTap: (url, attributes, element) {
                      launchUrl(Uri(scheme: 'tel', path: url));
                    },
                  ),
                  //launchUrl(Uri(scheme: 'tel', path: '02220543415')),
                  imageAsset: AppImages.callIcon,
                  imageScale: 2,
                  text: '02220543415',
                  fontSize: fixDpiFont(14),
                ),
                SizedBox(height: 24.h),
                ContactElementWidget(
                    onTap: () => launchUrl(Uri(
                        scheme: 'mailto',
                        path: 'egyptiansabroad@emigration.gov.eg')),
                    imageAsset: AppImages.gmailIcon,
                    text: 'egyptiansabroad@emigration.gov.eg',
                    textUnderline: true,
                    fontSize: fixDpiFont(14)),
                SizedBox(height: 24.h),
                ContactElementWidget(
                    onTap: () => launchUrl(
                        Uri.parse('https://www.facebook.com/Moemigegy/')),
                    imageAsset: AppImages.facebookIcon,
                    text: 'Moemigegy',
                    textUnderline: true,
                    fontSize: fixDpiFont(14)),
                SizedBox(height: 24.h),
                ContactElementWidget(
                    onTap: () =>
                        launchUrl(Uri.parse('https://twitter.com/Moemigegy/')),
                    imageAsset: AppImages.twitterIcon,
                    text: 'Moemigegy',
                    textUnderline: true,
                    fontSize: fixDpiFont(14)),
                SizedBox(height: 24.h),
                ContactElementWidget(
                    onTap: () => launchUrl(Uri.parse(
                        'https://www.youtube.com/channel/UCuJYKHp_-LEk4URcVuNHtbw')),
                    imageAsset: AppImages.youtubeIcon,
                    text: 'Moemigegy',
                    textUnderline: true,
                    fontSize: fixDpiFont(14)),
                SizedBox(height: 24.h),
                ContactElementWidget(
                    onTap: () => launchUrl(
                        Uri.parse('https://www.instagram.com/moemigegy/')),
                    imageAsset: AppImages.instagramIcon,
                    text: 'Moemigegy',
                    textUnderline: true,
                    fontSize: fixDpiFont(14)),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
