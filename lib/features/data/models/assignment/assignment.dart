import 'package:ElevatED/features/data/models/assignment/question.dart';

class Assignment {
  int index;
  String title;

  List<Question> questions;

  // Normal constructor
  Assignment({
    required this.index,
    required this.title,
    required this.questions,
  });

  // fromJson constructor
  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      index: json['index'],
      title: json['title'],
      questions: Question.mapQuestions(
          json['questions'] as List<Map<String, dynamic>>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'title': title,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}
