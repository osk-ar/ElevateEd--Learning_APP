import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/features/domain/usecases/send_otp_usecase.dart';
import 'package:ElevatED/features/presentation/5_forget_password/state/validation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidationCubit extends Cubit<ValidationState> {
  final SendOtpUsecase _sendOtpUsecase;
  ValidationCubit(this._sendOtpUsecase) : super(ValidationInitial());

  void sendOtp(String email) async {
    bool didSend = false;
    try {
      didSend = await _sendOtpUsecase.call(email);
      MemoryCache.pushResetPasswordEmail(email);
      emit(ValidationSent(didSend));
    } catch (e) {
      emit(ValidationError(e.toString()));
      emit(ValidationInitial());
    }
  }
}
