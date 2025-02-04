import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/helper/data_intent.dart';
import 'package:e_learning_app_gp/core/helper/map_string_to_user_role.dart';
import 'package:e_learning_app_gp/features/data_sources/local/app_prefs.dart';
import 'package:e_learning_app_gp/features/domain/entities/home.dart';
import 'package:e_learning_app_gp/features/domain/usecases/get_homeusecase.dart';
import 'package:e_learning_app_gp/features/presentation/splash/states/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final AppPrefs appPrefs;
  final GetHomeusecase getHomeusecase;
  SplashCubit(this.appPrefs, this.getHomeusecase) : super(SplashInitial());

  Future<bool> checkSharedPrefs() async {
    bool? isSignedIn = appPrefs.getBool(KeyPrefs.IS_LOGGEDIN.name);
    if (isSignedIn ?? false) {
      int id = appPrefs.getInt(KeyPrefs.ID.name)!;
      String role = appPrefs.getString(KeyPrefs.ROLE.name)!;

      Home homeData = await getHomeusecase.call(id);
      DataIntent.pushHomeData(homeData);
      DataIntent.pushUserRole(getUserRoleFromString(role));

      return true;
    }
    return false;
  }
}

/// check sharedPrefs
/// if loggedIn make home request and go to home
/// if not go to onBoarding