import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';

class AppInkwell extends StatelessWidget {
  const AppInkwell({Key? key, required this.child, required this.onTap})
      : isCustomBorder = false,
        super(key: key);

  const AppInkwell.withBorder(
      {Key? key, required this.child, required this.onTap})
      : isCustomBorder = true,
        super(key: key);

  final Function()? onTap;
  final Widget child;
  final bool isCustomBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: isCustomBorder
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
          : null,
      highlightColor: AppColors().white,
      hoverColor: AppColors().primaryColor.shade50,
      splashColor: AppColors().primaryColor.shade900,
      child: child,
      onTap: onTap,
    );
  }
}
