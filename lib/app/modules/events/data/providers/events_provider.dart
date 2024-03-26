import 'package:get/get.dart';
import '../../../../core/constants/globals.dart';
import '../../../../core/data/models/api_response.dart';
import '../../../../core/helper/localization_helper.dart';
import '../../../../core/services/api_service.dart';
import '../models/event_model.dart';

class EventsProvider extends ApiService {
  // =================== Get Events List ===================
  Future<ApiResponse<EventData>> getEventsListReq(
      Map<String, dynamic> body) async {
    final Response response = await post(
        "${Constants.getEventsList}?LanguageId=${LocalizationHelper.isArabic() ? 1 : 2}",
        body);
    return ApiResponse.fromResponse(
        response, (json) => EventData.fromJson(json));
  }
}
