import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/localization_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/core/services/models/user_profile.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/controllers/home_showcase_controller.dart';
import 'package:egyptians_abroad/app/modules/login/controllers/login_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/country.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/job_category.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/residence_type.dart';
import 'package:egyptians_abroad/app/modules/registration/data/providers/avatars_provider.dart';
import 'package:egyptians_abroad/app/modules/registration/views/cars_first_step.dart';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../../otp/views/otp_view.dart';
import '../views/complete_account_residence.dart';
import '../views/select_avatar.dart';

class RegistrationController extends GetxController {
  double screenHeightPercentage = 0.94;
  // Auth service
  final AuthService authService = Get.find();

  // Login controller
  final LoginController loginController = Get.put(LoginController());

  final avatarsProvider = Get.put<AvatarsProvider>(AvatarsProvider());
  int selectedAvatarIndex = 9;

  RxBool showCountryError = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCountriesList();
    // await getGobCategoryList();
  }

  updateScreenHeight(double? h) {
    screenHeightPercentage = h ?? 0.99;
    update();
  }

  final TextEditingController nameTxtController = TextEditingController();
  final TextEditingController nationalIDTxtController = TextEditingController();
  final TextEditingController emailTxtController = TextEditingController();
  final TextEditingController residenceTxtController = TextEditingController();

  final ValueNotifier<int?> residenceCountry = ValueNotifier(null);
  final OtpFieldController otpTxtController = OtpFieldController();
  final TextEditingController passwordTxtController = TextEditingController();
  String otp = '';

  Future<AppResponse> createVerificationCode() async {
    AppResponse response = await UserRepository().createOtp(
      queryParameters: {
        "email": emailTxtController.text,
        "verificationType": 1
      },
    );
    if (response.status) {}
    return response;
  }

  Future<AppResponse> verifyCode(otp) async {
    AppResponse response = await UserRepository()
        .verifiyOtp({"email": emailTxtController.text, "code": otp});
    return response;
  }

  Future<void> register({String? carsOtp, String? carsUserId}) async {
    AppResponse response = await UserRepository().registerReq({
      "name": nameTxtController.text,
      "nationalId": nationalIDTxtController.text,
      "email": emailTxtController.text,
      "residenceCountryId": residenceCountry.value,
      "password": passwordTxtController.text,
      "verificationCode": carsOtp ?? otp,
      "userId": registerWithCars ? carsUserId : ""
    });

    AppHelper.name = nameTxtController.text;

    if (response.status) {
      // authService.setUserProfile(UserProfileModel(
      //     name: nameTxtController.text,
      //     nationalId: nationalIDTxtController.text,
      //     email: emailTxtController.text,
      //     residencyCountryId: residenceCountry.value,
      //     userId: registerWithCars ? carsUserId : "",
      //     avatarId: 9));
      await loginController.login(
          email: emailTxtController.text,
          pass: passwordTxtController.text,
          navigateToHome: false);

      if (carsOtp == null) {
        Get.offAllNamed(Routes.COMPLETEACCOUNT);
        passwordTxtController.clear();
      } else {
        Get.offAll(() => const CompleteAccountView(
              carRegister: true,
            ));
      }

      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: "تم إنشاء حساب جديد بنجاح",
          toastTitle: 'تاكيد',
          toastType: ToastType.success,
        ),
      );
    } else {
      // Get.offAllNamed(Routes.BOTTOMNAVIGATION);
      if (response.statusCode == 500 || response.statusCode == 400) {
        Get.showSnackbar(
          buildCustomToast(
            Get.context!,
            toastMsg: 'حدث خطأ ما',
            toastTitle: AppStrings.sorry.tr,
            toastType: ToastType.error,
          ),
        );
      } else {
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
    if (countriesList.isEmpty) {
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
    update();
  }

  Future<void> loadResidenceData() async {
    // setResidenceLoading(true);
    await getCountriesList();
    await getGobCategoryList();
    await getResidenceTypeList();

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
      setResidenceTypeList(residenceTypeData);
    }
  }

  List<JobCategory> jobCategoryList = [];

  setJobCategoryList(List<JobCategory> list) {
    jobCategoryList = list;
    update();
  }

  Future<void> getGobCategoryList() async {
    if (jobCategoryList.isEmpty) {
      AppResponse response = await UserRepository().getJobCategoryListReq();
      if (response.status) {
        Iterable iterable = response.data;
        List<JobCategory> joCatData =
            iterable.map((e) => JobCategory.fromJson(e)).toList();
        setJobCategoryList(joCatData);
      }
    }
  }

  Future<void> completeAccount(
      {bool? isEdit = true, bool carRegister = false}) async {
    Map<String, dynamic> reqBody = {
      "name": AppHelper.name,
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

    AppResponse response = await UserRepository()
        .editAccount(reqBody, queryParameters: {"guid": authService.userID});
    if (response.status) {
      Future.delayed(const Duration(seconds: 3), () async {
        carRegister
            ? Get.to(() => const RegistrationSelectAvatarView(
                  carRegister: true,
                ))
            : Get.toNamed(Routes.REGITSRATIONSELECTAVATAR);
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

  Future<void> editAccount(UserProfileModel profile) async {
    Map<String, dynamic> reqBody = {
      "name": profile.name,
      "jobCategoryID": profile.jobCategoryID,
      "residencyCountryId": profile.residencyCountryId,
      "residencyTypeId": profile.residencyTypeId,
      "residencyNo": profile.residencyNo,
      "foreignPassportNo": profile.foreignPassportNo,
      "residencyAddress": profile.residencyAddress,
      "jobTitle": profile.jobTitle,
      "egyptionMobile": profile.egyptionMobile,
      "foreignMobile": profile.foreignMobile,
      "messagingAddress": profile.messagingAddress,
      "passportNo": profile.passportNo
    };

    AppResponse response = await UserRepository().editAccount(reqBody,
        // TODO : make it dynamic
        queryParameters: {"guid": authService.userID});
    if (response.status) {
      Get.showSnackbar(buildCustomToast(
        Get.context!,
        toastMsg: AppStrings.successEdit.tr,
        toastTitle: 'تاكيد',
        toastType: ToastType.success,
      ));

      var controller = Get.put(HomeShowcaseController());
      await controller.getUserProfile();
      Future.delayed(const Duration(seconds: 1), () async {
        Get.back(closeOverlays: true);
        Get.offAndToNamed(Routes.ViewACCOUNT);
      });
    }
  }

  Future<void> getUserProfile() async {
    // AppResponse response =
    await UserRepository().viewAccountReq(queryParameters: {
      "Userid": authService.userID,
      "languageId": LocalizationHelper.isArabic() ? 1 : 2
    }).then((value) {
      if (value.status) {
        UserProfileModel userProfile =
            UserProfileModel.fromJson(value.data['data']);
        authService.setUserProfile(userProfile);
      } else {
        authService.setUserProfile(UserProfileModel.empty());
        handleError(value.errorCode ?? '-1');
      }
    }, onError: (error) {});
  }

  Future<void> pushAvatar({int? avatar, required int route}) async {
    Map<String, dynamic> reqBody = {
      "avatarId": avatar != null ? avatar + 1 : selectedAvatarIndex + 1,
    };

    AppResponse response = await UserRepository()
        .editAccount(reqBody, queryParameters: {"guid": authService.userID});

    if (response.status) {
      // var auth = Get.find<AuthService>();
      // await auth.getUserProfile;
      // var controller = Get.put(HomeShowcaseController());
      // await controller.getUserProfile();

      getUserProfile();

      Get.offNamed(Routes.DATASAVED,
          arguments: [avatar ?? selectedAvatarIndex, route]);
    }
  }

  getAvatars() {
    return avatarsProvider.avatars;
  }

  RxBool isDisabled = true.obs;
  selectAvatar(int index) {
    isDisabled.value = false;
    avatarsProvider.avatars[index].isSelected.value = true;
    selectedAvatarIndex = index;

    for (int i = 0; i < 9; i++) {
      if (avatarsProvider.avatars[i].index != index) {
        avatarsProvider.avatars[i].isSelected.value = false;
      }
    }
  }

  Future<void> checkNIDAndEmailInCars() async {
    // check if exist in cars first
    AppResponse response = await UserRepository().checkNIDAndEmailInCarsReq(
      queryParameters: {
        "Email": emailTxtController.text,
        "NID": nationalIDTxtController.text
      },
    );
    if (response.status) {
// check if exist in egy abroad
      AppResponse res = await verifyMailAndNID();

      if (res.status && res.data['data'] == true) {
        AppResponse verRes = await createVerificationCode();
        Get.to(() => OtpView(
              resendOtpTime: verRes.data['data']['data']['resendOtp'],
            ));
      } else {
        Get.showSnackbar(
          buildCustomToast(
            Get.context!,
            toastMsg: "الرقم القومي أو البريد الإلكتروني مُسجل بالفعل.",
            toastTitle: AppStrings.sorry.tr,
            toastType: ToastType.error,
          ),
        );
      }
    } else {
      switch (response.statusCode) {
        case -1:
          handleError(AppStrings.existInCarsValidationMsg.tr);
          break;
        case -2:
          handleError(AppStrings.existInCarsValidationMsg.tr);
          break;
        case 500:
          handleError(AppStrings.somethingWentWrong.tr);
          break;
        default:
          handleError(AppStrings.somethingWentWrong.tr);
      }
    }
  }

  void handleError(String error) {
    Get.showSnackbar(
      buildCustomToast(
        Get.context!,
        toastMsg: error,
        toastTitle: AppStrings.sorry.tr,
        toastType: ToastType.error,
      ),
    );
  }

  // final ValueNotifier<bool> agreeToShareWithCars = ValueNotifier(false);
  // setAgreeToShareWithCars(bool val) {
  //   agreeToShareWithCars.value = val;
  // }

  // final ValueNotifier<bool> showAgreeToShareWithCarsError =
  //     ValueNotifier(false);

  // setShowAgreeToShareWithCarsError(bool val) {
  //   showAgreeToShareWithCarsError.value = val;
  // }

  bool registerWithCars = false;
  setRegisterWithCars(bool val) {
    registerWithCars = val;
    update();
  }

  bool nationalIDCameFromCars = false;

  String carsUserId = "";

  Future<void> verifyCarsMail() async {
    AppResponse response = await UserRepository().signUpWithCarsReq(body: {
      "email": emailTxtController.text,
      "password": passwordTxtController.text
    });

    if (response.status) {
      nationalIDTxtController.text = response.data['data']['nid'] ?? "";
      nationalIDCameFromCars =
          response.data['data']['nid'] != null ? true : false;
      carsUserId = response.data['data']['userId'];
      // final registrationController = Get.find<RegistrationController>();
      setRegisterWithCars(true);
      Get.back(closeOverlays: true);
      getCountriesList();
      Get.to(() => CarsFirstStepView());
    } else {
      switch (response.statusCode) {
        case -3:
          handleError("البريد الإلكتروني مسجل بالفعل");
          break;
        case 0:
          handleError("الرقم القومي مُسجل بالفعل");
          break;
        case 201:
          handleError("خطأ في البريد الإلكترونى أو كلمة المرور");
          break;
        case 500:
          handleError(AppStrings.somethingWentWrong.tr);
          break;
        default:
          handleError(AppStrings.somethingWentWrong.tr);
      }
    }
  }

  Future<void> checkNIDInCars() async {
    // check if exist in cars first
    AppResponse response = await UserRepository().checkNIDAndEmailInCarsReq(
      queryParameters: {"Email": "", "NID": nationalIDTxtController.text},
    );
    if (response.status) {
// register the user with email from cars + nid ( from cars or app ) + name + residence

      await register(carsOtp: "", carsUserId: carsUserId);
    } else {
      switch (response.statusCode) {
        case -1:
          nationalIDCameFromCars
              ? await register(carsOtp: "", carsUserId: carsUserId)
              : handleError("الرقم القومي مسجل بالفعل");
          break;
        case -2:
          handleError(AppStrings.existInCarsValidationMsg.tr);
          break;
        case 500:
          handleError(AppStrings.somethingWentWrong.tr);
          break;
        default:
          handleError(AppStrings.somethingWentWrong.tr);
      }
    }
  }
}
