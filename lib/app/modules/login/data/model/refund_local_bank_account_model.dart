class RefundLocalBankAccountModel {
  String bankAccountNumber;
  String bankName;
  String branchName;
  int currencyType;

  RefundLocalBankAccountModel({
    this.bankAccountNumber = "",
    this.bankName = "",
    this.branchName = "",
    this.currencyType = 0,
  });

  factory RefundLocalBankAccountModel.fromJson(Map<String, dynamic>? json) =>
      (json != null)
          ? RefundLocalBankAccountModel(
              bankAccountNumber: json["bankAccountNumber"] ?? "",
              bankName: json["bankName"] ?? "",
              branchName: json["branchName"] ?? "",
              currencyType: json["currencyType"] ?? 0,
            )
          : RefundLocalBankAccountModel();

  Map<String, dynamic> toJson() => {
        "bankAccountNumber": bankAccountNumber,
        "bankName": bankName,
        "branchName": branchName,
        "currencyType": currencyType,
      };
}
