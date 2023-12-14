import 'package:get/get.dart';

import '../../../../core/data/models/api_response.dart';
import '../../../../core/services/api_service.dart';

class ChangePasswordProvider extends ApiService {
  Future<ApiResponse<dynamic>> postChangePassword(
      String oldPassword, String newPassword) async {
    final Response response = await post('ChangePassword', {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });
    return ApiResponse.fromResponse(response, (json) => json);
  }
}
