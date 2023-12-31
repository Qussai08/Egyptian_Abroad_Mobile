import 'package:egyptians_abroad/app/core/data/models/api_response.dart';
import 'package:egyptians_abroad/app/core/services/api_service.dart';
import 'package:get/get.dart';

import '../../../../core/helper/localization_helper.dart';

class EventDetailsProvider extends ApiService {
  Future<ApiResponse<dynamic>> fetchEventDetails({required int eventId}) async {
    final Response response = await get(
      "GetEventDetails?eventId=$eventId&LanguageId=${LocalizationHelper.isArabic() ? 1 : 2}",
    );
    return ApiResponse.fromResponse(response, (json) => json);
  }
}
