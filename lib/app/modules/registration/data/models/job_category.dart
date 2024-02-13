class JobCategory {
  JobCategory({required this.id, required this.name, this.isSelected = false});
  late final int id;
  late final String name;
  late bool isSelected;

  JobCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSelected = false;
  }
}
