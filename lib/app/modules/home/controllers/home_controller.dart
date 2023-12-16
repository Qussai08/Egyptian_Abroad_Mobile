import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:egyptians_abroad/app/core/helper/app_helper.dart';
import 'package:egyptians_abroad/app/core/helper/localization_helper.dart';
import 'package:egyptians_abroad/app/core/services/app_response.dart';
import 'package:egyptians_abroad/app/core/services/auth_service.dart';
import 'package:egyptians_abroad/app/core/services/models/category.dart';
import 'package:egyptians_abroad/app/core/services/models/user_profile.dart';
import 'package:egyptians_abroad/app/core/services/repositories/categories_repository.dart';
import 'package:egyptians_abroad/app/core/services/repositories/user_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUserProfile();
    getCategoriesList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool userProfileLoading = false;
  setUserProfileLoading(bool val) {
    userProfileLoading = val;
    update();
  }

  Future<void> getUserProfile() async {
    setUserProfileLoading(true);
    print("AppHelper.userId ${AppHelper.userId}");
    print("AppHelper.token ${AppHelper.token}");

    AppResponse response = await UserRepository().viewAccountReq(
        // make it dynamic
        queryParameters: {
          "Userid": AppHelper.userId,
          "languageId": LocalizationHelper.isArabic() ? 1 : 2
        });
    if (response.status) {
      UserProfile userProfile = UserProfile.fromJson(response.data);
      print("user profile => ${response.data}");
      AppHelper.setUserProfile(userProfile);
    }

    setUserProfileLoading(false);
  }

  List<Category> allCategories = [];
  List<Category> searchCategoriesList = [];
  List<Category> displayedCategoriesList = [];

  bool categoriesLoading = false;

  String _keySearch = '';

  void setKeySearch(String keySeacrh, {bool notifiy = false}) {
    _currentPageHome = 0;
    _currentPageSearch = 0;
    _noOfPagesHome = 1;
    _noOfPagesSearch = 1;
    searchCategoriesList = [];
    displayedCategoriesList = [];
    _keySearch = keySeacrh;
    getCategoriesList();
    // if (notifiy) update();
  }

  String get keySearch => _keySearch;

  Future<void> getCategoriesList({int? pageNo = 1, applyLoading = true}) async {
    if (applyLoading) _updateCategoriesLoading(true);
    if ((_keySearch.isEmpty && _currentPageHome <= _noOfPagesHome) ||
        (_keySearch.isNotEmpty && _currentPageSearch <= _noOfPagesSearch)) {
      AppResponse response = await CategoriesRepository().getCategories(
          {"categoryName": _keySearch, "pageNo": pageNo, "pageSize": 9});
      if (response.status) {
        CategoriesData categoriesData = CategoriesData.fromJson(response.data);
        if (_keySearch.isEmpty) {
          setCurrentPageHome(categoriesData.currentPage);
          setNoOfPagesHome(categoriesData.totalPages);
          setTotalCountHome(categoriesData.totalCount);
          for (var cat in categoriesData.categories) {
            if (allCategories
                    .firstWhereOrNull((element) => element.id == cat.id) ==
                null) {
              allCategories.add(cat);
            }
          }

          displayedCategoriesList = allCategories;
        } else {
          setCurrentPageSearch(categoriesData.currentPage);
          setNoOfPagesSearch(categoriesData.totalPages);
          setTotalCountSearch(categoriesData.totalCount);
          for (var cat in categoriesData.categories) {
            if (searchCategoriesList
                    .firstWhereOrNull((element) => element.id == cat.id) ==
                null) {
              searchCategoriesList.add(cat);
            }
          }
          // searchCategoriesList.addAll(categoriesData.categories);
          displayedCategoriesList = searchCategoriesList;
        }
        setShowMore();
      }
    }

    if (applyLoading) _updateCategoriesLoading(false);
  }

  void _updateCategoriesLoading(bool val) {
    categoriesLoading = val;
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

  int _totalCountSearch = 0;

  int get totalCountSearch => _totalCountSearch;
  void setTotalCountSearch(int value, {bool notifiy = true}) {
    _totalCountSearch = value;
    if (notifiy) update();
  }

  int _currentPageHome = 0;

  int get currentPageHome => _currentPageHome;
  void setCurrentPageHome(int value, {bool notifiy = true}) {
    _currentPageHome = value;
    if (notifiy) update();
  }

  int _noOfPagesHome = 1;

  int get noOfPagesHome => _noOfPagesHome;
  void setNoOfPagesHome(int value) {
    _noOfPagesHome = value;
    update();
  }

  int _totalCountHome = 0;

  int get totalCountHome => _totalCountHome;
  void setTotalCountHome(int value, {bool notifiy = true}) {
    _totalCountHome = value;
    if (notifiy) update();
  }

  Future<void> getMoreCategories() async {
    if (_keySearch.isEmpty) {
      await getCategoriesList(
          pageNo: _currentPageHome + 1, applyLoading: false);
    } else {
      await getCategoriesList(
          pageNo: _currentPageSearch + 1, applyLoading: false);
    }
  }

  bool _showMore = true;

  bool get showMore => _showMore;

  void setShowMore() {
    if ((_keySearch.isEmpty && currentPageHome == noOfPagesHome) ||
        (_keySearch.isNotEmpty && currentPageSearch == noOfPagesSearch) ||
        displayedCategoriesList.isEmpty) {
      _showMore = false;
    } else {
      _showMore = true;
    }
    update();
  }

  onLogout() {
    AuthService().logout();
  }
}
