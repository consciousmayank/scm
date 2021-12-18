import 'package:flutter/material.dart';

class DashboardSubViewsTitleWidget extends StatelessWidget {
  const DashboardSubViewsTitleWidget({
    Key? key,
    required this.titleText,
  }) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
