import 'package:egyptians_abroad/app/core/helper/app_helper.dart';

class ServiceContent {
  ServiceContent(
      {this.serviceId,
      this.servicesIcon,
      this.androidLink,
      this.iosLink,
      this.servicesLink,
      this.serviceContentId,
      this.servicesType,
      this.serviceName,
      this.serviceDescription,
      this.serviceContentLink,
      this.serviceContentIcon,
      this.servicesContentTitle,
      this.servicesContentSummary,
      this.nameLanguageId,
      this.descriptionLanguageId,
      this.titleLanguageId,
      this.summaryLanguageId,
      this.appLink});
  late int? serviceId;
  late String? servicesIcon;
  late String? androidLink;
  late String? iosLink;
  late String? servicesLink;
  late int? serviceContentId;
  late ServiceType? servicesType;
  late String? serviceName;
  late String? serviceDescription;
  late String? serviceContentLink;
  late String? serviceContentIcon;
  late String? servicesContentTitle;
  late String? servicesContentSummary;
  late int? nameLanguageId;
  late int? descriptionLanguageId;
  late int? titleLanguageId;
  late int? summaryLanguageId;
  late String? appLink;

  ServiceContent.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    servicesIcon = json['servicesIcon'];
    androidLink = json['androidLink'];
    iosLink = json['iosLink'];
    servicesLink = json['servicesLink'];
    serviceContentId = json['serviceContentId'];
    servicesType = AppHelper.getServiceType(json['servicesType'].toString());
    serviceName = json['serviceName'];
    serviceDescription = json['serviceDescription'];
    serviceContentLink = json['serviceContentLink'];
    serviceContentIcon = json['serviceContentIcon'];
    servicesContentTitle = json['servicesContentTitle'];
    servicesContentSummary = json['servicesContentSummary'];
    nameLanguageId = json['nameLanguageId'];
    descriptionLanguageId = json['descriptionLanguageId'];
    titleLanguageId = json['titleLanguageId'];
    summaryLanguageId = json['summaryLanguageId'];
    appLink = json['appLink'];
  }
}
