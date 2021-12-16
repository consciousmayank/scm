import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';

class AppInkwell extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const AppInkwell({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: AppColors().primaryColor.shade100,
      hoverColor: AppColors().primaryColor.shade50,
      splashColor: AppColors().white,
      child: child,
      onTap: onTap,
    );
  }
}
