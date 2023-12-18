import 'package:egyptians_abroad/app/modules/start_service/controllers/start_service_controller.dart';
import 'package:get/get.dart';

class StartServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartServiceController>(
      () => StartServiceController(),
    );
  }
}
