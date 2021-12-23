import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';

class AddProductButton extends StatelessWidget {
  AddProductButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    this.appButtonTypes = AppButtonTypes.LARGE,
  }) : super(key: key);

  AddProductButton.small({
    Key? key,
    required this.onTap,
    required this.buttonText,
    this.appButtonTypes = AppButtonTypes.SMALL,
  }) : super(key: key);

  final AppButtonTypes appButtonTypes;
  final String buttonText;
  final GestureTapCallback? onTap;

  double getButtonWidth() {
    switch (appButtonTypes) {
      case AppButtonTypes.SMALL:
        return 110;
        break;
      case AppButtonTypes.MEDIUM:
        return 100;
        break;
      case AppButtonTypes.LARGE:
        return double.infinity;
        break;

      default:
        return double.infinity;
    }
  }

  double getButtonHeight() {
    switch (appButtonTypes) {
      case AppButtonTypes.SMALL:
        return Dimens().buttonHeight * 0.50;
        break;
      case AppButtonTypes.MEDIUM:
        return Dimens().buttonHeight * 0.75;
        break;
      case AppButtonTypes.LARGE:
        return Dimens().buttonHeight;
        break;

      default:
        return Dimens().buttonHeight;
    }
  }

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
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: onTap != null
          ? () {
              onTap?.call();
            }
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            buttonText,
            style: getButtonTextStyle(
              context: context,
            ).copyWith(
                // fontSize: 18,
                color: AppColors().white,
                fontWeight: FontWeight.bold),
            // maxLines: 2,
            // textAlign: TextAlign.center,
          ),
          // wSizedBox(10),
          // Image.asset(
          //   addProductButtonIcon,
          //   color: AppColors.white,
          //   width: 15,
          //   height: 15,
          // ),
          // Icon(
          //   Icons.add,
          //   color: Colors.black,
          // ),
        ],
      ),
    );
  }
}

enum AppButtonTypes {
  SMALL,
  MEDIUM,
  LARGE,
}
