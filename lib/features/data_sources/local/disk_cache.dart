import 'package:ElevatED/core/constants/constants.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DiskCache {
  void saveThemeMode(ThemeModes themeMode);
  int? getThemeMode();

  void saveLanguage(Languages language);
  int? getLanguage();

  void saveNotificationMode(Notifications notifications);
  int? getNotificationsMode();

  void saveLoginData(String email, String password);
  Map<String, dynamic>? getLoginData();
  void removeLoginData();
}

class DiskCacheImpl implements DiskCache {
  final SharedPreferences _sharedPreferences;
  DiskCacheImpl(this._sharedPreferences);

  @override
  void saveThemeMode(ThemeModes themeMode) async {
    await _sharedPreferences.setInt(Constants.themeKey, themeMode.index);
  }

  @override
  int? getThemeMode() {
    final int? themeIndex = _sharedPreferences.getInt(Constants.themeKey);
    return themeIndex;
  }

  @override
  void saveLanguage(Languages language) async {
    await _sharedPreferences.setInt(Constants.languageKey, language.index);
    print("language Saved: ${language.index} | ${language.name}");
  }

  @override
  int? getLanguage() {
    final int? languageIndex = _sharedPreferences.getInt(Constants.languageKey);
    return languageIndex;
  }

  @override
  void saveNotificationMode(Notifications notifications) async {
    await _sharedPreferences.setInt(
        Constants.notificationKey, notifications.index);
  }

  @override
  int? getNotificationsMode() {
    final int? notificationIndex =
        _sharedPreferences.getInt(Constants.notificationKey);
    return notificationIndex;
  }

  @override
  void saveLoginData(String email, String password) async {
    await _sharedPreferences
        .setStringList(Constants.loginDataKey, [email, password]);
  }

  @override
  Map<String, dynamic>? getLoginData() {
    final List<String>? loginData =
        _sharedPreferences.getStringList(Constants.loginDataKey);
    if (loginData != null) {
      return {
        Constants.loginEmailKey: loginData[0],
        Constants.loginPasswordKey: loginData[1]
      };
    }
    return null;
  }

  @override
  void removeLoginData() async {
    await _sharedPreferences.remove(Constants.loginDataKey);
  }
}
