import 'package:get/get.dart';

class ServicesResponse {
  ServicesResponse({
    required this.isSuccess,
    required this.data,
    this.errors,
  });
  late final bool isSuccess;
  late final ServicesData data;
  late final dynamic errors;

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = ServicesData.fromJson(json['data']);
    errors = null;
  }
}

class ServicesData {
  ServicesData({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.services,
  });
  late final int currentPage;
  late final int totalPages;
  late final int pageSize;
  late final int totalCount;
  late final List<ServiceItem> services;

  ServicesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    services =
        List.from(json['data']).map((e) => ServiceItem.fromJson(e)).toList();
  }
}

class ServiceItem {
  ServiceItem({
    required this.serviceId,
    this.servicesIcon,
    required this.serviceName,
    required this.categoryId,
    required this.isFixedFavorite,
  });
  late final int serviceId;
  late final String? servicesIcon;
  late final String serviceName;
  late final int categoryId;
  bool isFixedFavorite = false;
  RxBool isMyFavorite = false.obs;

  ServiceItem.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    servicesIcon = json['servicesIcon'];
    serviceName = json['serviceName'];
    categoryId = json['categoryId'];
    isFixedFavorite = json['isFixedFavorite'] ?? false;
    isMyFavorite.value = json['isMyFavorite'] ?? false;
  }
}
