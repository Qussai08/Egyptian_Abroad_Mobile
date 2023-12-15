import 'dart:convert';

import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/base_api.dart';

import '../../helper/localization_helper.dart';

class UserRepository {
  Future<AppResponse> loginReq(Map<String, dynamic> body) async {
    return await BaseApi.postRequest(
      endPoint: "Login",
      body: jsonEncode(body),
    );
  }

  Future<AppResponse> createOtp({Map<String, dynamic>? queryParameters}) async {
    return await BaseApi.getRequest(
        endPoint: "CreateVerificationCode", queryParameters: queryParameters);
  }

  Future<AppResponse> verifiyOtp(Map<String, dynamic> body) async {
    return await BaseApi.postRequest(endPoint: "VerifyCode", body: body);
  }

  Future<AppResponse> registerReq(Map<String, dynamic> body) async {
    return await BaseApi.postRequest(
      endPoint: "Registration",
      body: jsonEncode(body),
    );
  }

  Future<AppResponse> getCountriesReq() async {
    return await BaseApi.getRequest(
        endPoint: "GetCountryList",
        queryParameters: {"langId": LocalizationHelper.isArabic() ? 1 : 2},
        jsonResponse: false);
  }

  Future<AppResponse> checkEmailAndNIIfExist(
      {Map<String, dynamic>? queryParameters}) async {
    return await BaseApi.getRequest(
      endPoint: "CheckEmailAndNIIfExist",
      queryParameters: queryParameters,
    );
  }

  Future<AppResponse> getResidencyTypeListReq() async {
    return await BaseApi.getRequest(
        endPoint: "GetResidencyTypeList",
        queryParameters: {"langId": LocalizationHelper.isArabic() ? 1 : 2},
        jsonResponse: false);
  }

  Future<AppResponse> getJobCategoryListReq() async {
    return await BaseApi.getRequest(
        endPoint: "GetJobCategoryList",
        queryParameters: {"langId": LocalizationHelper.isArabic() ? 1 : 2},
        jsonResponse: false);
  }

  Future<AppResponse> editAccount(Map<String, dynamic> body,
      {Map<String, dynamic>? queryParameters}) async {
    return await BaseApi.postRequest(
        endPoint: "EditAccount",
        body: jsonEncode(body),
        options: queryParameters,
        jsonResponse: false);
  }

  Future<AppResponse> viewAccountReq(
      {Map<String, dynamic>? queryParameters}) async {
    return await BaseApi.getRequest(
        endPoint: "ViewAccount",
        queryParameters: queryParameters,
        jsonResponse: false);
  }

  Future<AppResponse> forgetPasswordReq(Map<String, dynamic> body,
      {Map<String, dynamic>? queryParameters}) async {
    return await BaseApi.postRequest(
        endPoint: "ForgetUserPassword",
        body: jsonEncode(body),
        options: queryParameters,
        jsonResponse: true);
  }
}
