import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_button.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/custom_textfield.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/textfield_title.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/title_text.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egyptians_abroad/app/core/helper/validators.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_images.dart';

class URLServiceView extends StatefulWidget {
  const URLServiceView({super.key});

  @override
  State<URLServiceView> createState() => _URLServiceViewState();
}

class _URLServiceViewState extends State<URLServiceView> {
  InAppWebViewController? webView;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(LoginController());

    return NetworkIndicator(
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: const CustomAppBar(),
            body: SizedBox(
              height: fixDpiScreenHeight(),
              width: fixDpiScreenWidth(),
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri(
                  scheme: 'https',
                  host: 'flutter.dev',
                )),
                // URLRequest(url: WebUri("https://www.facebook.com/")),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                )),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                  //                 webView!.loadUrl(urlRequest:  URLRequest(url: Uri(
                  // scheme: 'https',
                  // host: 'flutter.dev',
                  // )),);

                  // webView.postUrl(url: "https://samak.com.sa/api/payment-transaction/payment", postData: null)
                },
                onLoadStart: (controller, url) {
                  print(url!.path);
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),
            )),
      ),
    );
  }
}
