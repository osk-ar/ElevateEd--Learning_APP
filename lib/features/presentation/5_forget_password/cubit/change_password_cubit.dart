import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'package:ElevatED/features/presentation/5_forget_password/state/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  void changePassword(String password) async {
    //todo send api request to change password
    emit(ChangePasswordLoading());
    try {
      await Future.delayed(
        const Duration(seconds: 3),
      );

      emit(ChangePasswordLoaded());
    } catch (e) {
      emit(
        ChangePasswordError(
          error: e.toString(),
        ),
      );
    }
  }
}
