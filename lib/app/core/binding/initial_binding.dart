import 'package:get/get.dart';

import '../services/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut(() => StorageService(), fenix: true);
  }
}
