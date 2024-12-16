import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/dependency_injection.dart';
import 'package:e_learning_app_gp/core/helper/data_intent.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/features/data_sources/local/app_prefs.dart';
import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/usecases/login_usecase.dart';
import 'package:e_learning_app_gp/features/presentation/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUserUseCase;
  bool isPasswordVisible = false;
  bool isRememberMeChecked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode submitButtonFocusNode = FocusNode();

  LoginCubit(
    this.loginUserUseCase,
  ) : super(LoginInitial());

  Future<void> login() async {
    emit(LoginLoading());
    try {
      final user = User(
        email: emailController.text,
        password: passwordController.text,
      );
      final User userData = await loginUserUseCase.call(user);
      DataIntent.pushId(userData.id!);
      DataIntent.pushRole(userData.userRole!);
      updatesharedPrefs(
          email: emailController.text, password: passwordController.text);

      emit(LoginSuccess());
    } catch (error) {
      print(error.toString());
      emit(LoginFailure(error.toString()));
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginPasswordVisibilityChanged(isPasswordVisible));
  }

  void checkRememberMe() {
    isRememberMeChecked = !isRememberMeChecked;
    emit(LoginPasswordVisibilityChanged(isRememberMeChecked));
  }

  void updatesharedPrefs({String? email, String? password}) {
    if (isRememberMeChecked &&
        !email.isNullOrEmpty() &&
        !password.isNullOrEmpty()) {
      sl<AppPrefs>().setBool(KeyPrefs.IS_LOGGEDIN.name, true);
      sl<AppPrefs>().setString(KeyPrefs.EMAIL.name, email!);
      sl<AppPrefs>().setString(KeyPrefs.PASSWORD.name, password!);
      return;
    }

    if (sl<AppPrefs>().containKey(KeyPrefs.IS_LOGGEDIN.name)) {
      sl<AppPrefs>().removeKey(KeyPrefs.IS_LOGGEDIN.name);
    }
    if (sl<AppPrefs>().containKey(KeyPrefs.EMAIL.name)) {
      sl<AppPrefs>().removeKey(KeyPrefs.EMAIL.name);
    }
    if (sl<AppPrefs>().containKey(KeyPrefs.PASSWORD.name)) {
      sl<AppPrefs>().removeKey(KeyPrefs.PASSWORD.name);
    }
  }
}
