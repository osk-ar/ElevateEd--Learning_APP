import 'dart:developer';

import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/features/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'package:ElevatED/features/presentation/5_forget_password/state/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._authRepository) : super(ChangePasswordInitial());
  final AuthRepository _authRepository;

  void changePassword(String password) async {
    //todo send api request to change password
    emit(ChangePasswordLoading());
    try {
      final email = MemoryCache.getResetPasswordEmail();
      if (email == null) {
        throw Exception("Email not found");
      }
      await _authRepository.resetPassword(email, password);
      MemoryCache.clearResetPasswordEmail();

      emit(ChangePasswordSuccess());
      log(state.toString());
    } catch (e) {
      emit(
        ChangePasswordError(
          error: e.toString(),
        ),
      );
    }
  }
}
