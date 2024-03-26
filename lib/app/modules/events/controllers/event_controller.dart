import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/helper/error_helper.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/modules/registration/controllers/registration_controller.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/country.dart';
import 'package:egyptians_abroad/app/modules/registration/data/models/job_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/event_model.dart';
import '../data/providers/events_provider.dart';

class EventsController extends GetxController with StateMixin<List<Event>> {
  final EventsProvider eventsProvider = Get.find<EventsProvider>();

  RxList<Event> eventsList = <Event>[].obs;
  final RegistrationController registrationController =
      Get.put(RegistrationController());
  ScrollController scrollController = ScrollController();

  RxBool isLoading = false.obs;
  int pageNo = 1;
  int pageSize = 10;
  bool hasMore = true;
  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(scrollListener);
  }

  void clear() {
    eventsList.clear();
    pageNo = 1;
    hasMore = true;
  }

  void clearFilters() async {
    dateFrom = '';
    dateTo = '';
    countriesKeySearch = '';
    countriesSearchController.clear();
    jobCategoryKeySearch = '';
    jobCategorySearchController.clear();
    setSelectAllCountries(true);
    setSelectAllJobCategory(true);
    await filterEvents(closeBottomSheet: false, clearFilters: true);
    update();
  }

  bool showDatesError = false;

  setShowDatesError(bool val) {
    showDatesError = val;
    update();
  }

  bool checkFilterDatesValidation() {
    if (dateFrom.isNotEmpty && dateTo.isEmpty) {
      setShowDatesError(true);
      return false;
    } else if (dateTo.isNotEmpty && dateFrom.isEmpty) {
      setShowDatesError(true);
      return false;
    } else {
      setShowDatesError(false);
      return true;
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    pageNo = 1;
    hasMore = true;
    eventsList.clear();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value &&
        hasMore) {
      pageNo++;
      filterEvents(clearList: false);
    }
  }

  Future<void> loadEvents(
      {Map<String, dynamic>? body,
      bool clearFilters = false,
      bool? clearList = true}) async {
    isLoading.value = true;

    countryIds = registrationController.countriesList;
    onSelectcountry(clearFilters: clearFilters);
    jobCategoryIds = registrationController.jobCategoryList;
    onSelectjobCategory(clearFilters: clearFilters);

    if (clearList!) eventsList.clear();
    change([], status: RxStatus.loading());

    await eventsProvider
        .getEventsListReq(body != null && !clearFilters
            ? body
            : {
                "search": "",
                "countryIds": [...countryIds.map((e) => e.id)],
                "jobCategoryIds": [...jobCategoryIds.map((e) => e.id)],
                "pageNo": pageNo,
                "pageSize": pageSize,
              })
        .then((value) {
      if (value.isSuccess) {
        if (value.body != null) {
          if (value.body!.events.isEmpty && pageNo == 1) {
            change(null, status: RxStatus.empty());
            isLoading.value = false;
            return;
          }
          if (value.body!.events.isEmpty) {
            isLoading.value = false;
            hasMore = false;
            return;
          }
          if (pageNo < value.body!.totalPages) {
            hasMore = true;
          } else {
            hasMore = false;
          }
          pageNo == 1
              ? eventsList.value = value.body!.events
              : eventsList.addAll(value.body!.events);

          // change(eventsList, status: RxStatus.success());
          isLoading.value = false;
        } else {
          // change(null, status: RxStatus.empty());
          isLoading.value = false;
        }
      } else {
        handleError(value.errors!.first);
        // change(null, status: RxStatus.error('حدث خطأ ما'));
        // change(null, status: RxStatus.error('${value.error}'));
        isLoading.value = false;
      }
    }, onError: (error) {
      handleError(error.toString());
      // change(null, status: RxStatus.error('حدث خطأ ما'));
      // change(null, status: RxStatus.error('$error'));
      isLoading.value = false;
    });
  }

  Future<void> retry() async {
    // change([], status: RxStatus.loading());
    await loadEvents();
  }

