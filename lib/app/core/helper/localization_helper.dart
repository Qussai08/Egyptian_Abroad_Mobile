import 'dart:ui';

import 'package:get/get.dart';

import '../language/ar_eg.dart';
import '../language/en_us.dart';

class LocalizationHelper extends Translations {
  // Supported languages and locales
  // Needs to be same order with locales
  static final languages = {
    Language.english: const Locale('en', 'US'),
    Language.arabic: const Locale('ar', 'EG')
  };

  static final locales = [
    languages[Language.english]!,
    languages[Language.arabic]!
  ];

  // here we need to add our default language
  static Locale local = languages[Language.arabic]!;

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        languages[Language.arabic]!.languageCode: ar,
        languages[Language.english]!.languageCode: en
      };

  bool isArabic() {
    return Get.locale!.languageCode == languages[Language.arabic]!.languageCode;
  }

  // Gets locale from language, and updates the locale
  void changeLocale(Language language) {
    Get.updateLocale(languages[language]!);
  }
}

enum Language { arabic, english }
