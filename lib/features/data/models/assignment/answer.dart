class Answer {
  final String text;
  final bool isTrue;

  Answer({required this.text, required this.isTrue});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      text: json['text'] as String,
      isTrue: json['isTrue'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isTrue': isTrue,
    };
  }
}
