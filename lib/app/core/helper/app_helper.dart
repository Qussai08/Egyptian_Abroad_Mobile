import 'package:flutter/material.dart';

enum ServiceType {
  web,
  app,
  content,
}

class AppHelper {
  static String? _token;
  static String? get token => _token;
  static setToken(String? token) => _token = token;

  static ServiceType getServiceType(String serviceId) {
    if (serviceId == "1") {
      return ServiceType.web;
    } else if (serviceId == "2") {
      return ServiceType.app;
    } else {
      return ServiceType.content;
    }
  }

  static Future<void> launchUrl(String url) async {
    await launchUrl(url);
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "ff$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

extension on String {
  toBool() {
    print(this);
    return (toLowerCase() == "true") ? true : false;
  }
}
