import 'package:scm/app/di.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/enums/notification_type.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/model_classes/app_notifications_helper.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_list_view.dart';
import 'package:scm/services/notification/remote_notification_params.dart';
import 'package:scm/services/streams/notifications_stream.dart';
import 'package:scm/utils/strings.dart';
import 'package:stacked_services/stacked_services.dart';

import 'notification_dialog_box.dart';

const String notificationType = 'ORDER';

class OnNotificationClick {
  OnNotificationClick({required this.notificationParams});

  final RemoteNotificationParams notificationParams;
  final NotificationsStream notificationsStream = di<NotificationsStream>();

  final NavigationService _navigationService = di<NavigationService>();
  // final DialogService _dialogService = di<DialogService>();
  final SnackbarService _snackbarService = di<SnackbarService>();

  void handle() {
    String message = '';
    Function? onButtonClicked;

    switch (notificationParams.screen) {
      case notificationType:
        notificationsStream.addToStream(notificationParams);
        message = ordersNotificationDescription;
        onButtonClicked = () {
          _navigationService.navigateTo(
            notificationScreenPageRoute,
            arguments: NotificationsScreenArguments.fromNotificationClick(
              clickedNotification: AppNotificationsHelper(
                isNotificationRead: false,
                notification: notificationParams,
              ),
            ),
          );
        };
        break;
    }

    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.ERROR,
      duration: const Duration(
        seconds: 4,
      ),
      title: "You've got a Notification",
      message: message,
    );
  }
}


// _dialogService.showCustomDialog(
      //   barrierDismissible: false,
      //   variant: DialogType.NOTIFICATION,
      //   data: NotificationDialogBoxViewArguments.orderDetails(
      //     orderId: int.parse(
      //       notificationParams.id,
      //     ),
      //   ),
      // );