// ------ Events Filtering --------

  String keySearch = '';
  final TextEditingController searchController = TextEditingController();

  String countriesKeySearch = '';
  final TextEditingController countriesSearchController =
      TextEditingController();

  String jobCategoryKeySearch = '';
  final TextEditingController jobCategorySearchController =
      TextEditingController();

  List<Country> countryIds = <Country>[];
  List<Country> filteredCountryIds = <Country>[];
  List<JobCategory> jobCategoryIds = <JobCategory>[];
  List<JobCategory> filteredJobCategoryIds = <JobCategory>[];

  String dateFrom = "";
  String dateTo = "";

  filterCountriesByName() {
    countryIds = [];

    if (countriesKeySearch.isEmpty) {
      countryIds = registrationController.countriesList;
    } else {
      for (var i = 0; i < registrationController.countriesList.length; i++) {
        if (registrationController.countriesList[i].country
            .toLowerCase()
            .contains(countriesKeySearch.toLowerCase())) {
          countryIds.add(registrationController.countriesList[i]);
        }
      }
    }
    update();
  }

  filterJobCategoriesByName() {
    jobCategoryIds = [];
    if (jobCategoryKeySearch.isEmpty) {
      jobCategoryIds = registrationController.jobCategoryList;
    } else {
      for (var i = 0; i < registrationController.jobCategoryList.length; i++) {
        if (registrationController.jobCategoryList[i].name
            .toLowerCase()
            .contains(jobCategoryKeySearch.toLowerCase())) {
          jobCategoryIds.add(registrationController.jobCategoryList[i]);
        }
      }
    }
    update();
  }

  setDateFrom(String from) {
    dateFrom = from;
    update();
  }

  setDateTo(String to) {
    dateTo = to;
    update();
  }

  Future<void> filterEvents(
      {bool closeBottomSheet = true,
      bool clearFilters = false,
      bool? clearList = true}) async {
    if (checkFilterDatesValidation()) {
      // clear();
      // change([], status: RxStatus.loading());
      Map<String, dynamic> body = {
        "search": keySearch.isNotEmpty ? keySearch : "",
        "pageNo": pageNo,
        "pageSize": pageSize
      };
      if (dateFrom.isNotEmpty) {
        body['dateFrom'] = dateFrom;
      }
      if (dateTo.isNotEmpty) {
        body['dateTo'] = dateTo;
      }

      if (filteredCountryIds.isNotEmpty) {
        List<int> selectedIDs = [];
        for (var element in filteredCountryIds) {
          if (element.isSelected) {
            selectedIDs.add(element.id);
          }
        }
        body['countryIds'] = selectedIDs;
      } else {
        body['countryIds'] = [];
      }
      if (filteredJobCategoryIds.isNotEmpty) {
        List<int> selectedIDs = [];
        for (var element in filteredJobCategoryIds) {
          if (element.isSelected) {
            selectedIDs.add(element.id);
          }
        }
        body['jobCategoryIds'] = selectedIDs;
      } else {
        body['jobCategoryIds'] = [];
      }

      await loadEvents(
          body: body, clearFilters: clearFilters, clearList: clearList);
      if (closeBottomSheet) Get.back();
    }
  }

  String countryDisplayString = "";

  onSelectcountry({int? index, bool clearFilters = false}) {
    List<String> selectedcountries = [];

    if (index != null) {
      countryIds[index].isSelected = !countryIds[index].isSelected;
      if (countryIds[index].isSelected) {
        filteredCountryIds.add(countryIds[index]);
      } else {
        filteredCountryIds
            .removeWhere((element) => element.id == countryIds[index].id);
        selectAllCountries = false;
      }
    }
    if (selectAllCountries) {
      countryDisplayString = "الكل";
      countryIds.forEach((element) => element.isSelected = true);
      filteredCountryIds.clear();
      filteredCountryIds = [...countryIds];
    } else {
      filteredCountryIds
          .forEach((element) => selectedcountries.add(element.country));
      countryDisplayString = selectedcountries.join(" - ");
    }

    if (clearFilters) {
      setSelectAllCountries(true);
    }

    update();
  }

  bool selectAllJobCategory = true;

  setSelectAllJobCategory(bool val) {
    for (var i = 0; i < jobCategoryIds.length; i++) {
      jobCategoryIds[i].isSelected = val;
    }
    selectAllJobCategory = val;
    if (!selectAllJobCategory) {
      filteredJobCategoryIds = [];
    }
    // }
    update();
  }

  bool selectAllCountries = true;

  setSelectAllCountries(bool val) {
    for (var i = 0; i < countryIds.length; i++) {
      countryIds[i].isSelected = val;
    }
    selectAllCountries = val;
    if (!selectAllCountries) {
      filteredCountryIds = [];
    }
    update();
  }

  String jobCatDisplayString = "";

  onSelectjobCategory({int? index, bool clearFilters = false}) {
    List<String> selectedjobCategory = [];

    if (index != null) {
      jobCategoryIds[index].isSelected = !jobCategoryIds[index].isSelected;
      if (jobCategoryIds[index].isSelected) {
        filteredJobCategoryIds.add(jobCategoryIds[index]);
      } else {
        filteredJobCategoryIds
            .removeWhere((element) => element.id == jobCategoryIds[index].id);
        selectAllJobCategory = false;
      }
    }
    if (selectAllJobCategory) {
      jobCatDisplayString = "الكل";
      jobCategoryIds.forEach((element) => element.isSelected = true);
      filteredJobCategoryIds.clear();
      filteredJobCategoryIds = [...jobCategoryIds];
    } else {
      filteredJobCategoryIds
          .forEach((element) => selectedjobCategory.add(element.name));
      jobCatDisplayString = selectedjobCategory.join(" - ");
    }

    if (clearFilters) {
      setSelectAllJobCategory(true);
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
