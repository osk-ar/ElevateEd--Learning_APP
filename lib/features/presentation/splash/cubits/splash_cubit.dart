import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/helper/memory_cache.dart';
import 'package:ElevatED/core/helper/json_helpers.dart';
import 'package:ElevatED/features/data_sources/local/app_prefs.dart';
import 'package:ElevatED/features/domain/entities/home.dart';
import 'package:ElevatED/features/domain/usecases/get_home_usecase.dart';
import 'package:ElevatED/features/presentation/splash/states/splash_state.dart';
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
      MemoryCache.pushHomeData(homeData);
      MemoryCache.pushUserRole(getUserRoleFromString(role));

      return true;
    }
    return false;
  }
}

/// check sharedPrefs
/// if loggedIn make home request and go to home
/// if not go to onBoarding