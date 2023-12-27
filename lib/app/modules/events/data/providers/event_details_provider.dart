import 'package:egyptians_abroad/app/core/data/models/api_response.dart';
import 'package:egyptians_abroad/app/core/services/api_service.dart';
import 'package:get/get.dart';

class EventDetailsProvider extends ApiService {
  Future<ApiResponse<dynamic>> fetchEventDetails({required int eventId}) async {
    final Response response = await get("GetEventDetails", query: {
      "eventId": eventId.toString(),
    });
    return ApiResponse.fromResponse(response, (json) => json);
  }
}
