// import 'package:egyptians_abroad/app/core/services/auth_service.dart';
// import 'package:egyptians_abroad/app/core/services/models/service.dart';
// import 'package:egyptians_abroad/app/modules/home/data/providers/favorites_list_provider.dart';
// import 'package:get/get.dart';

// class FavoritesController extends GetxController {
//   final favoritesListProvider = Get.find<FavoritesListProvider>();

//   List<ServiceItem> favoritesList = [
//     ServiceItem(
//         serviceId: 1,
//         serviceName: 'Service',
//         categoryId: 1,
//         isFavorite: true.obs),
//     ServiceItem(
//         serviceId: 2,
//         serviceName: 'Service',
//         categoryId: 1,
//         isFavorite: false.obs),
//     ServiceItem(
//         serviceId: 3,
//         serviceName: 'Service',
//         categoryId: 1,
//         isFavorite: true.obs),
//     ServiceItem(
//         serviceId: 4,
//         serviceName: 'Service',
//         categoryId: 1,
//         isFavorite: false.obs),
//     ServiceItem(
//         serviceId: 5,
//         serviceName: 'Service',
//         categoryId: 1,
//         isFavorite: true.obs),
//     ServiceItem(
//         serviceId: 6,
//         serviceName: 'Service',
//         categoryId: 1,
//         isFavorite: false.obs),
//   ];

//   @override
//   onInit() {
//     super.onInit();
//     updateFavoritesList(userId: AuthService().getUserProfile!.userId!);
//   }

//   Future<void> addToFavorites(
//       {required String userId, required String serviceId}) async {
//     favoritesListProvider
//         .addToFavorites(userId, serviceId)
//         .then((value) {}, onError: (error) {});
//   }

//   Future<void> removeFromFavorites(
//       {required String userId, required String serviceId}) async {
//     favoritesListProvider
//         .removeFromFavorites(userId, serviceId)
//         .then((value) {}, onError: (error) {});
//   }

//   Future<void> updateFavoritesList({required String userId}) async {
//     favoritesListProvider.getFavoritesList(userId).then((value) {
//       favoritesList = value.body['data'];
//     }, onError: (error) {});
//   }
// }
