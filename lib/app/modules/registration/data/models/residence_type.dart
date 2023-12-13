class ResidenceType {
  ResidenceType({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  ResidenceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
