import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/screens/pim_homescreen/pim_homescreen_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/app_pop_up_menu_widget.dart';
import 'package:stacked/stacked.dart';

class PimHomeScreenView extends StatelessWidget {
  const PimHomeScreenView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final PimHomeScreenViewArguments arguments;

  getDeoDestinations({required bool isRotated}) {
    return [
      buildRotatedTextRailDestination(
        text: labelAddProducts,
        isTurned: isRotated,
      ),
      buildRotatedTextRailDestination(
        text: labelViewProducts,
        isTurned: isRotated,
      ),
    ];
  }

  getGdDestinations({required bool isRotated}) {
    return [
      buildRotatedTextRailDestination(
        text: labelViewProducts,
        isTurned: isRotated,
      ),
      buildRotatedTextRailDestination(
        text: labelAddBrandImages,
        isTurned: isRotated,
      ),
    ];
  }

  getSuperVisorDestinations({required bool isRotated}) {
    return [
      const NavigationRailDestination(
        selectedIcon: Icon(
          Icons.home,
        ),
        icon: Icon(
          Icons.home,
        ),
        label: SizedBox.shrink(),
        // label: Text("Home"),
      ),
      buildRotatedTextRailDestination(
        text: labelViewProducts,
        isTurned: isRotated,
      ),
      buildRotatedTextRailDestination(
        text: labelAddBrand,
        isTurned: isRotated,
      ),
      buildRotatedTextRailDestination(
        text: labelAddProducts,
        isTurned: isRotated,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PimHomeScreenViewModel>.reactive(
      onModelReady: (model) => model.initScreen(),
      builder: (context, model, child) => WillPopScope(
        child: Scaffold(
          appBar: appbarWidget(context: context, options: [
            wSizedBox(width: 10),
            Center(child: Text('Hi, ${model.authenticatedUserName}')),
            wSizedBox(width: 30),
            AppPopUpMenuWidget(
              onOptionsSelected: ({value}) =>
                  model.actionPopUpItemSelected(selectedValue: value),
              options: profileOptions,
              toolTipLabel: popUpMenuLabelToolTip,
            ),
            wSizedBox(width: 10),
          ]),
          body: Row(
            children: [
              NavigationRail(
                  extended: model.navRailIsExtended,
                  // trailing: Column(
                  //   children: [
                  //     hSizedBox(
                  //       height: 20,
                  //     ),
                  //     IconButton(
                  //       icon: model.navRailIsExtended
                  //           ? Icon(
                  //               Icons.keyboard_arrow_left_sharp,
                  //               color: AppColors().white,
                  //               size: 30,
                  //             )
                  //           : Icon(
                  //               Icons.keyboard_arrow_right_sharp,
                  //               color: AppColors().white,
                  //               size: 30,
                  //             ),
                  //       onPressed: () {
                  //         model.navRailIsExtended = !model.navRailIsExtended;
                  //         model.notifyListeners();
                  //       },
                  //     ),
                  //     hSizedBox(
                  //       height: 20,
                  //     ),
                  //   ],
                  // ),
                  groupAlignment: model.navRailIsExtended ? -1.0 : 1.0,
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  selectedLabelTextStyle:
                      Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.yellow,
                            decorationColor: Colors.yellow,
                            decoration: TextDecoration.overline,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                  unselectedLabelTextStyle:
                      Theme.of(context).textTheme.overline!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors().primaryColor.shade50,
                          ),
                  selectedIconTheme: const IconThemeData(
                    color: Colors.yellow,
                    size: 25,
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: AppColors().primaryColor.shade50,
                    size: 20,
                  ),
                  selectedIndex: model.currentIndex,
                  onDestinationSelected: (int index) {
                    model.setIndex(index);
                  },
                  labelType: model.navRailIsExtended
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  destinations: model.isDeo()
                      ? getDeoDestinations(isRotated: model.navRailIsExtended)
                      : model.isDeoGd()
                          ? getGdDestinations(
                              isRotated: model.navRailIsExtended)
                          : getSuperVisorDestinations(
                              isRotated: model.navRailIsExtended)),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: Center(
                  child: model.getSelectedView(),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () {
          return Future.value(false);
        },
      ),
      viewModelBuilder: () => PimHomeScreenViewModel(),
    );
  }
}

class PimHomeScreenViewArguments {}
