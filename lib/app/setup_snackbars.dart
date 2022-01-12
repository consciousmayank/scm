import 'package:flutter/material.dart';
import 'package:scm/app/app.locator.dart';
import 'package:scm/app/apptheme.dart';
import 'package:scm/app/app.locator.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  SnackbarConfig config = SnackbarConfig(
    messageTextAlign: TextAlign.center,
    titleTextAlign: TextAlign.center,
    snackPosition: SnackPosition.TOP,
    isDismissible: true,
    padding: const EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 10,
    ),
    snackStyle: SnackStyle.GROUNDED,
    borderRadius: 0,
    animationDuration: const Duration(milliseconds: 200),
    // dismissDirection: SnackDismissDirection.VERTICAL,
  );

  SnackbarConfig errorConfig = SnackbarConfig(
    messageTextAlign: TextAlign.center,
    titleTextAlign: TextAlign.center,
    snackPosition: SnackPosition.TOP,
    isDismissible: false,
    titleColor: Colors.black,
    messageColor: Colors.black,
    padding: const EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 10,
    ),
    snackStyle: SnackStyle.GROUNDED,
    animationDuration: const Duration(milliseconds: 200),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.ERROR,
    config: errorConfig
      ..backgroundColor = Colors.white
      ..borderColor = Colors.black
      ..borderWidth = 1,
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.NORMAL,
    config: config
      ..backgroundColor = Colors.white
      ..textColor = Colors.black,
  );
}
