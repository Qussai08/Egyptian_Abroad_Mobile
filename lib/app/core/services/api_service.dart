import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../constants/globals.dart';
import '../helper/localization_helper.dart';
import 'auth_service.dart';

class ApiService extends GetConnect {
  final authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    super.allowAutoSignedCert = true;
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = const Duration(seconds: 50);
    httpClient.maxAuthRetries = 3;
    httpClient.addRequestModifier((Request request) async {
      if (await isNetworkAvailable()) {
        // add lang id in header
        request.headers['languageId'] = request.headers['languageId'] =
            '${LocalizationHelper.isArabic() ? 1 : 2}';
        if (!request.url.path.contains('AccessToken')) {
          if (await authService.isAuth) {
            if (isTokenExpired()) {
              // await getRefreshToken(
              //         refreshToken: authService.refreshToken ?? '')
              //     .then((result) {
              //   if (result.isSuccess) {
              //     authService.setAccessToken(result.body?.accessToken ?? '');
              //     authService.setRefreshToken(result.body?.refreshToken ?? '');
              //     authService.setExpireAt(result.body?.expiresIn ?? 0);

              //     request.headers['Authorization'] =
              //         'Bearer ${result.body?.accessToken}';
              //   } else {
              //     authService.logout();
              //     Get.offAllNamed(Routes.SPLASH);
              //   }
              // }, onError: (error) {
              //   authService.logout();
              //   Get.offAllNamed(Routes.SPLASH);
              // });
            } else {
              request.headers['Authorization'] =
                  'Bearer ${authService.accessToken}';
            }
          }
        }
      } else {
        throw -8;
      }

      return request;
    });

    // get Refresh Token
    // httpClient.addResponseModifier((request, response) async {
    //   if (response.statusCode == 401) {
    //     if (request.url.path.contains('AccessToken')) {
    //       authService.logout();
    //       Get.offAllNamed(Routes.SPLASH);
    //     } else {
    //       if (authService.isAuth) {
    //         await getRefreshToken(refreshToken: authService.refreshToken).then(
    //             (result) {
    //           if (result.isSuccess) {
    //             authService.setAccessToken(result.body?.accessToken ?? '');
    //             authService.setRefreshToken(result.body?.refreshToken ?? '');
    //             authService.setExpireAt(result.body?.expiresIn ?? 0);
    //           } else {
    //             authService.logout();
    //             Get.offAllNamed(Routes.SPLASH);
    //           }
    //         }, onError: (error) {
    //           authService.logout();
    //           Get.offAllNamed(Routes.SPLASH);
    //         });
    //       }
    //     }
    //   }
    //   return response;
    // });
  }

  // =================== is token expires ===================
  bool isTokenExpired() {
    return false;
    // var tempA = authService.expireAt;
    // var tempB = DateTime.now();
    // bool isTokenExpired = tempA.isBefore(tempB);
    // return isTokenExpired;
  }

  // =================== refresh token ===================

  // Future<ApiResponse<AuthResModel>> getRefreshToken(
  //     {required String refreshToken}) async {
  //   authService.removeAccessToken();
  //   final Response response = await post(
  //     Constants.refreshTokenPath,
  //     {
  //       'refreshToken': refreshToken,
  //     },
  //   );
  //   return ApiResponse.fromResponseNoException(
  //       response, (json) => AuthResModel.fromJson(json));
  // }

  Future<bool> isNetworkAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
