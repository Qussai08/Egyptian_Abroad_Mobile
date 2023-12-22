import 'package:get/get.dart';

class EditAccountController extends GetxController {
  RxBool isDisabled = true.obs;

  enableButton() {
    print('Pressed');
    isDisabled = false.obs;
    print(isDisabled);
  }
}
