import 'package:get/get.dart';
import '../constants/storage_constants.dart';
import 'storage_service.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService extends GetxService {
  final storageService = Get.find<StorageService>();

  RxBool isAuthUser = false.obs;
  // Rxn<UserModel> user = Rxn();

  bool get isAuth {
    String? accessToken = storageService.getData(StorageConstants.kToken);
    isAuthUser.value = accessToken?.isNotEmpty ?? false;
    return isAuthUser();
  }

  void setAccessToken(String token) {
    storageService.setData(StorageConstants.kToken, token);
  }

  void setRefreshToken(String refreshToken) {
    storageService.setData(StorageConstants.kRefreshToken, refreshToken);
  }

  void setFCMToken(String fcmToken) {
    storageService.setData(StorageConstants.fcmToken, fcmToken);
  }

  void setExpireAt(int expireAt) {
    DateTime willExpireAt = DateTime.now().add(Duration(seconds: expireAt));
    storageService.setData(StorageConstants.kExpireAt, willExpireAt.toString());
  }

  void removeAccessToken() {
    storageService.removeData(StorageConstants.kToken);
  }

  void setUserEmail(String email) {
    storageService.setData(StorageConstants.kUserEmail, email);
  }

  void setUserPhone(String phone) {
    storageService.setData(StorageConstants.kUserPhone, phone);
  }

  String? get getUserPhone {
    return storageService.getData(StorageConstants.kUserPhone);
  }

  String? get getUserEmail {
    return storageService.getData(StorageConstants.kUserEmail);
  }

  String? get accessToken {
    return storageService.getData(StorageConstants.kToken);
  }

  String? get refreshToken {
    return storageService.getData(StorageConstants.kRefreshToken);
  }

  String? get fcmToken {
    return storageService.getData(StorageConstants.fcmToken);
  }

  DateTime? get expireAt {
    String value = storageService.getData(StorageConstants.kExpireAt);
    return value.isNotEmpty ? DateTime.parse(value) : DateTime.now();
  }

  String? get userID {
    if (accessToken?.isNotEmpty ?? false) {
      // Decode
      Map<String, dynamic> payload = Jwt.parseJwt(accessToken!);
      String userId = payload['sub'];
      return userId;
    } else {
      return null;
    }
  }

  void logout() {
    storageService.removeAll();
    isAuthUser(false);
  }
}
