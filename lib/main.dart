import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/app/modules/splash/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/core/binding/initial_binding.dart';
import 'app/core/helper/dpi_helper.dart';
import 'app/core/helper/localization_helper.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Device Orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Egyptians Abroad",
      supportedLocales: LocalizationHelper.locales,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: LocalizationHelper.local,
      translations: LocalizationHelper(),
      //initialRoute: AppPages.INITIAL,
      home: SplashView(),
      getPages: AppPages.routes,
      theme: Styles.myTheme,
      initialBinding: InitialBinding(),
      builder: (buildContext, widget) {
        handleFixSize(buildContext);
        return widget!;
      },
    );
  }
}
