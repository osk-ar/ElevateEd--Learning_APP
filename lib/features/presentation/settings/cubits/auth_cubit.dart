import 'package:equatable/equatable.dart';
import 'package:ElevatED/core/constants/app_keys.dart';
import 'package:ElevatED/core/services/Shared Preferences Service/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SharedPreferencesService _prefs;
  AuthCubit(this._prefs) : super(const AuthInitial());

  Future<void> logout(BuildContext context) async {
    emit(const AuthLoading());
    try {
      await _prefs.removeByKey(AppKeys.shouldSaveAuthKey);
      await _prefs.removeByKey(AppKeys.emailKey);
      await _prefs.removeByKey(AppKeys.passwordKey);

      emit(const AuthLoggedOut());
      // Navigate to onboarding & clear back stack
      if (context.mounted) {
        context.pushNamedAndRemoveUntil(RouteConstants.onBoardingScreenRoute,
            predicate: (_) => false);
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
