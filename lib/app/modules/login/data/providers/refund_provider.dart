// import 'dart:io';

// import 'package:get/get.dart';
// import '../../../../shared/constants/api_constants.dart';
// import '../../../../shared/data/models/api_response.dart';
// import '../../../../shared/services/api_service.dart';
// import '../model/refund_amounts_model.dart';
// import '../model/refund_local_bank_account_model.dart';
// import '../model/refund_status_model.dart';

// class RefundProvider extends ApiService {
//   // =================== Get Refund Status ===================
//   Future<ApiResponse<RefundStatusModel>> getRefundStatus() async {
//     final Response response = await get(ApiConstants.getRefundStatus);
//     return ApiResponse.fromResponse(
//         response, (json) => RefundStatusModel.fromJson(json));
//   }

//   // =================== Get Refund Amounts ===================
//   Future<ApiResponse<RefundAmountsModel>> getRefundAmounts() async {
//     final Response response = await get(ApiConstants.getRefundAmounts);
//     return ApiResponse.fromResponse(
//         response, (json) => RefundAmountsModel.fromJson(json));
//   }

//   // =================== Post Refund Local Bank Account Info ===================
//   Future<ApiResponse<RefundLocalBankAccountModel>>
//       postRefundLocalBankAccountInfo(
//           RefundLocalBankAccountModel refundLocalBankAccountInfo) async {
//     final Response response = await post(
//         ApiConstants.postRefundLocalBankAccountInfo,
//         refundLocalBankAccountInfo.toJson());
//     return ApiResponse.fromResponse(
//         response, (json) => RefundLocalBankAccountModel.fromJson(json));
//   }

//   // =================== Get Refund Local Bank Account Info ===================
//   Future<ApiResponse<RefundLocalBankAccountModel?>>
//       getRefundLocalBankAccountInfo() async {
//     final Response response =
//         await get(ApiConstants.getRefundLocalBankAccountInfo);
//     return ApiResponse.fromResponse(
//         response, (json) => RefundLocalBankAccountModel.fromJson(json));
//   }

//   // =================== Post Refund Request ===================
//   // Future<ApiResponse<bool>> postRefundRequest(int bankAccountType) async {
//   //   // "bankAccountType":  // 0: LOCAL, 1: International
//   //   final Response response = await post(
//   //     ApiConstants.postRefundRequest,
//   //     {'bankAccountType': bankAccountType},
//   //   );
//   //   return ApiResponse.fromResponse(response, (json) => json);
//   // }

//   // =================== Request Refund Verification OTP ===================
//   Future<ApiResponse<bool>> requestRefundVerificationCode() async {
//     final Response response =
//         await post(ApiConstants.requestRefundVerificationCode, {});

//     return ApiResponse.fromResponse(response, (json) => json);
//   }

//   // =================== Verify Refund Verification OTP ===================
//   Future<ApiResponse<bool>> verifyRefundVerificationCode({
//     required String otp,
//     required int refundType,
//     required int refundSubType,
//     required int bankAccountType,
//     required int refundRelativeType,
//     required String relativeRequestId,

//     // file
//     File? documentPath,
//   }) async {
//     final FormData formData = FormData({
//       if (documentPath != null && documentPath.path.isNotEmpty)
//         'refundRelativeDocument': MultipartFile(documentPath,
//             filename: documentPath.path.split('/').last),
//     });
//     final Response response =
//         await post(ApiConstants.verifyRefundVerificationCode, formData, query: {
//       'code': otp,
//       "refundType": refundType
//           .toString(), // 0: null  1: Option 1(Returning), 2: Option 2(SavingCert), 3: Option 3(OtherUsing)
//       if (refundType == 3)
//         "refundSubType": refundSubType
//             .toString(), //-1: if(refundType == 1, 2)  0: null  1: ExchangeCarByMoney, 2: ExchangeCarForRelative
//       if (refundType == 1)
//         "bankAccountType":
//             bankAccountType.toString(), // 0: LOCAL, 1: International
//       if (refundType == 3 && refundSubType == 2)
//         "refundRelativeType": refundRelativeType.toString(),
//       if (refundType == 3 && refundSubType == 2)
//         "relativeRequestId":
//             relativeRequestId.isNotEmpty ? relativeRequestId.toString() : ' ',
//     });

//     return ApiResponse.fromResponse(response, (json) => json);
//   }

//   // =================== Check Refund Relative Request ===================
//   Future<ApiResponse<bool>> checkRefundRelativeRequest(
//       {required String requestId}) async {
//     final Response response =
//         await get(ApiConstants.checkRefundRelativeRequest, query: {
//       'requestId': requestId,
//     });
//     return ApiResponse.fromResponse(response, (json) => json);
//   }
// }
