class RefundStatusModel {
  final int refundStatus;
  final int bankAccountType;
  final int refundOTPTimer;
  final int refundType;
  final int? refundSubType;
  final String? relativeRequestId;

  RefundStatusModel({
    this.refundStatus =
        -1, // NotExist = -1, Pending = 0, Approved = 1,     Rejected = 2,
    this.bankAccountType = -1, // 0: LOCAL, 1: International
    this.refundOTPTimer = 2,
    this.refundType =
        0, // 0: null  1: Option 1(Returning), 2: Option 2(SavingCert), 3: Option 3(OtherUsing)
    this.refundSubType =
        -1, //-1: if(refundType == 1, 2)  0: null  1: ExchangeCarByMoney, 2: ExchangeCarForRelative
    this.relativeRequestId = ' ',
  });

  factory RefundStatusModel.fromJson(Map<String, dynamic> json) =>
      RefundStatusModel(
        // refundStatus will be 0 or -1 otherwise it will be -1

        refundStatus: json["refundStatus"] == 0 || json["refundStatus"] == -1
            ? json["refundStatus"]
            : 0,

        bankAccountType: json["bankAccountType"] ?? -1,
        refundOTPTimer: json["refundOTPTimer"] ?? 2,
        refundType: json["refundType"] ?? 0,
        refundSubType: json["refundSubType"] ?? -1,
        relativeRequestId: json["relativeRequestId"] ?? ' ',
      );
}
