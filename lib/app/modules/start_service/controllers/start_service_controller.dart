import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/core/services/models/service_content.dart';
import 'package:egyptians_abroad/app/core/services/repositories/categories_repository.dart';
import 'package:egyptians_abroad/app/modules/home/controllers/favorites_controller.dart';
import 'package:egyptians_abroad/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../core/services/models/service.dart';

class StartServiceController extends GetxController {
  Future<ServiceContent?> getServicesContent(int serviceID) async {
    AppResponse response = await CategoriesRepository()
        .getServicesContentByServiceId(
            queryParameters: {"serviceId": serviceID});
    if (response.status) {
      ServiceContent serviceContent =
          ServiceContent.fromJson(response.data['data']);

      return serviceContent;
    }
    return null;
  }

  Future<void> handleFavorite(ServiceItem item) async {
    var favoritesController = Get.find<HomeController>();
    if (item.isMyFavorite.value) {
      await favoritesController.removeFromFavorites(
          userId: AuthService().getUserProfile!.userId!,
          serviceId: item.serviceId.toString());
    } else {
      await favoritesController.addToFavorites(
          userId: AuthService().getUserProfile!.userId!,
          serviceId: item.serviceId.toString());
    }
    item.isMyFavorite.value = !item.isMyFavorite();
    await favoritesController.updateFavoritesList(
        userId: AuthService().getUserProfile!.userId!);
  }

  Future<void> removeFromFavoriteInHome(ServiceItem item) async {
    var favoritesController = Get.find<HomeController>();

    await favoritesController.removeFromFavorites(
        userId: AuthService().getUserProfile!.userId!,
        serviceId: item.serviceId.toString());

    await favoritesController.updateFavoritesList(
        userId: AuthService().getUserProfile!.userId!);
  }
}
