import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/models/service_content.dart';
import 'package:egyptians_abroad/app/core/services/repositories/categories_repository.dart';
import 'package:get/get.dart';

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
}
