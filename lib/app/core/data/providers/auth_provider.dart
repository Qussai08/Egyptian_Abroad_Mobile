// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:get/get.dart';
import '../../constants/globals.dart';
import '../../services/api_service.dart';
import '../models/api_response.dart';

class AuthProvider extends ApiService {
  // // =================== Register ===================
  // Future<ApiResponse<AuthResModel>> register(String email, String otpCode,
  //     String password, String countryCode, String phoneNumber) async {
  //   final Response response = await post(
  //     ApiConstants.registerPath,
  //     {
  //       'email': email.trim().toLowerCase(),
  //       'verificationCode': otpCode.trim(),
  //       'password': password.trim(),
  //       "phoneNumber": phoneNumber,
  //       "countryCode": countryCode,
  //     },
  //   );

  //   return ApiResponse.fromResponse(
  //       response, (json) => AuthResModel.fromJson(json));
  // }

  // // =================== Login ===================
  // Future<ApiResponse<AuthResModel>> login(
  //     {required String email, required String password}) async {
  //   final Response response = await post(ApiConstants.loginPath, {
  //     'email': email.trim().toLowerCase(),
  //     'password': password.trim(),
  //   });
  //   return ApiResponse.fromResponse(
  //       response, (json) => AuthResModel.fromJson(json));
  // }

  // // =================== Forget ===================
  // Future<ApiResponse<bool>> forget(
  //     {required String email,
  //     required String countryCode,
  //     required String phoneNumber}) async {
  //   final Response response = await post(
  //     ApiConstants.forgetPath,
  //     {
  //       'email': email.trim().toLowerCase(),
  //       "phone": phoneNumber,
  //       "countryCode": countryCode,
  //     },
  //   );

  //   return ApiResponse.fromResponse(response, (json) => true);
  // }

  // // =================== Renew Password ===================
  // Future<ApiResponse<bool>> renewPassword(
  //     {required String email,
  //     required String password,
  //     required String code,
  //     required String countryCode,
  //     required String phoneNumber}) async {
  //   final Response response = await post(
  //     ApiConstants.renewPath,
  //     {
  //       "email": email.trim().toLowerCase(),
  //       "password": password.trim(),
  //       "confirmPassword": password,
  //       "verificationCode": code,
  //       "phone": phoneNumber,
  //       "countryCode": countryCode,
  //     },
  //   );

  //   return ApiResponse.fromResponse(response, (json) => true);
  // }

  // // =================== Create OTP ===================
  // Future<ApiResponse<int>> sendOtp(
  //     String email, String countryCode, String phoneNumber) async {
  //   final Response response = await post(
  //     ApiConstants.sendOtpPath,
  //     {
  //       'email': email.trim().toLowerCase(),
  //       "phone": phoneNumber,
  //       "countryCode": countryCode,
  //     },
  //   );

  //   return ApiResponse.fromResponse(response, (json) => json);
  // }

  // // =================== Verify OTP ===================
  // Future<ApiResponse<bool>> verifyOtp(String email, String otpCode,
  //     String countryCode, String phoneNumber) async {
  //   final Response response = await post(
  //     ApiConstants.verifyOtpPath,
  //     {
  //       'email': email.trim().toLowerCase(),
  //       'code': otpCode.trim(),
  //       "phone": phoneNumber,
  //       "countryCode": countryCode,
  //     },
  //   );

  //   return ApiResponse.fromResponse(response, (json) => json);
  // }

  // // =================== Forget Password Verification OTP ===================
  // Future<ApiResponse<int>> forgetPasswordVerification(
  //     String email, String countryCode, String phoneNumber) async {
  //   final Response response = await post(
  //     ApiConstants.forgetPasswordVerificationPath,
  //     {
  //       'email': email.trim().toLowerCase(),
  //       "phone": phoneNumber,
  //       "countryCode": countryCode,
  //     },
  //   );

  //   return ApiResponse.fromResponse(response, (json) => json);
  // }

  // // =================== Get Profile Data ===================
  // Future<ApiResponse<UserModel>> getProfile() async {
  //   final Response response = await get(
  //     ApiConstants.getProfilePath,
  //   );

  //   return ApiResponse.fromResponse(
  //       response, (json) => UserModel.fromJson(json));
  // }

  // // =================== Create Profile ===================
  // Future<ApiResponse<bool>> createProfile(PersonalData profileData) async {
  //   final Response response =
  //       await post(ApiConstants.createProfilePath, profileData.toMap());
  //   return ApiResponse.fromResponse(response, (json) => json);
  // }

  // =================== Register FCM Token ===================
  Future<ApiResponse<bool>> registerFCMToken(
      String fcmToken, String userId) async {
    final Response response = await post(Constants.registerFCMTokenPath,
        {"fcmToken": fcmToken, "userId": userId});
    print("registerFCMToken post -> ${response.body}");
    return ApiResponse.fromResponse(response, (json) => json);
  }

  // // =================== Delete FCM Token ===================
  // Future<ApiResponse<bool>> deleteFCMToken(String fcmToken) async {
  //   final Response response =
  //       await post(ApiConstants.deleteFCMTokenPath, {"fcmToken": fcmToken});

  //   return ApiResponse.fromResponse(response, (json) => json);
  // }

  // // =================== Get Update Section Details ===================
  // Future<ApiResponse<List<UpdateSectionModel>>>
  //     getUpdateSectionDetails() async {
  //   final Response response = await get(
  //     ApiConstants.getUpdateSectionDetails,
  //   );
  //   return ApiResponse.fromResponseNoException(
  //       response, (json) => UpdateSectionModel.fromListJson(json));
  // }
}
