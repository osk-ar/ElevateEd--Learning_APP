import 'package:e_learning_app_gp/core/helper/data_intent.dart';
import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/usecases/facebook_auth_usecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/google_auth_usecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/login_usecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/user_exist_usecase.dart';
import 'package:e_learning_app_gp/features/presentation/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUserUseCase;
  final GoogleAuthUseCase googleAuthUserUseCase;
  final FacebookAuthUseCase facebookAuthUseCase;
  final UserExistUseCase userExistUseCase;
  bool isPasswordVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginCubit(
    this.loginUserUseCase,
    this.googleAuthUserUseCase,
    this.facebookAuthUseCase,
    this.userExistUseCase,
  ) : super(LoginInitial());

  Future<void> login() async {
    emit(LoginLoading());
    try {
      final user = User(
        email: emailController.text,
        password: passwordController.text,
      );
      final User userData = await loginUserUseCase.call(user);
      DataIntent.pushUserID(userData.id!);
      DataIntent.pushToken(userData.token!);
      DataIntent.pushUserRole(userData.userRole!);
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  Future<void> authWithGoogle() async {
    emit(LoginLoading());
    try {
      var userGoogle = await googleAuthUserUseCase.call();

      DataIntent.pushUserID(userGoogle!.id!);
      DataIntent.pushToken(userGoogle.token!);
      DataIntent.pushUserRole("Student");
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  Future<bool?> authWithFacebook() async {
    emit(LoginLoading());
    try {
      var userFacebook = await facebookAuthUseCase.call();
      if (userFacebook != null) {
        DataIntent.pushUserID(userFacebook.id!);
        DataIntent.pushToken(userFacebook.token!);
        DataIntent.pushUserRole("Student");
        emit(LoginSuccess());
      }
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginPasswordVisibilityChanged(isPasswordVisible));
  }
}
