import 'dart:developer';

import 'package:ElevatED/features/data/data%20sources/api/firebase_api.dart';
import 'package:ElevatED/init.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmNotification {
  final FirebaseApi firebaseApi;
  final _firebaseMessaging = FirebaseMessaging.instance;

  FcmNotification(this.firebaseApi);

  Future<void> initNotifications() async {
    // Request permission from the user
    await _firebaseMessaging.requestPermission();

    // Fetch the FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fcmToken");

    // !!! IMPORTANT !!!
    // Send this token to your Spring Boot backend to save it
    await firebaseApi.sendTokenToBackend(fcmToken);

    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // You can show a local notification here if you want

        _handleNavigation(message.data);
      }
    });

    // 2. Handles the case where the app is opened from a terminated state
    // by a notification.
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _handleNavigation(message.data);
      }
    });
    // 3. Handles the case where the app is opened from a background state
    // by a notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNavigation(message.data);
    });
  }

  void _handleNavigation(Map<String, dynamic> data) {
    log(data.toString());
    if (data.containsKey('type')) {
      final String type = data['type'] as String;
      // Use the navigatorKey to navigate
      navigatorKey.currentState?.pushReplacementNamed(type);
    }
  }
}
