import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  bool containKey(String key) => _sharedPreferences.containsKey(key);

  Future<void> removeByKey(String key) async =>
      await _sharedPreferences.remove(key);

  //--------------------------------------- getters

  int? getInt(String key) => _sharedPreferences.getInt(key);

  String? getString(String key) => _sharedPreferences.getString(key);

  bool? getBool(String key) => _sharedPreferences.getBool(key);

  double? getDouble(String key) => _sharedPreferences.getDouble(key);

  Future<List<String>?> getStringList(String key) async =>
      _sharedPreferences.getStringList(key);

  Map<String, dynamic>? getMap(String key) =>
      containKey(key) ? json.decode(getString(key)!) : null;

  DateTime? getDateTime(String key) {
    return containKey(key)
        ? DateTime.fromMillisecondsSinceEpoch(getInt(key)!)
        : null;
  }

  //--------------------------------------- setters

  Future<void> setBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    await _sharedPreferences.setDouble(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _sharedPreferences.setInt(key, value);
  }

  Future<void> setString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _sharedPreferences.setStringList(key, value);
  }

  Future<void> setMap(String key, Map<String, dynamic> value) async {
    await setString(key, json.encode(value));
  }

  Future<void> setDateTime(String key, DateTime value) async {
    int millis = value.millisecondsSinceEpoch;
    await setInt(key, millis);
  }
}
