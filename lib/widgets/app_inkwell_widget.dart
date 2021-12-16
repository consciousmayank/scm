import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';

class AppInkwell extends StatelessWidget {
  final bool isCustomBorder;
  final Widget child;
  final Function()? onTap;
  const AppInkwell({
    Key? key,
    required this.child,
    this.isCustomBorder = false,
    this.onTap,
  }) : super(key: key);
  const AppInkwell.withBorder({
    Key? key,
    required this.child,
    this.isCustomBorder = true,
    this.onTap,
  }) : super(key: key);

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
