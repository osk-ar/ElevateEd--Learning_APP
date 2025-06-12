import 'package:ElevatED/features/data/models/assignment/answer.dart';

abstract interface class Question {
  int index;
  String title;
  final String type;

  Question({
    required this.index,
    required this.title,
    required this.type,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson must be implemented in subclasses');
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError('toJson must be implemented in subclasses');
  }

  static List<Question> mapQuestions(List<Map<String, dynamic>> json) {
    List<Question> questions = [];

    for (Map<String, dynamic> question in json) {
      if (question['type'] == 'multiple_choice') {
        questions.add(MultipleChoiseQuestion.fromJson(question));
      } else if (question['type'] == 'essay') {
        questions.add(EssayQuestion.fromJson(question));
      } else {
        throw Exception('Unknown question type: ${question['type']}');
      }
    }

    return questions;
  }
}

class MultipleChoiseQuestion extends Question {
  List<Answer> answers;

  MultipleChoiseQuestion({
    required super.index,
    required super.title,
    required this.answers,
  }) : super(type: "multiple_choice");

  //todo change options to take real value
  factory MultipleChoiseQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleChoiseQuestion(
      index: json['index'],
      title: json['title'],
      answers: (json['answer'] as List<Map<String, dynamic>>)
          .map((ans) => Answer.fromJson(ans))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'title': title,
      'answer': answers.map((ans) => ans.toJson()).toList(),
      'type': type,
    };
  }
}

class EssayQuestion extends Question {
  Answer answer;

  EssayQuestion({
    required super.index,
    required super.title,
    required this.answer,
  }) : super(type: "essay");

  factory EssayQuestion.fromJson(Map<String, dynamic> json) {
    return EssayQuestion(
      index: json['index'],
      title: json['title'],
      answer: Answer.fromJson(json['answer']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'title': title,
      'answer': answer.toJson(),
      'type': type,
    };
  }
}
