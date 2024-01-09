/// This class will be the blueprint for all API calls in the system
/// It will create an instance of Dio to do the network calls
/// Also define the main structre for all http requests
/// Each descendant class will have a single responsibility
library;

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:egyptians_abroad/app/core/constants/globals.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:get/get.dart' as getx;
import 'package:get/instance_manager.dart';

import '../../routes/app_pages.dart';
import '../helper/localization_helper.dart';
import 'auth_service.dart';

// The class must be Abtract
class CarsBaseApi {
  final authService = Get.find<AuthService>();

  // Instance of the package to perform network calls
  static late Dio _dio;

  // The response returned from network call
  static late Response _response;

  static Future<void> initializeDio() async {
    _dio = Dio(BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: const Duration(milliseconds: 50000)));
  }

  // Perform GET request
  Future<AppResponse> getRequest(
      {required String endPoint,
      Map<String, dynamic>? extraHeaders,
      Map<String, dynamic>? queryParameters,
      String? token,
      bool? jsonResponse = true}) async {
    Map<String, dynamic> headers = {
      "languageId": LocalizationHelper.isArabic() ? 1 : 2
    };
    String token = authService.accessToken ?? '';
    token = "Bearer $token";
    headers["Authorization"] = token;

    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }

    try {
      _response = await _dio.get(endPoint,
          options: Options(headers: headers), queryParameters: queryParameters);
      print("_response get _response.data ${_response.data}");

      return AppResponse(
          statusCode: int.parse(_response.data['appResponseCode']),
          status:
              _response.data['appResponseMessage'] == "Success" ? true : false,
          data: _response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode != null) {
          if (e.response!.statusCode! == 401) {
            await AuthService()
                .logout()
                .then((value) => getx.Get.offAllNamed(Routes.LOGIN));
          }
        }
      }
      return AppResponse(status: false, error: e, errorMessage: e.message);
    }
  }

  // Perform POST request
  Future<AppResponse> postRequest(
      {body, Map<String, dynamic>? options, required String endPoint}) async {
    String token = authService.accessToken ?? '';
    //  String token = authService.accessToken ?? '';
    token = "Bearer $token";
    var options0 = Options(headers: {
      "Authorization": token,
    });

    try {
      Map<String, dynamic> queryParms = {
        "languageId": LocalizationHelper.isArabic() ? 1 : 2
      };

      if (options != null) {
        queryParms.addAll(options);
      }

      _response = await _dio.post(Constants.baseUrl + endPoint,
          data: body, options: options0, queryParameters: queryParms);

      return AppResponse(
          statusCode: int.parse(_response.data['appResponseCode']),
          status:
              _response.data['appResponseMessage'] == "Success" ? true : false,
          data: _response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode != null) {
          if (e.response!.statusCode! == 401) {
            await AuthService()
                .logout()
                .then((value) => getx.Get.offAllNamed(Routes.LOGIN));
          }
        }
      }
      return AppResponse(status: false, error: e, errorMessage: e.message);
    }
  }
}
