import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class URLServiceView extends StatefulWidget {
  final String? url;
  const URLServiceView({super.key, this.url});

  @override
  State<URLServiceView> createState() => _URLServiceViewState();
}

class _URLServiceViewState extends State<URLServiceView> {
  InAppWebViewController? webView;

  @override
  Widget build(BuildContext context) {
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
                    url: Uri.parse(widget.url ?? "https://flutter.dev/")),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                )),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
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
