import 'package:egyptians_abroad/app/core/constants/storage_constants.dart';
import 'package:egyptians_abroad/app/core/theme/styles.dart';
import 'package:egyptians_abroad/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'app/core/binding/initial_binding.dart';
import 'app/core/helper/dpi_helper.dart';
import 'app/core/helper/localization_helper.dart';
import 'app/core/helper/notification_helper.dart';
import 'app/core/helper/security_helper.dart';
import 'app/core/helper/storage_helper.dart';
import 'app/core/language/app_string.dart';
import 'app/core/services/storage_service.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init storage service
  await Get.putAsync(() => StorageService().init());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var notificationHelper = NotificationHelper();
  await notificationHelper.initialize();
  await FirebaseMessaging.instance.getInitialMessage().then((value) {
    if (value != null) {
      final StorageService storageService;
      if (Get.isRegistered<StorageService>()) {
        storageService = Get.find<StorageService>();
      } else {
        storageService = Get.put(StorageService());
      }
      storageService.setData(
          StorageConstants.kNotificationId, value.data['NotificationId']);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  StorageHelper();
  GetStorage().write(StorageHelper().encrypt(AppStrings.splashDiscription),
      StorageHelper().encrypt(AppStrings.splashDiscription));
  // await SecurityHelper().securityInit();

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({super.key});
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      SecurityHelper.checkIsNotNormal();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Device Orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GlobalLoaderOverlay(
      closeOnBackButton: true,
      overlayColor: Colors.blue.withOpacity(0.20),
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return const Center(
          child: SpinKitRotatingCircle(
            color: Styles.white,
            size: 100.0,
          ),
        );
      },
      child: GetMaterialApp(
        enableLog: false,
        logWriterCallback: (text, {isError = false}) {},
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
      ),
    );
  }
}
