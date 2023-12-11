class Country {
  Country({
    required this.id,
    required this.country,
  });
  late final int id;
  late final String country;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
  }
}
