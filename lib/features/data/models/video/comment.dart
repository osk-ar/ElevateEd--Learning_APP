class Comment {
  int id;
  String text;
  String userName;
  String? date;

  // constructor
  Comment({
    required this.id,
    required this.text,
    required this.userName,
    this.date,
  });

  // from json
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      text: json['content'],
      userName: json["author"]['fullname'],
      date: (json['createdAt']),
    );
  }
}
