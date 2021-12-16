import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_view.dart';
import 'package:scm/screens/pim_homescreen/product_list_supervisor/product_list_supervisor_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:stacked/stacked.dart';

class ProductListSupervisorView extends StatelessWidget {
  final ProductListSupervisorViewArguments arguments;
  const ProductListSupervisorView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductListSupervisorViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        child: Scaffold(
          body: Row(
            children: [
              Expanded(
                child: Center(
                  child: model.getSelectedView(),
                ),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              NavigationRail(
                extended: false,
                groupAlignment: 1.0,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
                  model.notifyListeners();
                },
                labelType: NavigationRailLabelType.all,
                destinations: [
                  buildRotatedTextRailDestination(
                    turn: 1,
                    text: todoProductsListPageTitle,
                    isTurned: false,
                  ),
                  buildRotatedTextRailDestination(
                    turn: 1,
                    text: publishedProductsListPageTitle,
                    isTurned: false,
                  ),
                ],
              ),
            ],
          ),
        ),
        onWillPop: () {
          return Future.value(false);
        },
      ),
      viewModelBuilder: () => ProductListSupervisorViewModel(),
    );
  }
}

class ProductListSupervisorViewArguments {}
