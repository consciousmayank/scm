import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/screens/not_supported_screens/not_supportd_screens.dart';
import 'package:scm/screens/pim_homescreen/pim_homescreen_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_navigation_rail_widget.dart';
import 'package:scm/widgets/app_pop_up_menu_widget.dart';
import 'package:stacked/stacked.dart';

class PimHomeScreenView extends StatelessWidget {
  const PimHomeScreenView({
    Key? key,
  }) : super(key: key);

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
        child: ScreenTypeLayout.builder(
          mobile: (BuildContext context) => const NotSupportedScreensView(),
          tablet: (BuildContext context) => const NotSupportedScreensView(),
          desktop: (BuildContext context) => Scaffold(
            appBar: appbarWidget(context: context, options: [
              AppPopUpMenuWidget.withName(
                onOptionsSelected: ({value}) =>
                    model.actionPopUpItemSelected(selectedValue: value),
                options: profileOptions,
                toolTipLabel: popUpMenuLabelToolTip,
                name: 'Hi, ${model.authenticatedUserName}',
              ),
              wSizedBox(width: 10),
            ]),
            body: Row(
              children: [
                AppNavigationRailWidget(
                  destinations: model.isDeo()
                      ? getDeoDestinations(
                          isRotated: model.navRailIsExtended,
                        )
                      : model.isDeoGd()
                          ? getGdDestinations(
                              isRotated: model.navRailIsExtended,
                            )
                          : getSuperVisorDestinations(
                              isRotated: model.navRailIsExtended,
                            ),
                  currentIndex: model.currentIndex,
                  onNavigationIndexChanged: (int index) {
                    model.setIndex(index);
                  },
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: Center(
                    child: model.getSelectedView(),
                  ),
                ),
              ],
            ),
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
