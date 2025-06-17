part of '../../cubit/assignment/assignment_solver_cubit.dart';

abstract class AssignmentSolverState {
  const AssignmentSolverState();
}

class AssignmentSolverInitial extends AssignmentSolverState {}

class AssignmentLoading extends AssignmentSolverState {}

class AssignmentLoaded extends AssignmentSolverState {
  final Map<int, String> answers;
  const AssignmentLoaded(this.answers);
}

class AssignmentSubmissionInProgress extends AssignmentSolverState {}

class AssignmentSubmissionSuccess extends AssignmentSolverState {}

class AssignmentSubmissionFailure extends AssignmentSolverState {
  final String error;
  const AssignmentSubmissionFailure(this.error);
}
