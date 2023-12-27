import 'package:egyptians_abroad/app/modules/events/data/models/event_model.dart';
import 'package:egyptians_abroad/app/modules/events/data/providers/event_details_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventDetailsController extends GetxController {
  int eventId = Get.arguments;
  Rx<Event> event = Event().obs;
  RxBool isLoading = true.obs;
  @override
  onInit() {
    super.onInit();
    getEventDetails();
  }

  getEventDetails() async {
    var eventDetailsProvider = Get.find<EventDetailsProvider>();

    await eventDetailsProvider
        .fetchEventDetails(eventId: eventId)
        .then((value) {
      if (value.isSuccess) {
        event.value = Event.fromJson(value.body);
        event().startDate = dateFormatter(value.body['startDate']);
        event().endDate = dateFormatter(value.body['endDate']);
        event().link = urlFormatter(event().link!);
        isLoading.value = false;
      }
    });
  }

  String dateFormatter(String date) {
    DateTime x = DateTime.parse(date);
    return DateFormat('dd MMMM yyyy hh:mm a', 'ar_SA').format(x);
  }

  String urlFormatter(String url) {
    if (url.startsWith('https://') || url.startsWith('http://')) {
      return url;
    } else {
      return 'https://$url';
    }
  }
}
