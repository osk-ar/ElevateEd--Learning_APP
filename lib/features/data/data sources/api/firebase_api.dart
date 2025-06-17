import 'dart:developer';

import 'package:ElevatED/core/constants/app_keys.dart';
import 'package:ElevatED/core/services/Shared%20Preferences%20Service/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseApi {
  late Dio dio;
  final SharedPreferencesService appSharedPrefs;
  FirebaseApi(this.dio, this.appSharedPrefs);

  // Method to send the token to your backend
  Future<void> sendTokenToBackend(String? fcmToken) async {
    final token = appSharedPrefs.getString(AppKeys.tokenKey);
    final id = appSharedPrefs.getInt(AppKeys.idKey);

    log("FCM Token: $fcmToken");
    log("Token: $token");
    log("ID: $id");
    if (fcmToken == null || token == null || id == null) return;

    try {
      final response = await dio.post(
        '${dotenv.get('API_LINK')}register-device',
        data: {'token': fcmToken, 'userId': id},
        options: Options(
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Token registered successfully on backend.");
        print(response.data);
      } else {
        print(response.statusMessage);
        print("Failed to register token. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending token to backend: $e");
    }
  }
}
