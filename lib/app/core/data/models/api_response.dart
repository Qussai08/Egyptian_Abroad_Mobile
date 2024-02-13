// ignore_for_file: empty_catches, annotate_overrides, overridden_fields

import 'package:get/get.dart';

class ApiResponse<T> extends Response<T> {
  final bool isSuccess;
  final T? body;
  final List<dynamic>? errors;

  ApiResponse({required this.isSuccess, this.body, this.errors});

  factory ApiResponse.fromResponse(Response response, Function fromJson) {
    if (response.hasError) {
      throw response.statusCode ?? -1;
    } else {
      // TODO: fix this
      // return ApiResponse(
      //   isSuccess: true,
      //   body: fromJson(response.body),
      // );

      // Uncomment this when the API is ready
      if (response.body!['isSuccess'] ?? false) {
        return ApiResponse(
          isSuccess: true,
          body: fromJson(response.body!['data']),
        );
      } else {
        // return ApiResponse(
        //   isSuccess: false,
        //   body: null,
        //   errors: fromJson(response.body!['errors']),
        // );

        throw response.body!['errors'].first['errorCode'] ?? '-1';
      }
    }
  }

  // factory ApiResponse.fromResponseNoException(
  //     Response response, Function fromJson) {
  //   if (response.hasError) {
  //     if (response.statusCode == 500) {
  //       return ApiResponse(isSuccess: false, errors: response.statusCode);
  //     } else {
  //       // TODO: fix this errors
  //       int errors = -8;
  //       try {
  //         errors = int.parse(response.body!['errors']['errorCode'] ?? '8');
  //       } catch (e) {}
  //       return ApiResponse(isSuccess: false, errors: errors);
  //     }
  //   } else {
  //     if (response.body!['isSuccess'] ?? false) {
  //       return ApiResponse(
  //         isSuccess: true,
  //         body: fromJson(response.body!['data']),
  //       );
  //     } else {
  //       return ApiResponse(
  //         isSuccess: false,
  //         errors: int.parse(response.body!['errors']['errorCode'] ?? '8'),
  //       );
  //     }
  //   }
  // }
}
