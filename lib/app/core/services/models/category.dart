class CategoriesResponse {
  CategoriesResponse({
    required this.isSuccess,
    required this.data,
    this.errors,
  });
  late final bool isSuccess;
  late final CategoriesData data;
  late final dynamic errors;

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = CategoriesData.fromJson(json['data']);
    errors = null;
  }
}

class CategoriesData {
  CategoriesData({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.categories,
  });
  late final int currentPage;
  late final int totalPages;
  late final int pageSize;
  late final int totalCount;
  late final List<Category> categories;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    categories =
        List.from(json['data']).map((e) => Category.fromJson(e)).toList();
  }
}

class Category {
  Category(
      {this.categoryIcon,
      this.imagePath,
      required this.categoryName,
      required this.id,
      this.categoryColor});
  late final int id;
  late final String categoryName;
  late final String? categoryIcon;
  late final String? imagePath;
  late final String? categoryColor;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    categoryIcon = json['categoryIcon'];
    imagePath = json['imagePath'];
    categoryColor =
        json['categoryColor'] != null ? json['categoryColor'] : "ff0000";
  }
}
