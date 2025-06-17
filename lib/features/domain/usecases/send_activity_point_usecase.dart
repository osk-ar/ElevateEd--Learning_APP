import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class SendActivityPointUseCase {
  final AppRepository repository;
  SendActivityPointUseCase(this.repository);

  Future<void> call({
    required int userId,
    required double hours,
  }) async {
    await repository.sendActivityPoint(
      userId: userId,
      hours: hours,
    );
  }
}
