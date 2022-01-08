import 'package:scm/services/notification/remote_notification_params.dart';

class AppNotificationsHelper {
  AppNotificationsHelper({
    required this.isNotificationRead,
    required this.notification,
  });

  final bool isNotificationRead;
  final RemoteNotificationParams notification;

  AppNotificationsHelper? empty() {}

  AppNotificationsHelper copyWith({bool? isNotificationRead, RemoteNotificationParams? notification}) {
    return AppNotificationsHelper(
      isNotificationRead: isNotificationRead ?? this.isNotificationRead,
      notification: notification ?? this.notification,
    );
  }
}
