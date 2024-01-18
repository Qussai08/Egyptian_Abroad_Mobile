import 'package:get/get.dart';

class Country {
  Country(
      {required this.id,
      required this.country,
      required this.flag,
      this.isSelected = false});
  late final int id;
  late final String country;
  late final String flag;
  late bool isSelected;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    flag = json['flag'] ??
        "https://cdn.iconscout.com/icon/premium/png-256-thumb/no-image-2840213-2359555.png";
    isSelected = true;
  }
}
