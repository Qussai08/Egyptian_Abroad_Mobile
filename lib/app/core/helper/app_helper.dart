import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/models/user_profile.dart';

enum ServiceType {
  web,
  app,
  content,
}

class AppHelper {
  // static String? _token;
  // static String? get token => _token;
  // static setToken(String? token) {
  //   _token = token;
  //   getUserIdFromToken(_token!);
  // }

  // static UserProfileModel? userProfile;
  // static setUserProfile(UserProfileModel? profile) => userProfile = profile;

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

  // static String? userId;

  // static String getUserIdFromToken(String code) {
  //   String normalizedSource = base64Url.normalize(code.split(".")[1]);
  //   String id =
  //       json.decode(utf8.decode(base64Url.decode(normalizedSource)))['sub'];
  //   userId = id;
  //   return id;
  // }
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
