import 'package:flutter/services.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GeneralisedBaseViewModel extends BaseViewModel {
  // ApiService apiService = locator<ApiService>();
  DialogService dialogService = di<DialogService>();

  bool isFloatingActionButtonVisible = true;
  bool isLocationServiceEnabled = false;
  NavigationService navigationService = di<NavigationService>();
  final preferences = di<AppPreferences>();
  SnackbarService snackBarService = di<SnackbarService>();

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
}
