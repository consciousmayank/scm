import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/screens/pim_homescreen/pim_homescreen_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:stacked/stacked.dart';

class PimHomeScreenView extends StatelessWidget {
  const PimHomeScreenView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final PimHomeScreenViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PimHomeScreenViewModel>.reactive(
      onModelReady: (model) => model.initScreen(),
      builder: (context, model, child) => WillPopScope(
        child: Scaffold(
          appBar: appbarWidget(context: context, options: [
            wSizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onTap: () => model.logout(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: AppColors().black,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Hi, ${model.authenticatedUserName}'),
                        wSizedBox(
                          width: 20,
                        ),
                        const Icon(Icons.logout, color: Colors.white)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            wSizedBox(width: 10),
          ]),
          body: Row(
            children: [
              NavigationRail(
                  extended: model.navRailIsExtended,
                  trailing: Column(
                    children: [
                      hSizedBox(
                        height: 20,
                      ),
                      IconButton(
                        icon: model.navRailIsExtended
                            ? Icon(
                                Icons.keyboard_arrow_left_sharp,
                                color: AppColors().white,
                                size: 30,
                              )
                            : Icon(
                                Icons.keyboard_arrow_right_sharp,
                                color: AppColors().white,
                                size: 30,
                              ),
                        onPressed: () {
                          model.navRailIsExtended = !model.navRailIsExtended;
                          model.notifyListeners();
                        },
                      ),
                      hSizedBox(
                        height: 20,
                      ),
                    ],
                  ),
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
}

class PimHomeScreenViewArguments {}
