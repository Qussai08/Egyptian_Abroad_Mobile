import 'package:egyptians_abroad/app/modules/events/data/providers/event_details_provider.dart';
import 'package:get/get.dart';

class EventDetailsController extends GetxController {
  int eventId = Get.arguments[0];
  var event;
  @override
  onInit() async {
    super.onInit();
    var eventDetailsProvider = Get.find<EventDetailsProvider>();

    await eventDetailsProvider.fetchEventDetails(eventId: eventId).then((value) {
      
    });
  }
}
