import 'package:scm/routes/routes_constants.dart';
import 'package:scm/app/app.router.dart';
import 'package:scm/app/di.dart';
import 'package:scm/model_classes/app_notifications_helper.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_list_view.dart';
import 'package:scm/services/notification/remote_notification_params.dart';
import 'package:scm/services/streams/notifications_stream.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationIconViewModel
    extends StreamViewModel<RemoteNotificationParams> {
  List<AppNotificationsHelper> appNotificationsList = [];

  @override
  void dispose() {
    super.dispose();
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
      notifyListeners();
    }
    super.onData(data);
  }

  @override
  Stream<RemoteNotificationParams> get stream =>
      locator<NotificationsStream>().onNewData;

  void takeToAppNotificationsList() {
    locator<NavigationService>()
        .navigateTo(
      notificationScreenPageRoute,
      arguments: NotificationsScreenViewArguments(
        arguments: NotificationsScreenArgs.fromNotificationIcon(
          appNotificationsList: appNotificationsList,
        ),
      ),
    )!
        .then((value) {
      for (var element in appNotificationsList) {
        AppNotificationsHelper helper = element;
        appNotificationsList.remove(element);
        helper = helper.copyWith(isNotificationRead: true);
        appNotificationsList.add(helper);
      }

      notifyListeners();
    });
  }

  bool isNotificationsUnread() {
    bool isUnread = false;

    for (var element in appNotificationsList) {
      if (!element.isNotificationRead) {
        isUnread = true;
      }
    }

    return isUnread;
  }
}
