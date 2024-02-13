import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/core/services/models/service.dart';
import 'package:egyptians_abroad/app/core/services/repositories/categories_repository.dart';
import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_taost.dart';
import '../../../core/helper/error_helper.dart';

class CategoryController extends GetxController {
  int? _categoryId;
  final AuthService authService = Get.find();

  void setCategoryId(int val, {bool notifiy = false}) {
    _categoryId = val;
    if (notifiy) update();
  }

  int? get categoryId => _categoryId;

  CategoryController(this._categoryId);

  @override
  void onInit() {
    super.onInit();
    getServicesList(_categoryId!);
  }

  List<ServiceItem> allServices = [];
  List<ServiceItem> searchServicesList = [];
  List<ServiceItem> displayedServicesList = [];

  bool servicesLoading = false;

  String _keySearch = '';

  void setKeySearch(String keySeacrh, {bool notifiy = false}) {
    _currentPage = 0;
    _currentPageSearch = 0;
    _noOfPages = 1;
    _noOfPagesSearch = 1;
    allServices = [];
    searchServicesList = [];
    displayedServicesList = [];
    _keySearch = keySeacrh;
    getServicesList(categoryId!);
  }

  String get keySearch => _keySearch;

  Future<void> getServicesList(int categoryId,
      {int? pageNo = 1, applyLoading = true}) async {
    if (applyLoading) _updateServicesLoading(true);
    try {
      if ((_keySearch.isEmpty && _currentPage <= _noOfPages) ||
          (_keySearch.isNotEmpty && _currentPageSearch <= _noOfPagesSearch)) {
        AppResponse response =
            await CategoriesRepository().getServicesByCategoryId({
          "categoryId": categoryId,
          "servicesName": _keySearch,
          "userId": authService.userID,
          "pageNo": pageNo,
          "pageSize": 5000
        });
        if (response.status) {
          ServicesData serviceData = ServicesData.fromJson(response.data);
          if (_keySearch.isEmpty) {
            setCurrentPage(serviceData.currentPage);
            setNoOfPages(serviceData.totalPages);
            setTotalCount(serviceData.totalCount);
            for (var serv in serviceData.services) {
              if (allServices.firstWhereOrNull(
                      (element) => element.serviceName == serv.serviceName) ==
                  null) {
                allServices.add(serv);
              }
            }
            // allServices.addAll(serviceData.services);
            displayedServicesList = allServices;
          } else {
            setCurrentPageSearch(serviceData.currentPage);
            setNoOfPagesSearch(serviceData.totalPages);
            setTotalCountSearch(serviceData.totalCount);
            for (var serv in serviceData.services) {
              if (searchServicesList.firstWhereOrNull(
                      (element) => element.serviceName == serv.serviceName) ==
                  null) {
                searchServicesList.add(serv);
              }
            }
            // searchServicesList.addAll(serviceData.services);
            displayedServicesList = searchServicesList;
          }
          setShowMore();
        }
      }
    } catch (e) {
      Get.showSnackbar(
        buildCustomToast(
          Get.context!,
          toastMsg: ErrorHelper.getErrorMessage('genrealError'),
          toastTitle: 'عفواً',
          toastType: ToastType.error,
        ),
      );
    }

    if (applyLoading) _updateServicesLoading(false);
  }

  void _updateServicesLoading(bool val) {
    servicesLoading = val;
    update();
  }

  int _currentPageSearch = 0;

  int get currentPageSearch => _currentPageSearch;
  void setCurrentPageSearch(int value, {bool notifiy = true}) {
    _currentPageSearch = value;
    if (notifiy) update();
  }

  int _noOfPagesSearch = 1;

  int get noOfPagesSearch => _noOfPagesSearch;
  void setNoOfPagesSearch(int value) {
    _noOfPagesSearch = value;
    update();
  }

  int _currentPage = 0;

  int get currentPage => _currentPage;
  void setCurrentPage(int value, {bool notifiy = true}) {
    _currentPage = value;
    if (notifiy) update();
  }

  int _noOfPages = 1;

  int get noOfPages => _noOfPages;
  void setNoOfPages(int value) {
    _noOfPages = value;
    update();
  }

  int _totalCount = 0;

  int get totalCount => _totalCount;
  void setTotalCount(int value, {bool notifiy = true}) {
    _totalCount = value;
    if (notifiy) update();
  }

  int _totalCountSearch = 0;

  int get totalCountSearch => _totalCountSearch;
  void setTotalCountSearch(int value, {bool notifiy = true}) {
    _totalCountSearch = value;
    if (notifiy) update();
  }

  Future<void> getMoreServices() async {
    if (_keySearch.isEmpty) {
      await getServicesList(_categoryId!,
          pageNo: _currentPage + 1, applyLoading: false);
    } else {
      await getServicesList(_categoryId!,
          pageNo: _currentPageSearch + 1, applyLoading: false);
    }
  }

  bool _showMore = true;

  bool get showMore => _showMore;

  void setShowMore() {
    if ((_keySearch.isEmpty && currentPage == noOfPages) ||
        (_keySearch.isNotEmpty && currentPageSearch == noOfPagesSearch) ||
        displayedServicesList.isEmpty) {
      _showMore = false;
    } else {
      _showMore = true;
    }
    update();
  }
}
