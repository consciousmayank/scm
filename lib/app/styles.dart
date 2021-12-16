import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
      Theme.of(context).textTheme.headline6!.copyWith(
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
}

class AppTextButtonsStyles {
  AppTextButtonsStyles({
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
    this.fontSize,
  });

  final Color? foregroundColor, backgroundColor;
  final double? fontSize;
  final EdgeInsets? padding;

  ButtonStyle get textButtonStyle => ButtonStyle(
        side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return BorderSide(
              width: 0.5,
              color: AppColors().primaryColor.shade100,
            );
          }
          return BorderSide(
            width: 1,
            color: foregroundColor ?? AppColors().appTextButtonForegroundColor,
          ); // Defer to the widget's default.
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return foregroundColor == null
                ? Colors.grey
                : foregroundColor!.withAlpha(100);
          }
          return foregroundColor ??
              AppColors()
                  .appTextButtonForegroundColor; // Defer to the widget's default.
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }
          return backgroundColor ??
              AppColors()
                  .appTextButtonBackgroundColor; // Defer to the widget's default.
        }),
        padding: MaterialStateProperty.all(
          padding ?? Dimens().appTextButtonPadding,
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return TextStyle(
                fontSize:
                    (fontSize ?? Dimens().appTextButtonDefaultFontSize) - 2,
                color: AppColors().white,
              );
            } else {
              return TextStyle(
                fontSize: fontSize ?? Dimens().appTextButtonDefaultFontSize,
                color: AppColors().white,
              );
            }
          },
        ),
        shape: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Dimens().appTextButtonBorderRadius),
              );
            } else {
              return RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Dimens().appTextButtonBorderRadius),
              );
            }
          },
        ),
      );

  ButtonStyle get outlinedTextButtonStyle => ButtonStyle(
        side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return BorderSide(
              width: 0.5,
              color: AppColors().primaryColor.shade100,
            );
          }
          return BorderSide(
            width: 1,
            color: foregroundColor ?? AppColors().appTextButtonForegroundColor,
          ); // Defer to the widget's default.
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }
          return backgroundColor ??
              AppColors()
                  .appTextButtonBackgroundColor; // Defer to the widget's default.
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }
          return backgroundColor ??
              AppColors()
                  .appOutlinedTextButtonBackgroundColor; // Defer to the widget's default.
        }),
        padding: MaterialStateProperty.all(
          padding ?? Dimens().appTextButtonPadding,
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return TextStyle(
                fontSize:
                    (fontSize ?? Dimens().appTextButtonDefaultFontSize) - 2,
              );
            } else {
              return TextStyle(
                fontSize: fontSize ?? Dimens().appTextButtonDefaultFontSize,
              );
            }
          },
        ),
      );

  ButtonStyle get elevatedTextButtonStyle => ButtonStyle(
        elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return 2;
          }
          return 4; // Defer to the widget's default.
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return backgroundColor ??
                AppColors().appOutlinedTextButtonBackgroundColor;
          }
          return backgroundColor ??
              AppColors()
                  .appOutlinedTextButtonBackgroundColor; // Defer to the widget's default.
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return backgroundColor ??
                AppColors().appOutlinedTextButtonBackgroundColor;
          }
          return backgroundColor ??
              AppColors()
                  .appOutlinedTextButtonBackgroundColor; // Defer to the widget's default.
        }),
        padding: MaterialStateProperty.all(
          padding ?? Dimens().appTextButtonPadding,
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return TextStyle(
                fontSize:
                    (fontSize ?? Dimens().appTextButtonDefaultFontSize) - 2,
                color: Colors.black,
              );
            } else {
              return TextStyle(
                  fontSize: fontSize ?? Dimens().appTextButtonDefaultFontSize,
                  fontWeight: FontWeight.bold);
            }
          },
        ),
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
