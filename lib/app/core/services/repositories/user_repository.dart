import 'dart:convert';

import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/base_api.dart';

class UserRepository {
  Future<AppResponse> loginReq(Map<String, dynamic> body) async {
    return await BaseApi.postRequest(
      endPoint: "Login",
      body: jsonEncode(body),
    );
  }
}
