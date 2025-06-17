import 'package:ElevatED/features/data/models/assignment/question.dart';
import 'package:ElevatED/features/data/models/orderable/orderable.dart';

class Assignment extends Orderable {
  final List<Question> questions;

  // Normal constructor
  const Assignment({
    super.id = -1,
    required super.index,
    required super.title,
    required this.questions,
  });

  // fromJson constructor
  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      index: json['index'],
      title: json['title'],
      questions: Question.mapQuestions(json['questions'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'title': title,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [...super.props, questions];
}
