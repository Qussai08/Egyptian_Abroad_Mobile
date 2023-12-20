import 'package:egyptians_abroad/app/core/data/models/api_response.dart';
import 'package:egyptians_abroad/app/core/services/api_service.dart';
import 'package:get/get.dart';

class FavoritesListProvider extends ApiService {
  Future<ApiResponse<dynamic>> addToFavorites(
      String userId, String serviceId) async {
    final Response response = await post('AddInFavorite', {
      'userId': userId,
      'serviceId': serviceId,
    });
    return ApiResponse.fromResponse(response, (json) => json);
  }

  Future<ApiResponse<dynamic>> removeFromFavorites(
      String userId, String serviceId) async {
    final Response response = await post('RemoveFromFavorite', {
      'userId': userId,
      'serviceId': serviceId,
    });
    return ApiResponse.fromResponse(response, (json) => json);
  }

  Future<ApiResponse<dynamic>> getFavoritesList(String userId) async {
    final Response response = await post('FavoriteList', {'userId': userId});

    return ApiResponse.fromResponse(response, (json) => json);
  }
}
