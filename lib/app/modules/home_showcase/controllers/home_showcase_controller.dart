import 'package:egyptians_abroad/app/core/custom_widgets/custom_taost.dart';
import 'package:egyptians_abroad/app/core/language/app_string.dart';
import 'package:egyptians_abroad/app/core/services/models/service.dart';
import 'package:egyptians_abroad/app/modules/home_showcase/data/providers/favorites_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../core/helper/error_helper.dart';
import '../../../core/helper/localization_helper.dart';
import '../../../core/services/app_response.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/models/category.dart';
import '../../../core/services/models/user_profile.dart';
import '../../../core/services/repositories/categories_repository.dart';
import '../../../core/services/repositories/user_repository.dart';
import '../../../core/services/storage_service.dart';
import '../../registration/controllers/registration_controller.dart';

class HomeShowcaseController extends GetxController {
  String keySearch = '';
  final TextEditingController searchController = TextEditingController();
  List<ServiceItem> favoritesList = [];
  // Auth service
  final favoritesListProvider = Get.find<FavoritesListProvider>();

  // Auth service
  final authService = Get.find<AuthService>();
  final RegistrationController registrationController =
      Get.put(RegistrationController());
  bool isLoading = true;

  @override
  void onInit() async {
    super.onInit();
    // isLoading = true;
    await getUserProfile();
    await getCategoriesList();
    await fetchAllCategoriesFavUse();
    await updateFavoritesList(userId: authService.userID!);

    isLoading = false;
    // TODO: for testing only to be removed
    // authService.showcaseViewed = true;
  }

  bool userProfileLoading = false;
  setUserProfileLoading(bool val) {
    userProfileLoading = val;
    update();
  }

