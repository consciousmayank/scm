import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    this.appButtonTypes = AppButtonTypes.LARGE,
    this.enabled = true,
  }) : super(key: key);

  const AppButton.small({
    Key? key,
    required this.onTap,
    required this.buttonText,
    this.appButtonTypes = AppButtonTypes.SMALL,
    this.enabled = true,
  }) : super(key: key);

  final AppButtonTypes appButtonTypes;
  final String buttonText;
  final bool enabled;
  final GestureTapCallback onTap;

  // double getButtonWidth() {
  //   switch (appButtonTypes) {
  //     case AppButtonTypes.SMALL:
  //       return 110;
  //     case AppButtonTypes.MEDIUM:
  //       return 100;
  //     case AppButtonTypes.LARGE:
  //       return double.infinity;
  //     default:
  //       return double.infinity;
  //   }
  // }

  // double getButtonHeight() {
  //   switch (appButtonTypes) {
  //     case AppButtonTypes.SMALL:
  //       return buttonHeight * 0.50;
  //     case AppButtonTypes.MEDIUM:
  //       return buttonHeight * 0.75;
  //     case AppButtonTypes.LARGE:
  //       return buttonHeight;
  //     default:
  //       return buttonHeight;
  //   }
  // }

  TextStyle getButtonTextStyle({
    required BuildContext context,
  }) {
    switch (appButtonTypes) {
      case AppButtonTypes.SMALL:
        return Theme.of(context).textTheme.caption!;
      case AppButtonTypes.MEDIUM:
        return Theme.of(context).textTheme.button!;
      case AppButtonTypes.LARGE:
        return Theme.of(context).textTheme.bodyText1!;
      default:
        return Theme.of(context).textTheme.caption!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: AppTextButtonsStyles(context: context).elevatedTextButtonStyle,
      onPressed: enabled
          ? () {
              onTap.call();
            }
          : null,
      child: Text(
        buttonText,
        style: getButtonTextStyle(
          context: context,
        ).copyWith(
          // fontSize: 8,
          color: AppColors().white,
        ),
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}

enum AppButtonTypes {
  SMALL,
  MEDIUM,
  LARGE,
}
