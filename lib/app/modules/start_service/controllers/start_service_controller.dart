import 'dart:io';

import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/core/services/models/service_content.dart';
import 'package:egyptians_abroad/app/core/services/repositories/categories_repository.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/controllers/home_showcase_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/custom_widgets/custom_taost.dart';
import '../../../core/helper/error_helper.dart';
import '../../../core/helper/localization_helper.dart';
import '../../../core/services/models/service.dart';

class StartServiceController extends GetxController {
  Future<ServiceContent?> getServicesContent(int serviceID) async {
    try {
      AppResponse response = await CategoriesRepository()
          .getServicesContentByServiceId(queryParameters: {
        "serviceId": serviceID,
        "languageId": LocalizationHelper.isArabic() ? 1 : 2
      });
      if (response.status) {
        print("response.data['data'] ${response.data['data']}");
        ServiceContent serviceContent =
            ServiceContent.fromJson(response.data['data']);

        return serviceContent;
      }
    } catch (e) {
      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: ErrorHelper.getErrorMessage('genrealError'),
          toastTitle: 'عفواً',
          toastType: ToastType.error,
        ),
      );
    }
    return null;
  }

  Future<void> handleFavorite(ServiceItem item) async {
    var favoritesController = Get.find<HomeShowcaseController>();
    if (item.isMyFavorite.value) {
      await favoritesController.removeFromFavorites(
          userId: AuthService().getUserProfile.userId!,
          serviceId: item.serviceId.toString(),
          service: item);
    } else {
      await favoritesController.addToFavorites(
          userId: AuthService().getUserProfile.userId!,
          serviceId: item.serviceId.toString(),
          service: item);
    }
    item.isMyFavorite.value = !item.isMyFavorite();
    update();
  }

  Future<void> removeFromFavoriteInHome(ServiceItem item) async {
    var favoritesController = Get.find<HomeShowcaseController>();

    await favoritesController.removeFromFavorites(
        userId: AuthService().getUserProfile.userId!,
        serviceId: item.serviceId.toString(),
        service: item);

    // await favoritesController.updateFavoritesList(
    //     userId: AuthService().getUserProfile.userId!);
  }

  launchApp({String? appLink, String? androidID, String? iosID}) async {
    print("appLink $appLink");
    if (appLink != null && appLink.isNotEmpty) {
      try {
        final isLaunch = await launchUrl(
          Uri.parse(appLink),
          mode: LaunchMode.externalApplication,
        );
        if (!isLaunch) {
          openStoreLink(androidID: androidID, iosID: iosID);
        }
      } catch (e) {
        openStoreLink(androidID: androidID, iosID: iosID);
      }
    } else {
      // Open store links
      openStoreLink(androidID: androidID, iosID: iosID);
    }
  }

  void openStoreLink({String? androidID, String? iosID}) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? androidID : iosID;
      final url2 = androidID == iosID
          ? Uri.parse(iosID!)
          : Uri.parse(
              Platform.isAndroid
                  ? "market://details?id=$appId"
                  : "https://apps.apple.com/app/id$appId",
            );
      print("url2 : $url2");
      await launchUrl(
        url2,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
