import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/model_classes/supply_profile_response.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';

enum AppPopUpMenuMainIconType {
  POP_MENU_WITH_PROFILE_IMAGE,
  POP_MENU_WITH_NAME,
  POP_MENU,
}

class AppPopUpMenuWidget extends StatelessWidget {
  const AppPopUpMenuWidget({
    Key? key,
    required this.onOptionsSelected,
    required this.options,
    required this.toolTipLabel,
    this.mainIconColor = Colors.white,
  })  : profileResponse = null,
        mainIconType = AppPopUpMenuMainIconType.POP_MENU,
        name = null,
        super(key: key);

  const AppPopUpMenuWidget.withName({
    Key? key,
    required this.onOptionsSelected,
    required this.options,
    required this.toolTipLabel,
    this.mainIconColor = Colors.white,
    required this.name,
  })  : profileResponse = null,
        mainIconType = AppPopUpMenuMainIconType.POP_MENU_WITH_NAME,
        super(key: key);

  const AppPopUpMenuWidget.withProfile({
    Key? key,
    required this.onOptionsSelected,
    required this.options,
    required this.toolTipLabel,
    required this.profileResponse,
    this.mainIconColor = Colors.white,
  })  : mainIconType = AppPopUpMenuMainIconType.POP_MENU_WITH_PROFILE_IMAGE,
        name = null,
        super(key: key);

  final Function({String? value}) onOptionsSelected;
  final Color mainIconColor;
  final AppPopUpMenuMainIconType mainIconType;
  final String? name;
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
      color: Theme.of(context).primaryColorLight,
      tooltip: toolTipLabel,
      offset: Offset(AppBar().preferredSize.height, 0),
      child: profileResponse != null
          ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: mainIconType == AppPopUpMenuMainIconType.POP_MENU_WITH_NAME
                  ? Text(
                      name ?? '',
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  : ProfileImageWidget.withCurvedBorder(
                      elevation: 4,
                      borderDerRadius: BorderRadius.circular(32),
                      imageUrlString: profileResponse!.image,
                    ),
            )
          : null,
      icon: profileResponse == null
          ? Icon(
              Icons.more_vert,
              color: mainIconColor,
            )
          : null,
      itemBuilder: (context) {
        return options.map((String choice) {
          return PopupMenuItem(
            value: choice,
            child: Text(
              choice,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColors().black,
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
