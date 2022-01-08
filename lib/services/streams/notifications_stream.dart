import 'dart:async';

import 'package:scm/model_classes/app_notifications_helper.dart';
import 'package:scm/services/notification/remote_notification_params.dart';

class NotificationsStream {
  StreamController<RemoteNotificationParams> notificationStream =
      StreamController<RemoteNotificationParams>.broadcast();

  final List<AppNotificationsHelper> _appNotificationsList = [];

  Stream<RemoteNotificationParams> get onNewData => notificationStream.stream;

  StreamController get controller => notificationStream;

  void dispose() {
    notificationStream.close();
  }

  void addToStream(RemoteNotificationParams data) {
    _appNotificationsList.add(
      AppNotificationsHelper(
        isNotificationRead: false,
        notification: data,
      ),
    );

    controller.add(data);
  }

  List<AppNotificationsHelper> get appNotificationsList =>
      _appNotificationsList;
}
