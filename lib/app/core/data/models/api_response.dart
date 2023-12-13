// ignore_for_file: empty_catches, annotate_overrides, overridden_fields

import 'package:get/get.dart';

class ApiResponse<T> extends Response<T> {
  final bool isSuccess;
  final T? body;
  final int? error;

  ApiResponse({required this.isSuccess, this.body, this.error});

  factory ApiResponse.fromResponse(Response response, Function fromJson) {
    if (response.hasError) {
      throw response.statusCode ?? -1;
    } else {
      if (response.body!['isSuccess'] ?? false) {
        return ApiResponse(
          isSuccess: true,
          body: fromJson(response.body!['data']),
        );
      } else {
        throw int.parse(response.body!['error']['errorCode'] ?? '-1');
      }
    }
  }

  factory ApiResponse.fromResponseNoException(
      Response response, Function fromJson) {
    if (response.hasError) {
      if (response.statusCode == 500) {
        return ApiResponse(isSuccess: false, error: response.statusCode);
      } else {
        // TODO: fix this error
        int error = -8;
        try {
          error = int.parse(response.body!['error']['errorCode'] ?? '8');
        } catch (e) {}
        return ApiResponse(isSuccess: false, error: error);
      }
    } else {
      if (response.body!['isSuccess'] ?? false) {
        return ApiResponse(
          isSuccess: true,
          body: fromJson(response.body!['data']),
        );
      } else {
        return ApiResponse(
          isSuccess: false,
          error: int.parse(response.body!['error']['errorCode'] ?? '8'),
        );
      }
    }
  }
}
