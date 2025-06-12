import 'dart:developer';

import 'package:ElevatED/core/constants/app_keys.dart';
import 'package:ElevatED/core/services/Shared%20Preferences%20Service/shared_preferences_service.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:ElevatED/features/domain/usecases/login_usecase.dart';
import 'package:ElevatED/features/presentation/4_login/states/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUserUseCase;
  final SharedPreferencesService appSharedPrefs;

  LoginCubit(this.loginUserUseCase, this.appSharedPrefs)
      : super(LoginInitial());

  bool isPasswordVisible = false;
  bool isRememberMeChecked = false;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final user = User(
        email: email,
        password: password,
      );
      final UserData userData = await loginUserUseCase.call(user);
      updatesharedPrefs(email, password);
      emit(LoginSuccess(user: userData));
    } catch (error) {
      log(error.toString());
      emit(LoginFailure(error.toString()));
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginPasswordVisibilityChanged(isPasswordVisible));
  }

  void toggleRememberMe(bool value) {
    isRememberMeChecked = value;
    emit(LoginRememberMeChanged(isRememberMeChecked));
  }

  void updatesharedPrefs(String email, String password) {
    appSharedPrefs.setBool(AppKeys.shouldSaveAuthKey, isRememberMeChecked);
    if (!isRememberMeChecked) return;

    appSharedPrefs.setString(AppKeys.emailKey, email);
    appSharedPrefs.setString(AppKeys.passwordKey, password);
  }
}
