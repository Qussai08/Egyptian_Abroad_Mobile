import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DataSavedController extends GetxController {
  final AuthService authService = Get.find();
  var data = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // authService.getUserProfile!.avatarId = data[0].toString();
    _goNext();
  }

  _goNext() async {
    // showcaseViewed must be set to true after the showcase is viewed for the first time only.
    authService.showcaseViewed = true;

    await 2.delay();
    Get.offAllNamed(Routes.BOTTOMNAVIGATION);
  }
}
