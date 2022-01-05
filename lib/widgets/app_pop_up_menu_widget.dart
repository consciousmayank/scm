import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';

class AppPopUpMenuWidget extends StatelessWidget {
  const AppPopUpMenuWidget({
    Key? key,
    required this.onOptionsSelected,
    required this.options,
    required this.toolTipLabel,
  }) : super(key: key);

  final Function({String? value}) onOptionsSelected;
  final List<String> options;
  final String toolTipLabel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimens().getDefaultRadius,
        ),
      ),
      elevation: Dimens().getDefaultElevation,
      color: Theme.of(context).colorScheme.secondaryVariant,
      tooltip: toolTipLabel,
      icon: Icon(
        Icons.more_vert,
        color: AppColors().white,
      ),
      itemBuilder: (context) {
        return options.map((String choice) {
          return PopupMenuItem(
            value: choice,
            child: Text(
              choice,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColors().white,
                  ),
            ),
          );
        }).toList();
      },
      onSelected: (String value) {
        onOptionsSelected(value: value);
      },
    );
  }
}
