import 'package:egyptians_abroad/app/modules/events/controllers/event_details_controller.dart';
import 'package:egyptians_abroad/app/modules/events/data/providers/event_details_provider.dart';
import 'package:get/get.dart';

class EventDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EventDetailsProvider>(EventDetailsProvider());
    Get.put<EventDetailsController>(EventDetailsController());
  }
}
