import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  const DottedDivider({Key? key, this.padding}) : super(key: key);

  const DottedDivider.noPadding({
    this.padding = EdgeInsets.zero,
    Key? key,
  }) : super(key: key);

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 16.0, right: 16),
      child: DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 1.0,
        dashLength: 4.0,
        dashColor: Theme.of(context).colorScheme.primary,
        // dashGradient: [
        //   AppColors().primaryColor.shade100,
        //   AppColors().primaryColor.shade700,
        // ],
        dashRadius: 0.0,
        dashGapLength: 4.0,
        dashGapColor: Theme.of(context).colorScheme.background,
        // dashGapGradient: [
        //   AppColors().primaryColor.shade700,
        //   AppColors().primaryColor.shade100,
        // ],
        dashGapRadius: 0.0,
      ),
    );
  }
}
