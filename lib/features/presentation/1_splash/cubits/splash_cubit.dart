import 'package:ElevatED/core/constants/app_keys.dart';
import 'package:ElevatED/core/services/Shared%20Preferences%20Service/shared_preferences_service.dart';
import 'package:ElevatED/features/domain/repositories/user_repository.dart';
import 'package:ElevatED/features/presentation/1_splash/states/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final SharedPreferencesService appPrefs;
  final UserRepository userRepository;
  SplashCubit(
    this.appPrefs,
    this.userRepository,
  ) : super(SplashInitial());

  Future<bool> checkSharedPrefs() async {
    bool? isSignedIn = appPrefs.getBool(AppKeys.shouldSaveAuthKey);
    if (isSignedIn ?? false) {
      String email = appPrefs.getString(AppKeys.emailKey)!;
      String password = appPrefs.getString(AppKeys.passwordKey)!;

      await getUserData(email, password);

      return true;
    }
    return false;
  }

  Future<void> getUserData(String email, String password) async {
    await userRepository.getUserData(email, password);
  }
}
