import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/appcolors.dart';

class Dimens {
  double get buttonHeight => 50;

  double get getDefaultRadius => 5;

  double get getColumnWithTitleHeaderPadding => 16;

  get appTextButtonDefaultFontSize => 18.00;

  get appTextButtonPadding => const EdgeInsets.all(16.00);

  get getDefaultElevation => 8;

  get pageTitleHeadingStyle => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors().black,
      );

  TextStyle get pageSubTitleHeadingStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors().black,
      );

  double get appTextButtonBorderRadius => getDefaultRadius * 2;

  get getDecoratedContainerDefaultColor => AppColors().primaryColor.shade200;

  double get getDecoratedContainerDefaultPadding => 8;

  double get defaultBorder => 32;

  getBorderRadius({double? radius}) {
    return BorderRadius.circular(
      radius ?? getDefaultRadius,
    );
  }

  RoundedRectangleBorder getCardShape({double? radius}) {
    return RoundedRectangleBorder(
      borderRadius: getBorderRadius(
        radius: radius,
      ),
    );
  }

  TextInputFormatter get getNumericTextInputFormatter =>
      FilteringTextInputFormatter.allow(
        RegExp(r'[0-9]'),
      );

  TextInputFormatter get numericWithDecimalFormatter =>
      FilteringTextInputFormatter.allow(
        RegExp(r'^\d+\.?\d{0,2}'),
      );

  TextInputFormatter get alphaNumericWithSpaceSlashHyphenUnderScoreFormatter =>
      FilteringTextInputFormatter.allow(
        RegExp(r'[a-zA-Z0-9 -/_]'),
      );

  TextInputFormatter get alphabeticFormatter =>
      FilteringTextInputFormatter.allow(
        RegExp(r'[a-zA-Z ]'),
      );
}
