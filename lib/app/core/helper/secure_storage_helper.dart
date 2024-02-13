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

  ///-----------------
  /// user language
  ///------------------

  static Future<void> setFirstTime(bool val) async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.write(key: "first_time", value: val.toString());
  }

  static Future<bool> getFirstTime() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    if (await secureStorage.containsKey(key: "first_time")) {
      String first = await secureStorage.read(key: "first_time") ?? "true";
      return bool.tryParse(first) ?? true;
    } else {
      return true;
    }
  }
}
