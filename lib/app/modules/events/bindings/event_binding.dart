import 'package:egyptians_abroad/app/modules/events/controllers/event_controller.dart';
import 'package:get/get.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EventsController>(
      EventsController(),
    );
  }
}
