import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/helper/error_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/country.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/job_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data/models/api_response.dart';
import '../data/models/event_model.dart';
import '../data/providers/events_provider.dart';

class EventsController extends GetxController with StateMixin<List<Event>> {
  final EventsProvider eventsProvider = Get.find<EventsProvider>();

  RxList<Event> eventsList = <Event>[].obs;
  final RegistrationController registrationController = Get.find();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  Future<void> loadEvents({Map<String, dynamic>? body}) async {
    isLoading.value = true;

    eventsList.clear();
    // change([], status: RxStatus.loading());

    await eventsProvider
        .getEventsListReq(body ??
            {
              "search": "",
              "countryIds": [],
              "jobCategoryIds": [],
              "pageNo": 1,
              "pageSize": 1000000
            })
        .then((value) {
      if (value.isSuccess) {
        if (value.body != null) {
          if (value.body!.events.isEmpty) {
            change(null, status: RxStatus.empty());
            isLoading.value = false;
            return;
          }
          eventsList.addAll(value.body!.events ?? []);
          change(value.body!.events, status: RxStatus.success());
          isLoading.value = false;
        } else {
          change(null, status: RxStatus.empty());
          isLoading.value = false;
        }
      } else {
        handleError(value.errors!.first);
        // change(null, status: RxStatus.error('حدث خطأ ما'));
        // change(null, status: RxStatus.error('${value.error}'));
        isLoading.value = false;
      }
    }, onError: (error) {
      print("errorrrr $error");
      handleError(error);
      // change(null, status: RxStatus.error('حدث خطأ ما'));
      // change(null, status: RxStatus.error('$error'));
      isLoading.value = false;
    });
    //TODO : refactor
    countryIds = registrationController.countriesList;
    print(
        "registrationController.jobCategoryList ${registrationController.jobCategoryList}");
    jobCategoryIds = registrationController.jobCategoryList;
  }

  Future<void> retry() async {
    // change([], status: RxStatus.loading());
    await loadEvents();
  }

// ------ Events Filtering --------

  String keySearch = '';
  final TextEditingController searchController = TextEditingController();

  List<Country> countryIds = <Country>[];
  List<JobCategory> jobCategoryIds = <JobCategory>[];
  String dateFrom = "";
  String dateTo = "";

  setDateFrom(String from) {
    dateFrom = from;
    update();
  }

  setDateTo(String to) {
    dateTo = to;
    update();
  }

  Future<void> filterEvents() async {
    // change([], status: RxStatus.loading());
    Map<String, dynamic> body = {
      "search": keySearch.isNotEmpty ? keySearch : "",
      "pageNo": 1,
      "pageSize": 1000000
    };
    if (countryIds.isNotEmpty) {
      List<int> selectedIDs = [];
      for (var element in countryIds) {
        if (element.isSelected) {
          selectedIDs.add(element.id);
        }
      }
      body['countryIds'] = selectedIDs;
    } else {
      body['countryIds'] = [];
    }
    if (jobCategoryIds.isNotEmpty) {
      List<int> selectedIDs = [];
      for (var element in jobCategoryIds) {
        if (element.isSelected) {
          selectedIDs.add(element.id);
        }
      }
      body['jobCategoryIds'] = selectedIDs;
    } else {
      body['jobCategoryIds'] = [];
    }
    if (dateFrom.isNotEmpty) {
      body['dateFrom'] = dateFrom;
    }
    if (dateTo.isNotEmpty) {
      body['dateTo'] = dateTo;
    }
    print("filterEvents $body");

    await loadEvents(body: body);
  }

  String countryDisplayString = "";

  onSelectcountry(int index) {
    countryIds[index].isSelected = !countryIds[index].isSelected;
    if (countryIds.isNotEmpty) {
      List<String> selectedcountries = [];
      for (var element in countryIds) {
        if (element.isSelected) {
          selectedcountries.add(element.country);
        }
      }
      countryDisplayString = selectedcountries.join(" - ");
    }
    update();
  }

  String jobCatDisplayString = "";

  onSelectjobCategory(int index) {
    jobCategoryIds[index].isSelected = !jobCategoryIds[index].isSelected;
    if (jobCategoryIds.isNotEmpty) {
      List<String> selectedjobCategory = [];
      for (var element in jobCategoryIds) {
        if (element.isSelected) {
          selectedjobCategory.add(element.name);
        }
      }
      jobCatDisplayString = selectedjobCategory.join(" - ");
    }
    update();
  }

  void handleError(String error) {
    Get.showSnackbar(
      buildCustomToast(
        Get.context!,
        toastMsg: ErrorHelper.getErrorMessage(error),
        toastTitle: AppStrings.sorry.tr,
        toastType: ToastType.error,
      ),
    );
  }
}
