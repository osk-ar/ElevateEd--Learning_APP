class CourseCategory {
  int id;
  String name;

  CourseCategory({
    required this.id,
    required this.name,
  });

  factory CourseCategory.fromJson(Map<String, dynamic> json) {
    return CourseCategory(
      name: json['catName'],
      id: json['id'],
    );
  }

  factory CourseCategory.empty() {
    return CourseCategory(
      name: "unknown category",
      id: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'catName': name,
      'id': id,
    };
  }
}
