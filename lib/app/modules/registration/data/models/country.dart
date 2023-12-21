class Country {
  Country({required this.id, required this.country, required this.flag});
  late final int id;
  late final String country;
  late final String flag;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    flag = json['flag'] ??
        "https://cdn.iconscout.com/icon/premium/png-256-thumb/no-image-2840213-2359555.png";
  }
}
