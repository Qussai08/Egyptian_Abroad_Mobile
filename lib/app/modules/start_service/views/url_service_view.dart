// import 'dart:html';

import 'package:egyptians_abroad/app/core/custom_widgets/custom_appbar.dart';
import 'package:egyptians_abroad/app/core/custom_widgets/network_indecator.dart';
import 'package:egyptians_abroad/app/core/helper/dpi_helper.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class URLServiceView extends StatefulWidget {
  final String? url;
  const URLServiceView({super.key, this.url});

  @override
  State<URLServiceView> createState() => _URLServiceViewState();
}

class _URLServiceViewState extends State<URLServiceView> {
  late final WebViewController _controller;

  // InAppWebViewController? webView;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..loadRequest(Uri.parse(widget.url ?? 'https://www.google.com/'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith("fb://") ||
                request.url.startsWith("twitter://") ||
                request.url.startsWith("instagram://")) {
              return NavigationDecision
                  .prevent; // Prevent the WebView from loading the URL
            }
            return NavigationDecision
                .navigate; // Allow other URLs to be loaded as normal
          },
        ),
      );

    _controller = controller;
  }

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
                  child: WebViewWidget(controller: _controller))

              // InAppWebView(
              //   initialUrlRequest: URLRequest(
              //       url: Uri.parse(widget.url ?? "https://google.com/")),
              //   initialOptions: InAppWebViewGroupOptions(
              //       crossPlatform: InAppWebViewOptions(
              //     javaScriptEnabled: true,
              //   )),
              //   onWebViewCreated: (InAppWebViewController controller) {
              //     webView = controller;
              //   },
              //   onLoadStart: (controller, url) {
              //   },
              //   onConsoleMessage: (controller, consoleMessage) {
              //   },
              // ),
              )),
    );
  }
}
