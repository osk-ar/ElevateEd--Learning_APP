import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/features/data_sources/local/app_prefs.dart';
import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/usecases/login_usecase.dart';
import 'package:e_learning_app_gp/features/presentation/login/states/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUserUseCase;
  final AppPrefs appSharedPrefs;

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
      final User userData = await loginUserUseCase.call(user);
      updatesharedPrefs(email: email, password: password);
      emit(LoginSuccess(user: userData));
    } catch (error) {
      print(error.toString());
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

  void updatesharedPrefs({String? email, String? password}) {
    if (isRememberMeChecked &&
        !email.isNullOrEmpty() &&
        !password.isNullOrEmpty()) {
      appSharedPrefs.setBool(KeyPrefs.IS_LOGGEDIN.name, true);
      appSharedPrefs.setString(KeyPrefs.EMAIL.name, email!);
      appSharedPrefs.setString(KeyPrefs.PASSWORD.name, password!);
      return;
    }

    if (appSharedPrefs.containKey(KeyPrefs.IS_LOGGEDIN.name)) {
      appSharedPrefs.removeByKey(KeyPrefs.IS_LOGGEDIN.name);
    }
    if (appSharedPrefs.containKey(KeyPrefs.EMAIL.name)) {
      appSharedPrefs.removeByKey(KeyPrefs.EMAIL.name);
    }
    if (appSharedPrefs.containKey(KeyPrefs.PASSWORD.name)) {
      appSharedPrefs.removeByKey(KeyPrefs.PASSWORD.name);
    }
  }
}
