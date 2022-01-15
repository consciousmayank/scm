import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:scm/app/appconfigs.dart';
import 'package:scm/app/di.dart';
import 'package:scm/services/app_api_service_classes/profile_apis.dart';

class FirebasePushNotificationsPermissions {
  Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      if (kIsWeb) {
        FirebaseMessaging.instance
            .getToken(
          vapidKey: EnvironmentConfig.VAPID_KEY,
        )
            .then((value) {
          locator<ProfileApisImpl>().updateWebFcmId(fcmId: value ?? '');
        });
      } else {
        FirebaseMessaging.instance.getToken().then((value) {
          locator<ProfileApisImpl>().updateWebFcmId(fcmId: value ?? '');
        });
      }
    }
  }
}
