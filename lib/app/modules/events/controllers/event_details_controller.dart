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
        event.value.startDate = value.body['startDate'] != null
            ? dateFormatter(value.body['startDate'])
            : "";
        event.value.endDate = value.body['endDate'] != null
            ? dateFormatter(value.body['endDate'])
            : "";
        event.value.link = urlFormatter(event().link!);
        isLoading.value = false;
      }
    });
  }

  // String dateFormatter(String date) {
  //   DateTime x = DateTime.parse(date);
  //   return DateFormat('dd MMMM yyyy \t hh:mm a', 'ar_SA').format(x);
  // }
 static String dateFormatter(String dateTimestamp) {
    DateTime myDateTime = DateTime.parse(dateTimestamp);

    String month = DateFormat('MMMM', 'ar_EG').format(myDateTime).toString();

    String formattedDate =
        DateFormat('dd MMMM yyyy hh:mm a', 'ar_EG').format(myDateTime);

    String formatWithEngNums =
        "${myDateTime.day} $month ${myDateTime.year} ${myDateTime.hour}:${myDateTime.minute} ${formattedDate.split(' ').last}";

    return formatWithEngNums;
  }
  String urlFormatter(String url) {
    if (url.startsWith('https://') || url.startsWith('http://')) {
      return url;
    } else {
      return 'https://$url';
    }
  }
}
