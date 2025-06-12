class Comment {
  int id;
  String text;
  String userName;
  String userProfileUrl;
  DateTime date;

  // constructor
  Comment({
    required this.id,
    required this.text,
    required this.userName,
    required this.userProfileUrl,
    required this.date,
  });

  // from json
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      text: json['text'],
      userName: json['userName'],
      userProfileUrl: json['userProfileUrl'],
      date: DateTime.parse(json['date']),
    );
  }
}
