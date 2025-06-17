import 'dart:developer';

import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/features/data/models/assignment/question.dart';
import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/features/domain/usecases/send_activity_point_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/features/data/models/assignment/assignment.dart';
import 'package:ElevatED/features/domain/usecases/submit_assignment_usecase.dart';

part '../../state/assignment/assignment_solver_state.dart';

class AssignmentSolverCubit extends Cubit<AssignmentSolverState> {
  final SubmitAssignmentUseCase submitAssignmentUseCase;
  final SendActivityPointUseCase sendActivityPointUseCase;
  late final Assignment assignment;
  final Map<int, String> _answers = {};

  AssignmentSolverCubit(
    this.submitAssignmentUseCase,
    this.sendActivityPointUseCase,
  ) : super(AssignmentSolverInitial());

  void setAssignment(Assignment assignment) {
    this.assignment = assignment;
  }

  void updateAnswer(int questionIndex, String answer) {
    _answers[questionIndex] = answer;
    emit(AssignmentLoaded(Map<int, String>.from(_answers)));
    log("assignment cubit updateAnswer: $_answers");
  }

  Future<void> submitAnswers(BuildContext context) async {
    try {
      final error = getValidationError();
      if (error != null) {
        context.message(message: error);
        return;
      }
      emit(AssignmentSubmissionInProgress());
      await submitAssignmentUseCase(
        assignmentId: assignment.id,
        answers: _answers,
      );
      emit(AssignmentSubmissionSuccess());
    } catch (e) {
      emit(AssignmentSubmissionFailure(e.toString()));
    }
  }

  Map<int, String> get answers => Map.unmodifiable(_answers);

  int getAnswerIndex(int questionIndex) {
    final question = assignment.questions[questionIndex];
    if (question is MultipleChoiseQuestion) {
      return _answers[questionIndex] != null
          ? question.answers.indexWhere(
              (e) => e.text == _answers[questionIndex],
            )
          : -1;
    }
    return -1;
  }

  /// Returns true if all questions are answered, false otherwise.
  bool validateSubmission() {
    if (assignment.questions.isEmpty) return false;
    for (final q in assignment.questions) {
      if (!_answers.containsKey(q.index) ||
          _answers[q.index] == null ||
          _answers[q.index]!.trim().isEmpty) {
        return false;
      }
    }
    return true;
  }

  /// Returns a validation error message if not valid, or null if valid.
  String? getValidationError() {
    if (assignment.questions.isEmpty) {
      return 'No questions in assignment.';
    }
    for (final q in assignment.questions) {
      if (!_answers.containsKey(q.index) ||
          _answers[q.index] == null ||
          _answers[q.index]!.trim().isEmpty) {
        return 'Please answer all questions.';
      }
    }
    return null;
  }

  Future<void> sendActivityPoint(int secondsSpent) async {
    try {
      final userId = MemoryCache.getUserData()?.id;
      if (userId == null && secondsSpent <= 10) return;

      final hours = secondsSpent / 3600.0;
      await sendActivityPointUseCase(
        userId: userId!,
        hours: hours,
      );
    } catch (e) {
      // Optionally log or handle error
    }
  }
}
