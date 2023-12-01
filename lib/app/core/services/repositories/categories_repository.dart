import 'dart:io';
import 'dart:convert';

import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/base_api.dart';

class CategoriesRepository {
  Future<AppResponse> getCategories(Map<String, dynamic> body) async {
    return await BaseApi.postRequest(
      endPoint: "GetCategories",
      body: jsonEncode(body),
    );
  }

  Future<AppResponse> getServicesByCategoryId(Map<String, dynamic> body) async {
    return await BaseApi.postRequest(
      endPoint: "GetServicesByCategoryId",
      body: jsonEncode(body),
    );
  }
}
