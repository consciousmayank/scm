import 'package:flutter/material.dart';

class AppContainerWidget extends StatelessWidget {
  const AppContainerWidget({
    Key? key,
    required this.child,
    this.padding,
  })  : filledColor = null,
        super(key: key);

  const AppContainerWidget.customFilledColor({
    Key? key,
    required this.child,
    required this.filledColor,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final Color? filledColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 2,
            bottom: 2,
          ),
      decoration: BoxDecoration(
        color: filledColor ?? Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryVariant,
          width: 0.5,
          style: BorderStyle.solid,
        ),
      ),
      child: child,
    );
  }
}
