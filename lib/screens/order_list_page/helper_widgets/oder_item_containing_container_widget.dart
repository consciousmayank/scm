import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';

class OrderItemContainerWidget extends StatelessWidget {
  const OrderItemContainerWidget({
    Key? key,
    this.padding = 16,
    required this.child,
  }) : super(key: key);

  const OrderItemContainerWidget.noPadding({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding == null
          ? null
          : const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            Dimens().getDefaultRadius,
          ),
        ),
        color: AppColors().white,
        border: Border.all(
          color: AppColors().orderDetailsContainerBg,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
