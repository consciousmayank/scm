import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';

class AppTextStyles {
  AppTextStyles({required this.context});

  final BuildContext context;

  TextStyle get getNormalTableNoValueTextStyle =>
      Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          );

  TextStyle get getNormalTableTextStyle =>
      Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          );

  TextStyle get getColumnWithTitleTextStyle =>
      Theme.of(context).textTheme.headline5!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          );

  TextStyle? get appbarTitle =>
      Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white);

  TextStyle? get appTextFieldHintStyle =>
      Theme.of(context).textTheme.subtitle2!.copyWith(
            color: Colors.black,
          );

  TextStyle? get appTextFieldHelperStyle =>
      Theme.of(context).textTheme.caption!.copyWith(
            color: Colors.green,
          );

  TextStyle? get appTextFieldTextStyle =>
      Theme.of(context).textTheme.subtitle1!.copyWith(
            color: Colors.black,
          );

  TextStyle? get appTextFieldErrorTextStyle =>
      Theme.of(context).textTheme.overline!.copyWith(
            color: Colors.red,
          );

  TextStyle? get appTextFieldPrefixTextStyle =>
      Theme.of(context).textTheme.overline!.copyWith(
            color: Colors.red,
          );

  TextStyle get getCounterTextStyle => Theme.of(context).textTheme.button!;

  TextStyle get tabSelectedLabelStyle =>
      Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.black,
          );

  TextStyle get tabUnselectedLabelStyle =>
      Theme.of(context).textTheme.bodyText2!;

  TextStyle get mobileBottomNavigationSelectedLAbelStyle => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.background,
      );

  TextStyle get mobileBottomNavigationUnSelectedLAbelStyle => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.background,
      );

  TextStyle get popularBrandsTitleStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  get productListItemWebCategoryTextStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      );

  get navigationRailUnSelectedLabelTextStyle =>
      Theme.of(context).textTheme.overline!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Theme.of(context).colorScheme.background,
          );

  get navigationRailSelectedLabelTextStyle =>
      Theme.of(context).textTheme.button!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.yellow,
            decorationColor: Colors.yellow,
            decoration: TextDecoration.overline,
            decorationStyle: TextDecorationStyle.wavy,
          );
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
