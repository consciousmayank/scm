import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';

class AppInkwell extends StatelessWidget {
  const AppInkwell({
    Key? key,
    required this.child,
    this.onHover,
    required this.onTap,
  })  : isCustomBorder = false,
        borderderRadius = null,
        super(key: key);

  const AppInkwell.withBorder({
    Key? key,
    required this.child,
    required this.onTap,
    this.onHover,
    this.borderderRadius,
  })  : isCustomBorder = true,
        super(key: key);

  final Function()? onTap;
  final ValueChanged<bool>? onHover;
  final BorderRadiusGeometry? borderderRadius;
  final Widget child;
  final bool isCustomBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: onHover,
      customBorder: isCustomBorder
          ? RoundedRectangleBorder(
              borderRadius: borderderRadius ?? BorderRadius.circular(50),
            )
          : null,
      highlightColor: Theme.of(context).highlightColor,
      hoverColor: Theme.of(context).colorScheme.secondaryVariant,
      splashColor: Theme.of(context).splashColor,
      child: child,
      onTap: onTap,
    );
  }
}
