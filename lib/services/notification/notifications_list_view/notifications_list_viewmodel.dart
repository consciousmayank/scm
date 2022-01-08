import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/app_notifications_helper.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_list_view.dart';
import 'package:scm/services/streams/notifications_stream.dart';

class NotificationsListViewModel extends GeneralisedBaseViewModel {
  late List<AppNotificationsHelper> appNotificationsList;
  late NotificationsScreenArguments arguments;
  AppNotificationsHelper? clickedNotification;

  final NotificationsStream _notificationsStream = di<NotificationsStream>();

  init({required NotificationsScreenArguments args}) {
    arguments = args;
    if (args.appNotificationsList.isEmpty) {
      appNotificationsList = _notificationsStream.appNotificationsList;
      clickedNotification = args.clickedNotification;
    } else {
      appNotificationsList = args.appNotificationsList;
      clickedNotification = args.clickedNotification;
    }
    notifyListeners();
  }

  getSelectedView() {
    return Container(
      color: Colors.amber,
    );
  }
}
