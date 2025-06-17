import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class SubmitAssignmentUseCase {
  final AppRepository repository;
  SubmitAssignmentUseCase(this.repository);

  Future<void> call(
      {required int assignmentId, required Map<int, String> answers}) {
    return repository.submitAssignment(
        assignmentId: assignmentId, answers: answers);
  }
}
