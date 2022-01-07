import 'package:scm/app/di.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/enums/notification_type.dart';
import 'package:scm/services/notification/remote_notification_params.dart';
import 'package:stacked_services/stacked_services.dart';

import 'notification_dialog_box.dart';

const String notificationType = 'ORDER';

class OnNotificationClick {
  OnNotificationClick({required this.notificationParams});

  final RemoteNotificationParams notificationParams;

  final DialogService _dialogService = di<DialogService>();

  // final NavigationService _navigationService = locator<NavigationService>();

  void handle() {
    if (notificationParams.screen == notificationType) {
      _dialogService.showCustomDialog(
        barrierDismissible: false,
        variant: DialogType.NOTIFICATION,
        data: NotificationDialogBoxViewArguments.orderDetails(
          orderId: int.parse(
            notificationParams.id,
          ),
        ),
      );
    }
  }
}
