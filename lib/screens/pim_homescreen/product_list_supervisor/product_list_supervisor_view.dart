import 'package:flutter/material.dart';
import 'package:scm/screens/pim_homescreen/product_list_supervisor/product_list_supervisor_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_navigation_rail_widget.dart';
import 'package:stacked/stacked.dart';

class ProductListSupervisorView extends StatelessWidget {
  const ProductListSupervisorView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ProductListSupervisorViewArguments arguments;

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
              AppNavigationRailWidget(
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
                  buildRotatedTextRailDestination(
                    turn: 1,
                    text: discardedProductsListPageTitle,
                    isTurned: false,
                  ),
                ],
                currentIndex: model.currentIndex,
                onNavigationIndexChanged: (int index) {
                  model.setIndex(index);
                  model.notifyListeners();
                },
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
