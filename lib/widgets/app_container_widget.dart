import 'package:flutter/material.dart';

class AppContainerWidget extends StatelessWidget {
  const AppContainerWidget({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  final Widget child;
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
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryVariant,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: child,
    );
  }
}
