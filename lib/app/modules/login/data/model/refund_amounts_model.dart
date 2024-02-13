class RefundAmountsModel {
  final double? highestPriceOfCarRequested;
  final double? totalPaidAmount;
  final double? totalRefundAmount;

  RefundAmountsModel({
    this.highestPriceOfCarRequested = 0.0,
    this.totalPaidAmount = 0.0,
    this.totalRefundAmount = 0.0,
  });

  factory RefundAmountsModel.fromJson(Map<String, dynamic> json) =>
      RefundAmountsModel(
        highestPriceOfCarRequested:
            json["highestPriceOfCarRequested"]?.toDouble() ?? 0.0,
        totalPaidAmount: json["totalPaidAmount"]?.toDouble() ?? 0.0,
        totalRefundAmount: json["totalRefundAmount"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "highestPriceOfCarRequested": highestPriceOfCarRequested,
        "totalPaidAmount": totalPaidAmount,
        "totalRefundAmount": totalRefundAmount,
      };
}
