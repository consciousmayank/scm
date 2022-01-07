import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scm/services/notification/notification_click.dart';
import 'package:scm/services/notification/remote_notification_params.dart';

class LocalNotificationService {
  static RemoteNotificationParams notificationParams =
      RemoteNotificationParams.empty();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title ?? ''),
          content: Text(body ?? ''),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () async {
                OnNotificationClick notificationClick = OnNotificationClick(
                  notificationParams: RemoteNotificationParams.fromJson(
                    payload ?? '',
                  ),
                );
                notificationClick.handle();
              },
            )
          ],
        ),
      ),
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: initializationSettingsIOS,
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        if (payload != null) {
          OnNotificationClick notificationClick = OnNotificationClick(
            notificationParams: RemoteNotificationParams.fromJson(payload),
          );
          notificationClick.handle();
        }
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        'scms_channel', // id
        'High Importance Notifications', // title
        channelDescription:
            'This channel is used for important notifications for SCMS Project.', // description
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
      ));

      notificationParams = RemoteNotificationParams(
        id: message.data['id'],
        screen: message.data['screen'],
        type: message.data['type'],
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
      );

      await _notificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: notificationParams.toJson(),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
