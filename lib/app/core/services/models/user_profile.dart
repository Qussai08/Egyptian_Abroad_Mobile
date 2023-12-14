class UserProfile {
  UserProfile({
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

  UserProfile.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    nationalId = json['nationalId'];
    jobCategoryID = json['jobCategoryID'];
    jobCategoryName = json['jobCategoryName'];
    jobTitle = json['jobTitle'];
    egyptionMobile = json['egyptionMobile'];
    foreignMobile = json['foreignMobile'];
    messagingAddress = json['messagingAddress'];
    passportNo = json['passportNo'];
    residencyCountryId = json['residencyCountryId'];
    residencyCountryName = json['residencyCountryName'];
    residencyTypeId = json['residencyTypeId'];
    residencyTypeName = json['residencyTypeName'];
    residencyNo = json['residencyNo'];
    foreignPassportNo = json['foreignPassportNo'];
    residencyAddress = json['residencyAddress'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['name'] = name;
    _data['email'] = email;
    _data['nationalId'] = nationalId;
    _data['jobCategoryID'] = jobCategoryID;
    _data['jobCategoryName'] = jobCategoryName;
    _data['jobTitle'] = jobTitle;
    _data['egyptionMobile'] = egyptionMobile;
    _data['foreignMobile'] = foreignMobile;
    _data['messagingAddress'] = messagingAddress;
    _data['passportNo'] = passportNo;
    _data['residencyCountryId'] = residencyCountryId;
    _data['residencyCountryName'] = residencyCountryName;
    _data['residencyTypeId'] = residencyTypeId;
    _data['residencyTypeName'] = residencyTypeName;
    _data['residencyNo'] = residencyNo;
    _data['foreignPassportNo'] = foreignPassportNo;
    _data['residencyAddress'] = residencyAddress;

    return _data;
  }
}
