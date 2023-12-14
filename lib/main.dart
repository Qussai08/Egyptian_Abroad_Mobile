import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/core/binding/initial_binding.dart';
import 'app/core/helper/dpi_helper.dart';
import 'app/core/helper/localization_helper.dart';
import 'app/core/helper/notification_helper.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var notificationHelper = NotificationHelper();
  await notificationHelper.initialize();
  // await notificationHelper.subscribeToTopic('broadcast');

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
      initialRoute: AppPages.INITIAL,
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
