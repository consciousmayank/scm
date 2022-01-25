import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/model_classes/supply_profile_response.dart';

class AppPopUpMenuWidget<T> extends StatelessWidget {
  const AppPopUpMenuWidget(
      {Key? key,
      required this.onOptionsSelected,
      required this.options,
      required this.toolTipLabel,
      this.mainIconColor = Colors.white})
      : profileResponse = null,
        super(key: key);

  const AppPopUpMenuWidget.withCircleAvatar(
      {Key? key,
      required this.onOptionsSelected,
      required this.options,
      required this.toolTipLabel,
      required this.profileResponse,
      this.mainIconColor = Colors.white})
      : super(key: key);

  final Function({String? value}) onOptionsSelected;
  final Color mainIconColor;
  final List<String> options;
  final SupplyProfileResponse? profileResponse;
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
      color: Theme.of(context).colorScheme.primary,
      tooltip: toolTipLabel,
      icon: Icon(
        Icons.more_vert,
        color: mainIconColor,
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
