import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static Future<String?> localRead(String key) async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if (await secureStorage.containsKey(key: key)) {
      return secureStorage.read(key: key);
    } else {
      return null;
    }
  }

  static localWrite(String key, value) async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.write(key: key, value: json.encode(value));
  }

  static localRemove(String key) async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if (await secureStorage.containsKey(key: key)) {
      await secureStorage.delete(key: key);
    }
  }

// save value "first_time" to show complete account or not

  static Future<void> setIsFirstTime(bool value) async {
    return await localWrite("first_time", value);
  }

  static Future<bool> checkIsFirstTime() async {
    return bool.parse(await localRead("first_time") ?? "true");
  }

  ///-----------------
  /// user language
  ///------------------

  // static Future<bool> setUserLang(String language) async {
  //   FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  //   return prefs.setString("lang", language);
  // }

  // static Future<String> getUserLang() async {
  //   FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  //   return prefs.getString("lang") ?? 'ar';
  // }
}
