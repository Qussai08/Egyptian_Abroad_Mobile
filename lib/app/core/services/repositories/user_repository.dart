import 'dart:convert';

import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/base_api.dart';

import '../../helper/localization_helper.dart';

class UserRepository {
  Future<AppResponse> loginReq(Map<String, dynamic> body) async {
    return await BaseApi().postRequest(
      endPoint: "Login",
      body: jsonEncode(body),
    );
  }

  Future<AppResponse> changePasswordReq(Map<String, dynamic> body) async {
    return await BaseApi.postRequest(
      endPoint: "ChangePassword",
      body: jsonEncode(body),
    );
  }

  Future<AppResponse> createOtp({Map<String, dynamic>? queryParameters}) async {
    return await BaseApi().getRequest(
        endPoint: "CreateVerificationCode", queryParameters: queryParameters);
  }

  Future<AppResponse> verifiyOtp(Map<String, dynamic> body) async {
    return await BaseApi().postRequest(endPoint: "VerifyCode", body: body);
  }

  Future<AppResponse> registerReq(Map<String, dynamic> body) async {
    return await BaseApi().postRequest(
      endPoint: "Registration",
      body: jsonEncode(body),
    );
  }

  Future<AppResponse> getCountriesReq() async {
    return await BaseApi().getRequest(
        endPoint: "GetCountryList",
        queryParameters: {"langId": LocalizationHelper.isArabic() ? 1 : 2},
        jsonResponse: false);
  }
}
