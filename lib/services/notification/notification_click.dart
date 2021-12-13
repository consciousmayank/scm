import 'package:scm/services/notification/remote_notification_params.dart';
import 'package:stacked_services/stacked_services.dart';

const String notificationType = 'NEW_GPS_REQUEST';

class OnNotificationClick {
  OnNotificationClick({required this.notificationParams});

  final RemoteNotificationParams notificationParams;

  // final DialogService _dialogService = locator<DialogService>();
  // final NavigationService _navigationService = locator<NavigationService>();

  void handle() {
    if (notificationParams.screen == notificationType) {
      // _dialogService
      //     .showCustomDialog(
      //   barrierDismissible: false,
      //   variant: DialogType.NEW_GPS_REQUEST,
      //   data: NewGpsRequestDialogInputArguments(
      //     vendorName: notificationParams.title ?? '',
      //   ),
      // )
      //     .then((value) {
      //   if (value != null) {
      //     if (value.confirmed) {
      //       _navigationService.navigateTo(gpsRequestsPageRoute,
      //           arguments: GpsServiceRequestsViewArguments());
      //     }
      //   }
      // });
    }
  }
}
