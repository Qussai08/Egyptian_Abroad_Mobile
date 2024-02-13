import 'package:egyptians_abroad/app/modules/registration/controllers/data_saved_controller.dart';
import 'package:get/get.dart';

class DataSavedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DataSavedController>(DataSavedController());
  }
}
