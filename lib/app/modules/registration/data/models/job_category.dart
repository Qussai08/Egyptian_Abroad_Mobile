class JobCategory {
  JobCategory({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  JobCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
