import 'dart:developer';

import 'package:ElevatED/features/data/models/assignment/answer.dart';

abstract interface class Question {
  final int index;
  final String title;
  final String type;

  const Question({
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

  Question copyWith({
    int? index,
    String? title,
  });

  static List<Question> mapQuestions(List<dynamic> json) {
    List<Question> questions = [];
    log(json.toString());

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
  final List<Answer> answers;

  const MultipleChoiseQuestion({
    required super.index,
    required super.title,
    required this.answers,
  }) : super(type: "multiple_choice");

  //todo change options to take real value
  factory MultipleChoiseQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleChoiseQuestion(
      index: json['index'],
      title: json['title'],
      answers: (json['answers'] as List<dynamic>)
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

  @override
  MultipleChoiseQuestion copyWith({
    int? index,
    String? title,
    List<Answer>? answers,
  }) {
    return MultipleChoiseQuestion(
      index: index ?? this.index,
      title: title ?? this.title,
      answers: answers ?? this.answers,
    );
  }
}

class EssayQuestion extends Question {
  final Answer answer;

  const EssayQuestion({
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

  @override
  EssayQuestion copyWith({
    int? index,
    String? title,
    Answer? answer,
  }) {
    return EssayQuestion(
      index: index ?? this.index,
      title: title ?? this.title,
      answer: answer ?? this.answer,
    );
  }
}
