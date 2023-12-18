import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../data/providers/auth_provider.dart';
import '../services/storage_service.dart';
import '../services/api_service.dart';

class InitialBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut(() => StorageService(), fenix: true);
    Get.put<AuthService>(AuthService());
    Get.put<ApiService>(ApiService());
    Get.put<AuthProvider>(AuthProvider());
  }
}
