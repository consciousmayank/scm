import 'package:flutter/services.dart';
import 'package:scm/app/app.locator.dart';
import 'package:scm/app/app.locator.dart';

import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/services/sharepreferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GeneralisedBaseViewModel extends BaseViewModel {
  // ApiService apiService = locator<ApiService>();
  DialogService dialogService = locator<DialogService>();

  bool isFloatingActionButtonVisible = true;
  bool isLocationServiceEnabled = false;
  NavigationService navigationService = locator<NavigationService>();
  final preferences = locator<SharedPreferencesService>();
  SnackbarService snackBarService = locator<SnackbarService>();

  ///This will help in showing error snackbar
  ///If [onSnackBarOkButton] is not there then a normal error snackbar will be shown, otherwise snackbar will have an 'OK' button.
  ///
  void showErrorSnackBar({
    required String message,
    Function? onSnackBarOkButton,
    int secondsToShowSnackBar = 4,
  }) {
    if (onSnackBarOkButton != null) {
      snackBarService.showCustomSnackBar(
        variant: SnackbarType.ERROR,
        duration: Duration(
          seconds: secondsToShowSnackBar,
        ),
        mainButtonTitle: 'Ok',
        onMainButtonTapped: () {
          onSnackBarOkButton.call();
        },
        title: "Error",
        message: message,
      );
    } else {
      snackBarService.showCustomSnackBar(
        variant: SnackbarType.ERROR,
        duration: Duration(
          seconds: secondsToShowSnackBar,
        ),
        message: message,
        title: "Error",
      );
    }
  }

  ///This will help in showing info snackbar
  ///
  void showInfoSnackBar({
    required String message,
    int secondsToShowSnackBar = 4,
  }) {
    snackBarService.showCustomSnackBar(
      variant: SnackbarType.NORMAL,
      duration: Duration(
        seconds: secondsToShowSnackBar,
      ),
      message: message,
    );
  }

  void copyToClipBoard(
      {required String textToBeCopied, String? afterCopyMsg}) async {
    if (textToBeCopied.isEmpty) {
      showErrorSnackBar(message: 'No text to copy');
    } else {
      await Clipboard.setData(
        ClipboardData(
          text: textToBeCopied,
        ),
      ).then(
        (value) => showInfoSnackBar(
          message: afterCopyMsg ?? 'Copied',
        ),
      );
    }
  }

  bool isDeo() {
    return preferences.getSelectedUserRole() ==
        AuthenticatedUserRoles.ROLE_DEO.getStatusString;
  }

  bool isDeoSuperVisor() {
    return preferences.getSelectedUserRole() ==
        AuthenticatedUserRoles.ROLE_SUPVR.getStatusString;
  }

  bool isSupplier() {
    return preferences.getSelectedUserRole() ==
        AuthenticatedUserRoles.ROLE_SUPPLY.getStatusString;
  }

  bool isDemander() {
    return preferences.getSelectedUserRole() ==
        AuthenticatedUserRoles.ROLE_DEMAND.getStatusString;
  }

  bool isDeoGd() {
    return preferences.getSelectedUserRole() ==
        AuthenticatedUserRoles.ROLE_GD.getStatusString;
  }
}
