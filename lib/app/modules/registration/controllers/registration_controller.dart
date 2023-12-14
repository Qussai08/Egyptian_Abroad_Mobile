import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/secure_storage_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
import 'package:egyptians_abroad/app/modules/login/controllers/login_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/country.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/job_category.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/residence_type.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';

class RegistrationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCountriesList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final TextEditingController nameTxtController = TextEditingController();
  final TextEditingController nationalIDTxtController = TextEditingController();
  final TextEditingController emailTxtController = TextEditingController();
  final TextEditingController residenceTxtController = TextEditingController();

  final ValueNotifier<int?> residenceCountry = ValueNotifier(null);
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
      print("reg res -> ${response.data}");
      await loginController.login(
          email: emailTxtController.text,
          pass: passwordTxtController.text,
          navigateToHome: false);

      Future.delayed(const Duration(seconds: 3), () async {
        // if (await SecureStorageHelper.checkIsFirstTime()) {

        Get.offAllNamed(Routes.COMPLETEACCOUNT);
        // } else {
        //   Get.offAllNamed(Routes.BOTTOMNAVIGATION);
        // }
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

  Future<AppResponse> verifyMailAndNID() async {
    AppResponse response = await UserRepository().checkEmailAndNIIfExist(
        queryParameters: {
          "email": emailTxtController.text,
          "NID": nationalIDTxtController.text
        });
    return response;
  }

  //------------------------------
  // complete account
  //------------------------------

  final TextEditingController egPassportNumTxtController =
      TextEditingController();

  final ValueNotifier<int?> residenceType = ValueNotifier(null);

  final TextEditingController residenceNumTxtController =
      TextEditingController();
  final TextEditingController forignPassportNumTxtController =
      TextEditingController();
  final TextEditingController residenceAddressTxtController =
      TextEditingController();
  final ValueNotifier<int?> jobCategory = ValueNotifier(null);

  final TextEditingController jobTitleTxtController = TextEditingController();
  final TextEditingController egptionPhoneNumTxtController =
      TextEditingController();
  final TextEditingController forignPhoneNumTxtController =
      TextEditingController();
  final TextEditingController msgsAddressTxtController =
      TextEditingController();

  bool residenceDataLoading = false;
  setResidenceDataLoading(bool val) {
    residenceDataLoading = val;
    update();
  }

  final TextEditingController completeResidenceTxtController =
      TextEditingController();

  final ValueNotifier<int?> completeResidenceCountry = ValueNotifier(null);

  bool residenceLoading = true;
  setResidenceLoading(bool val) {
    residenceLoading = val;
    print("residenceLoading $residenceLoading");
    update();
  }

  Future<void> loadResidenceData() async {
    // setResidenceLoading(true);
    await getResidenceTypeList();
    await getGobCategoryList();
    setResidenceLoading(false);
  }

  List<ResidenceType> residenceTypeList = [];

  setResidenceTypeList(List<ResidenceType> list) {
    residenceTypeList = list;
    update();
  }

  Future<void> getResidenceTypeList() async {
    AppResponse response = await UserRepository().getResidencyTypeListReq();
    if (response.status) {
      Iterable iterable = response.data;
      List<ResidenceType> residenceTypeData =
          iterable.map((e) => ResidenceType.fromJson(e)).toList();
      print("residenceTypeData $residenceTypeData");
      setResidenceTypeList(residenceTypeData);
    }
  }

  List<JobCategory> jobCategoryList = [];

  setJobCategoryList(List<JobCategory> list) {
    jobCategoryList = list;
    update();
  }

  Future<void> getGobCategoryList() async {
    AppResponse response = await UserRepository().getJobCategoryListReq();
    if (response.status) {
      Iterable iterable = response.data;
      List<JobCategory> joCatData =
          iterable.map((e) => JobCategory.fromJson(e)).toList();
      print("joCatData $joCatData");

      setJobCategoryList(joCatData);
    }
  }

  Future<void> editAccount({bool? isEdit = true}) async {
    Map<String, dynamic> reqBody = {
      "jobCategoryID": jobCategory.value,
      "residencyCountryId": residenceCountry.value,
      "residencyTypeId": residenceType.value,
      "residencyNo": residenceNumTxtController.text,
      "foreignPassportNo": forignPassportNumTxtController.text,
      "residencyAddress": residenceAddressTxtController.text,
      "jobTitle": jobTitleTxtController.text,
      "egyptionMobile": egptionPhoneNumTxtController.text,
      "foreignMobile": forignPhoneNumTxtController.text,
      "messagingAddress": msgsAddressTxtController.text,
      "passportNo": egPassportNumTxtController.text
    };
    if (isEdit!) {
      reqBody['name'] = nameTxtController.text;
    }
    AppResponse response = await UserRepository().editAccount(reqBody,
        // TODO : make it dynamic
        queryParameters: {"guid": AppHelper.userId});
    if (response.status) {
      print("edit account res -> ${response.data}");
      Future.delayed(const Duration(seconds: 3), () async {
        Get.offAllNamed(Routes.BOTTOMNAVIGATION);
      });

      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: "تم استكمال بيانات الحساب بنجاح",
          toastTitle: 'تاكيد',
          toastType: ToastType.success,
        ),
      );
    }
  }
}
