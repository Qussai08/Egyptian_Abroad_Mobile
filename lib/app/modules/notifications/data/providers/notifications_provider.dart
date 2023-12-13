import 'package:get/get.dart';

import '../../../../core/constants/globals.dart';
import '../../../../core/data/models/api_response.dart';
import '../../../../core/services/api_service.dart';
import '../models/notifications_model/notifications_model.dart';

class NotificationsProvider extends ApiService {
  // =================== Get Notification History ===================
  Future<ApiResponse<List<NotificationsModel>>> getNotificationHistory() async {
    final Response response =
        await get(Constants.getNotificationHistory, query: {
      'userid': authService.userID,
    });
    return ApiResponse.fromResponse(
        response, (json) => NotificationsModel.fromJsonList(json));
  }
}
