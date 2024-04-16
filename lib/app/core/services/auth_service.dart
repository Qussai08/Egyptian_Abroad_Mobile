import 'package:get/get.dart';
import '../constants/globals.dart';
import '../constants/storage_constants.dart';
import '../helper/notification_helper.dart';
import 'models/user_profile.dart';
import 'storage_service.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService extends GetxService {
  final storageService = Get.find<StorageService>();
  var notificationHelper = NotificationHelper();

  RxBool isAuthUser = false.obs;

  bool _showcaseViewed = false;

  set showcaseViewed(bool value) {
    _showcaseViewed = value;
  }

  bool get showcaseViewed {
    return _showcaseViewed;
  }

  Future<bool> get isAuth async {
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
    storageService.setData(StorageConstants.kFcmToken, fcmToken);
  }

  void setExpireAt(int expireAt) {
    DateTime willExpireAt = DateTime.now().add(Duration(seconds: expireAt));
    storageService.setData(StorageConstants.kExpireAt, willExpireAt.toString());
  }

  // set User Profile
  void setUserProfile(UserProfileModel profile) {
    storageService.setData(StorageConstants.kUserProfile, profile);
  }

  UserProfileModel get getUserProfile {
    return storageService.getData(StorageConstants.kUserProfile) ??
        UserProfileModel.empty();
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
    // print(storageService.getData(StorageConstants.kToken));
    return storageService.getData(StorageConstants.kToken);
  }

  String? get refreshToken {
    return storageService.getData(StorageConstants.kRefreshToken);
  }

  String? get fcmToken {
    return storageService.getData(StorageConstants.kFcmToken);
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

  Future<void> logout() async {
    storageService.removeAll();
    await notificationHelper.unSubscribeFromTopic(Constants.fcmTopic);
    await notificationHelper.deleteFCMToken();

    // Remove user from secure storage
    // await SecureStorageHelper.localRemove('user');

    StorageService().setData("first_time", false);
    isAuthUser(false);
  }
}
