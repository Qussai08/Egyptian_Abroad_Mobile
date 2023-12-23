class UserProfileModel {
  UserProfileModel({
    this.userId,
    this.name,
    this.email,
    this.nationalId,
    this.jobCategoryID,
    this.jobCategoryName,
    this.jobTitle,
    this.egyptionMobile,
    this.foreignMobile,
    this.messagingAddress,
    this.passportNo,
    this.residencyCountryId,
    this.residencyCountryName,
    this.residencyTypeId,
    this.residencyTypeName,
    this.residencyNo,
    this.foreignPassportNo,
    this.residencyAddress,
    this.shortName,
    this.avatarId,
  });
  late final String? userId;
  late final String? name;
  late final String? email;
  late final String? nationalId;
  late final int? jobCategoryID;
  late final String? jobCategoryName;
  late final String? jobTitle;
  late final String? egyptionMobile;
  late final String? foreignMobile;
  late final String? messagingAddress;
  late final String? passportNo;
  late final int? residencyCountryId;
  late final String? residencyCountryName;
  late final int? residencyTypeId;
  late final String? residencyTypeName;
  late final String? residencyNo;
  late final String? foreignPassportNo;
  late final String? residencyAddress;
  late final int? avatarId;
  String? shortName;

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    nationalId = json['nationalId'] ?? '';
    jobCategoryID = json['jobCategoryID'] ?? 0;
    jobCategoryName = json['jobCategoryName'] ?? '';
    jobTitle = json['jobTitle'] ?? '';
    egyptionMobile = json['egyptionMobile'] ?? '';
    foreignMobile = json['foreignMobile'] ?? '';
    messagingAddress = json['messagingAddress'] ?? '';
    passportNo = json['passportNo'] ?? '';
    residencyCountryId = json['residencyCountryId'] ?? 0;
    residencyCountryName = json['residencyCountryName'] ?? '';
    residencyTypeId = json['residencyTypeId'] ?? 0;
    residencyTypeName = json['residencyTypeName'] ?? '';
    residencyNo = json['residencyNo'] ?? '';
    foreignPassportNo = json['foreignPassportNo'] ?? '';
    residencyAddress = json['residencyAddress'] ?? '';
    avatarId = json['avatarId'] ?? 9;
    shortName = (json['name'] != null && json['name'] != '')
        ? name?.split(' ').first ?? ''
        : '';
  }

  //

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['nationalId'] = nationalId;
    data['jobCategoryID'] = jobCategoryID;
    data['jobCategoryName'] = jobCategoryName;
    data['jobTitle'] = jobTitle;
    data['egyptionMobile'] = egyptionMobile;
    data['foreignMobile'] = foreignMobile;
    data['messagingAddress'] = messagingAddress;
    data['passportNo'] = passportNo;
    data['residencyCountryId'] = residencyCountryId;
    data['residencyCountryName'] = residencyCountryName;
    data['residencyTypeId'] = residencyTypeId;
    data['residencyTypeName'] = residencyTypeName;
    data['residencyNo'] = residencyNo;
    data['foreignPassportNo'] = foreignPassportNo;
    data['avatarId'] = avatarId;
    data['residencyAddress'] = residencyAddress;

    return data;
  }
}
