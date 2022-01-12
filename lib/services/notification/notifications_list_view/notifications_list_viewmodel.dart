import 'package:flutter/material.dart';
import 'package:scm/app/app.locator.dart';
import 'package:scm/model_classes/app_notifications_helper.dart';
import 'package:scm/screens/order_list_page/order_list_page_view.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_list_view.dart';
import 'package:scm/services/notification/remote_notification_params.dart';
import 'package:scm/services/streams/notifications_stream.dart';
import 'package:stacked/stacked.dart';

class NotificationsListViewModel
    extends StreamViewModel<RemoteNotificationParams> {
  late List<AppNotificationsHelper> appNotificationsList;
  late NotificationsScreenArguments arguments;
  AppNotificationsHelper? clickedNotification;

  final NotificationsStream _notificationsStream =
      locator<NotificationsStream>();

  init({required NotificationsScreenArguments args}) {
    arguments = args;
    if (args.appNotificationsList.isEmpty) {
      appNotificationsList = _notificationsStream.appNotificationsList;
    } else {
      appNotificationsList = args.appNotificationsList;
    }
    clickedNotification = appNotificationsList.first;
    notifyListeners();
  }

  @override
  void onData(RemoteNotificationParams? data) {
    if (data != null) {
      appNotificationsList.add(
        AppNotificationsHelper(
          isNotificationRead: false,
          notification: data,
        ),
      );
    }
    super.onData(data);
  }

  getSelectedView() {
    if (clickedNotification != null) {
      if (clickedNotification!.notification.screen == 'ORDER') {
        return OrderListPageView(
          key: UniqueKey(),
          arguments: OrderListPageViewArguments.notification(
            orderId: int.parse(
              clickedNotification!.notification.id,
            ),
          ),
        );
      }
    }
    return const Center(
      child: Text('Click on the notification on left to open one.'),
    );
  }

  @override
  // TODO: implement stream
  Stream<RemoteNotificationParams> get stream =>
      locator<NotificationsStream>().onNewData;
}
