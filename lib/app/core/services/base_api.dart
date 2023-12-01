/// This class will be the blueprint for all API calls in the system
/// It will create an instance of Dio to do the network calls
/// Also define the main structre for all http requests
/// Each descendant class will have a single responsibility
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:egyptians_abroad/app/core/constants/globals.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';

// The class must be Abtract
class BaseApi {
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
  static Future<AppResponse> getRequest(
      {required String endPoint,
      Map<String, dynamic>? extraHeaders,
      String? shopToken}) async {
    Map<String, dynamic> headers = {"languageId": AppHelper.languageId};

    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }

    try {
      _response = await _dio.get(endPoint, options: Options(headers: headers));

      return AppResponse(
          statusCode: _response.statusCode,
          status: _response.data['isSuccess'],
          data: _response.data);
    } on DioException catch (e) {
      return AppResponse(status: false, error: e, errorMessage: e.message);
    }
  }

  // Perform POST request
  static Future<AppResponse> postRequest({
    body,
    required String endPoint,
  }) async {
    try {
      var _queryParms = {"languageId": AppHelper.languageId};

      _response = await _dio.post(Constants.baseUrl + endPoint,
          data: body,
          //  options: body,
          queryParameters: _queryParms);

      return AppResponse(
          statusCode: _response.statusCode,
          status: _response.data['isSuccess'],
          data: _response.data['data']);
    } on DioException catch (e) {
      return AppResponse(status: false, error: e, errorMessage: e.message);
    }
  }
}
