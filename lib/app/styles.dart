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

  TextStyle get appTextButtonStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors().white,
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

class AppTextButtonsStyles {
  AppTextButtonsStyles({
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
    this.fontSize,
    required this.context,
  });

  final Color? foregroundColor, backgroundColor;
  BuildContext context;
  final double? fontSize;
  final EdgeInsets? padding;

  ButtonStyle get textButtonStyleForProductListItem =>
      textButtonStyle.copyWith(shape: MaterialStateProperty.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  Dimens().defaultBorder / 2,
                ),
                bottomRight: Radius.circular(
                  Dimens().defaultBorder / 2,
                ),
              ),
            );
          } else {
            return RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.background,
                width: Dimens().defaultBorder / 2,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  Dimens().defaultBorder / 2,
                ),
                bottomRight: Radius.circular(
                  Dimens().defaultBorder / 2,
                ),
              ),
            );
          }
        },
      ), side: MaterialStateProperty.resolveWith<BorderSide>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(
            width: 0.0,
            color: Theme.of(context).colorScheme.background,
          );
        }
        return BorderSide(
          width: 0,
          color: foregroundColor ?? Theme.of(context).colorScheme.secondary,
        ); // Defer to the widget's default.
      }), textStyle: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const TextStyle(
            fontSize: 16,
          );
        }
        return const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
      }));

  ButtonStyle get textButtonStyle => ButtonStyle(
        side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return const BorderSide(
              width: 0.5,
              color: Colors.transparent,
            );
          }
          return BorderSide(
            width: 0,
            color: foregroundColor ?? Theme.of(context).colorScheme.secondary,
          ); // Defer to the widget's default.
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }
          return backgroundColor ??
              Theme.of(context)
                  .colorScheme
                  .secondary
                  .withAlpha(100); // Defer to the widget's default.
        }),
        padding: MaterialStateProperty.all(
          padding ?? Dimens().appTextButtonPadding,
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
              color: Theme.of(context).colorScheme.secondary,
            );
          }
          return BorderSide(
            width: 2,
            color: foregroundColor ?? Theme.of(context).colorScheme.secondary,
          ); // Defer to the widget's default.
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }
          return backgroundColor ??
              Theme.of(context)
                  .colorScheme
                  .secondaryVariant; // Defer to the widget's default.
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }
          return backgroundColor ??
              Theme.of(context)
                  .colorScheme
                  .primary; // Defer to the widget's default.
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
        // foregroundColor: MaterialStateProperty.resolveWith<Color>(
        //     (Set<MaterialState> states) {
        //   if (states.contains(MaterialState.disabled)) {
        //     return backgroundColor ??
        //         Theme.of(context).colorScheme.secondary.withAlpha(150);
        //   }
        //   return backgroundColor ??
        //       Theme.of(context)
        //           .colorScheme
        //           .secondary; // Defer to the widget's default.
        // }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return backgroundColor ??
                Theme.of(context).colorScheme.secondaryVariant.withAlpha(150);
          }
          return backgroundColor ??
              Theme.of(context)
                  .colorScheme
                  .secondary; // Defer to the widget's default.
        }),
        padding: MaterialStateProperty.all(
          padding ?? Dimens().appTextButtonPadding,
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
