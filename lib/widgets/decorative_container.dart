import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';

class DecorativeContainer extends StatelessWidget {
  const DecorativeContainer({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  const DecorativeContainer.transparent({
    Key? key,
    required this.child,
    this.color = Colors.transparent,
  }) : super(key: key);

  const DecorativeContainer.withColor({
    Key? key,
    required this.child,
    required this.color,
  }) : super(key: key);

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColorLight,
      ),
      padding: EdgeInsets.all(
        Dimens().getDecoratedContainerDefaultPadding,
      ),
      child: child,
    );
  }
}
