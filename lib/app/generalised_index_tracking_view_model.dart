import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scm/app/di.dart';

import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/services/sharepreferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GeneralisedIndexTrackingViewModel extends IndexTrackingViewModel {
  // ApiService apiService = locator<ApiService>();
  DialogService dialogService = locator<DialogService>();

  bool isFloatingActionButtonVisible = true;
  bool isLocationServiceEnabled = false;
  NavigationService navigationService = locator<NavigationService>();
  final preferences = locator<AppPreferencesService>();
  SnackbarService snackBarService = locator<SnackbarService>();

  ///This will help in showing error snackbar
  ///If [onSnackBarOkButton] is not there then a normal error snackbar will be shown, otherwise snackbar will have an 'OK' button.
  ///
  void showErrorSnackBar({
    required String message,
    Function? onSnackBarOkButton,
  }) {
    if (onSnackBarOkButton != null) {
      snackBarService.showCustomSnackBar(
        variant: SnackbarType.ERROR,
        duration: const Duration(
          seconds: 4,
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
        duration: const Duration(
          seconds: 4,
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
  }) {
    snackBarService.showCustomSnackBar(
      variant: SnackbarType.NORMAL,
      duration: const Duration(
        seconds: 4,
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

  bool isDeoGd() {
    return preferences.getSelectedUserRole() ==
        AuthenticatedUserRoles.ROLE_GD.getStatusString;
  }
}
