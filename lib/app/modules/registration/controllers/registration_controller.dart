import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
import 'package:egyptians_abroad/app/modules/login/controllers/login_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/country.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';

class RegistrationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCountriesList();
  }

  final TextEditingController nameTxtController = TextEditingController();
  final TextEditingController nationalIDTxtController = TextEditingController();
  final TextEditingController emailTxtController = TextEditingController();
  final ValueNotifier<int> residenceCountry = ValueNotifier(1);
  final OtpFieldController otpTxtController = OtpFieldController();
  final TextEditingController passwordTxtController = TextEditingController();
  String otp = '';

  Future<void> createVerificationCode() async {
    AppResponse response = await UserRepository()
        .createOtp(queryParameters: {"email": emailTxtController.text});
    if (response.status) {
      print("createVerificationCode : ${response.status}");
    }
  }

  Future<AppResponse> verifyCode(otp) async {
    AppResponse response = await UserRepository()
        .verifiyOtp({"email": emailTxtController.text, "code": otp});
    return response;
  }

  Future<void> register(LoginController loginController) async {
    AppResponse response = await UserRepository().registerReq({
      "name": nameTxtController.text,
      "nationalId": nationalIDTxtController.text,
      "email": emailTxtController.text,
      "residenceCountryId": residenceCountry.value,
      "password": passwordTxtController.text,
      "verificationCode": otp
    });
    if (response.status) {
      Future.delayed(const Duration(seconds: 3), () async {
        await loginController.login(
            email: emailTxtController.text, pass: passwordTxtController.text);
        passwordTxtController.clear();
      });

      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: "تم إنشاء الحساب بنجاح",
          toastTitle: 'تاكيد',
          toastType: ToastType.success,
        ),
      );
    } else {
      // Get.offAllNamed(Routes.BOTTOMNAVIGATION);

      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: "الرقم القومي أو البريد الإلكتروني مُسجل بالفعل.",
          toastTitle: AppStrings.sorry.tr,
          toastType: ToastType.error,
        ),
      );
    }
  }

  bool countriesLoading = false;
  setCountriesLoading(bool val) {
    countriesLoading = val;
    update();
  }

  List<Country> countriesList = [];

  setCountriesList(List<Country> list) {
    countriesList = list;
    update();
  }

  Future<void> getCountriesList() async {
    setCountriesLoading(true);
    AppResponse response = await UserRepository().getCountriesReq();
    if (response.status) {
      Iterable iterable = response.data;
      List<Country> countriesData =
          iterable.map((e) => Country.fromJson(e)).toList();
      setCountriesList(countriesData);
    }

    setCountriesLoading(false);
  }
}
