import 'package:e_learning_app_gp/core/constants/enum.dart';
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
      updatesharedPrefs(authResponseData: userData);
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

  void updatesharedPrefs({required User authResponseData}) {
    if (isRememberMeChecked) {
      appSharedPrefs.setBool(KeyPrefs.IS_LOGGEDIN.name, true);
      appSharedPrefs.setInt(KeyPrefs.ID.name, authResponseData.id!);
      appSharedPrefs.setString(
          KeyPrefs.ROLE.name, authResponseData.userRole!.name);
      return;
    }

    if (appSharedPrefs.containKey(KeyPrefs.IS_LOGGEDIN.name)) {
      appSharedPrefs.removeByKey(KeyPrefs.IS_LOGGEDIN.name);
    }
    if (appSharedPrefs.containKey(KeyPrefs.ID.name)) {
      appSharedPrefs.removeByKey(KeyPrefs.ID.name);
    }
    if (appSharedPrefs.containKey(KeyPrefs.ROLE.name)) {
      appSharedPrefs.removeByKey(KeyPrefs.ROLE.name);
    }
  }
}