  Future<void> getUserProfile() async {
    setUserProfileLoading(true);

    // AppResponse response =
    await UserRepository().viewAccountReq(queryParameters: {
      "Userid": authService.userID,
      "languageId": LocalizationHelper.isArabic() ? 1 : 2
    }).then((value) {
      if (value.status) {
        print("value.data['data'] ${value.data['data']}");
        UserProfileModel userProfile =
            UserProfileModel.fromJson(value.data['data']);
        // AppHelper.setUserProfile(userProfile);
        authService.setUserProfile(userProfile);
        setUserProfileLoading(false);
      } else {
        authService.setUserProfile(UserProfileModel.empty());
        handleError(value.errorCode ?? '-1');
        setUserProfileLoading(false);
      }
    }, onError: (error) {
      print('UserProfile Error: $error');
      setUserProfileLoading(false);
    });
    print("userProfileLoading: $userProfileLoading");
    // if (response.status) {
    //   UserProfileModel userProfile =
    //       UserProfileModel.fromJson(response.data['data']);
    //   // AppHelper.setUserProfile(userProfile);
    //   authService.setUserProfile(userProfile);
    // }

    // setUserProfileLoading(false);
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

  Future<void> getCategoriesList(
      {int? pageNo = 1, applyLoading = true, bool showAll = false}) async {
    if (applyLoading) _updateCategoriesLoading(true);
    try {
      if ((_keySearch.isEmpty && _currentPageHome <= _noOfPagesHome) ||
          (_keySearch.isNotEmpty && _currentPageSearch <= _noOfPagesSearch)) {
        AppResponse response = await CategoriesRepository().getCategories({
          "categoryName": _keySearch,
          "pageNo": 1,
          "pageSize": showAll ? 5000 : 6
        });
        if (response.status) {
          CategoriesData categoriesData =
              CategoriesData.fromJson(response.data);
          if (_keySearch.isEmpty) {
            setCurrentPageHome(categoriesData.currentPage);
            setNoOfPagesHome(categoriesData.totalPages);
            setTotalCountHome(categoriesData.totalCount);
            if (showAll) {
              displayedCategoriesList = categoriesData.categories;
            } else {
              for (var cat in categoriesData.categories) {
                if (allCategories
                        .firstWhereOrNull((element) => element.id == cat.id) ==
                    null) {
                  allCategories.add(cat);
                }
              }

              displayedCategoriesList = allCategories;
            }
          } else {
            setCurrentPageSearch(categoriesData.currentPage);
            setNoOfPagesSearch(categoriesData.totalPages);
            setTotalCountSearch(categoriesData.totalCount);
            if (showAll) {
              displayedCategoriesList = categoriesData.categories;
            } else {
              for (var cat in categoriesData.categories) {
                if (searchCategoriesList
                        .firstWhereOrNull((element) => element.id == cat.id) ==
                    null) {
                  searchCategoriesList.add(cat);
                }
              }
              displayedCategoriesList = searchCategoriesList;
            }
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

    if (applyLoading) {
      Future.delayed(Duration(seconds: 2), () {
        _updateCategoriesLoading(false);
      });
    }
    print("categoriesLoading: $categoriesLoading");
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
          pageNo: _currentPageHome + 1, applyLoading: false, showAll: true);
    } else {
      await getCategoriesList(
          pageNo: _currentPageSearch + 1, applyLoading: false, showAll: true);
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

  // Show Case Handler
  final GlobalKey one = GlobalKey();
  final GlobalKey two = GlobalKey();
  final GlobalKey three = GlobalKey();

  late BuildContext _homeContext;
  final scrollController = ScrollController();

  // start showcase
  Future<void> startShowCase(BuildContext context) async {
    var isFirstTime = await StorageService().getData("first_time");
    if (authService.showcaseViewed ||
        isFirstTime == true ||
        isFirstTime == null) {
      _homeContext = context;
      StorageService().setData("first_time", false);
      ambiguate(WidgetsBinding.instance)?.addPostFrameCallback(
        (_) => ShowCaseWidget.of(_homeContext).startShowCase([one, two, three]),
      );
    }
  }

  // next showcase
  Future<void> nextShowCase({bool? isScroll = false}) async {
    if (isScroll ?? false) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 5),
        curve: Curves.easeOut,
      );
      // wait 500 milliseconds
      await Future.delayed(const Duration(milliseconds: 10));
    }

    ShowCaseWidget.of(_homeContext).next();
    authService.showcaseViewed = false;
  }

  // dismiss showcase
  void dismissShowCase(BuildContext context) {
    ShowCaseWidget.of(_homeContext).dismiss();
    authService.showcaseViewed = false;
  }

  Future<void> addToFavorites(
      {required String userId,
      required String serviceId,
      required ServiceItem service}) async {
    await favoritesListProvider.addToFavorites(userId, serviceId).then((value) {
      if (value.isSuccess) {
        print("Favorite Value ${value.body}");

        favoritesList.add(service);
        loadFavoriteCategory(service);
      }
    }, onError: (error) {
      print("Add to Favorites Error");
    });

    update();
  }

  Future<void> removeFromFavorites(
      {required String userId,
      required String serviceId,
      required ServiceItem service}) async {
    await favoritesListProvider.removeFromFavorites(userId, serviceId).then(
        (value) {
      favoritesList.remove(service);
      // favoritesList.removeWhere(
      //   (element) => element.serviceId == int.parse(serviceId),
      // );
    }, onError: (error) {});

    update();
  }

  List<Category> favoriteCategories = [];
  List<Category> allCategoriesFavUse = [];
  bool favoritesIsLoading = true;
  Future<void> updateFavoritesList({required String userId}) async {
    List<ServiceItem> temp = [];
    await favoritesListProvider.getFavoritesList(userId).then(
      (value) async {
        if (value.isSuccess) {
          Iterable list = value.body;
          temp = list.map((e) => ServiceItem.fromJson(e)).toList();

          for (ServiceItem item in temp) {
            if (item.isFixedFavorite) {
              favoritesList.add(item);
            }
          }
          temp.removeWhere((element) => element.isFixedFavorite);
          favoritesList.addAll([...temp]);
          for (ServiceItem item in favoritesList) {
            loadFavoriteCategory(item);
          }
        }
      },
      onError: (error) {
        print('FavoritesList Error: $error');
        update();
      },
    );
    favoritesIsLoading = false;
    update();
  }

  fetchAllCategoriesFavUse() async {
    AppResponse response = await CategoriesRepository()
        .getCategories({"categoryName": "", "pageNo": 1, "pageSize": 5000});
    if (response.status) {
      CategoriesData categoriesData = CategoriesData.fromJson(response.data);
      allCategoriesFavUse = categoriesData.categories;
    }
  }

  loadFavoriteCategory(ServiceItem item) {
    for (Category cat in allCategoriesFavUse) {
      if (cat.id == item.categoryId && !favoriteCategories.contains(cat)) {
        favoriteCategories.add(cat);
        print(
            "cat.id ${cat.id} has been added to favoriteCategories list to use with service item ${item.serviceName}");
        break;
      }
    }
  }

  // loadFavoritesCategories() async {
  //   favoriteCategories = [];
  //   print(favoritesList.length);

  //   print("allCategoriesFavUse.length ${allCategoriesFavUse.length}");

  //   if (favoritesList.isNotEmpty) {
  //     await Future.forEach<ServiceItem>(favoritesList, (item) {
  //       Category favCat = allCategoriesFavUse
  //           .firstWhere((element) => element.id == item.categoryId);
  //       favoriteCategories.add(favCat);
  //     });
  //   }
  // }

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
