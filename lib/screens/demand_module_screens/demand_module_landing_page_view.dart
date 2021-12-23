import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/screens/demand_module_screens/demand_module_landing_page_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/animated_search_widget.dart';
import 'package:scm/widgets/app_pop_up_menu_widget.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';
import 'package:stacked/stacked.dart';

class DemandModuleLandingPageView extends StatefulWidget {
  final DemandModuleLandingPageViewArguments arguments;
  const DemandModuleLandingPageView({
    Key? key,
    required this.arguments,
  }) : super(key: key);
  @override
  _DemandModuleLandingPageViewState createState() =>
      _DemandModuleLandingPageViewState();
}

class _DemandModuleLandingPageViewState
    extends State<DemandModuleLandingPageView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DemandModuleLandingPageViewModel>.reactive(
      onModelReady: (model) => model.initScreen(),
      builder: (context, model, child) => ScreenTypeLayout.builder(
        mobile: (
          mobileViewContext,
        ) =>
            const SupplyModuleLandingPageMobileView(),
        desktop: (webViewContext) => const SupplyModuleLandingPageWebView(),
        tablet: (tabletViewContext) => const SupplyModuleLandingPageWebView(),
      ),
      viewModelBuilder: () => DemandModuleLandingPageViewModel(),
    );
  }
}

class SupplyModuleLandingPageMobileView
    extends ViewModelWidget<DemandModuleLandingPageViewModel> {
  const SupplyModuleLandingPageMobileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
      BuildContext context, DemandModuleLandingPageViewModel viewModel) {
    return Scaffold(
        appBar: appbarWidget(context: context, title: 'Demand', options: [
          wSizedBox(width: 10),
          AppPopUpMenuWidget(
            onOptionsSelected: ({value}) =>
                viewModel.actionPopUpItemSelected(selectedValue: value),
            options: profileOptions,
            toolTipLabel: popUpMenuLabelToolTip,
          ),
          wSizedBox(width: 10),
        ]),
        body: Center(
          child: viewModel.getSelectedView(),
        ),
        bottomNavigationBar: Container(
          // height: 40,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors().mobileNavigationShadowColor,
                blurRadius: 2,
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(latestHomeIcon),
                  size: 25,
                ),
                label: labelDemandLandingPageCatalog,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.api),
                label: labelDemandLandingPageCategories,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(categoryIcon),
                  size: 25,
                ),
                label: labelDemandLandingPageSuppliers,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(newOrderIcon),
                  size: 25,
                ),
                label: labelDemandLandingPageOrder,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: labelDemandLandingPageMore,
              ),
            ],
            type: BottomNavigationBarType.fixed,

            selectedIconTheme: IconThemeData(
              color: AppColors().primaryColor[500],
            ),
            selectedItemColor: AppColors().primaryColor[500],
            selectedLabelStyle: AppTextStyles(context: context)
                .mobileBottomNavigationSelectedLAbelStyle,
            unselectedIconTheme: IconThemeData(
              color: AppColors.shadesOfBlack[600],
              // size: 45,
            ),
            unselectedItemColor: AppColors.shadesOfBlack[900],
            unselectedLabelStyle: AppTextStyles(context: context)
                .mobileBottomNavigationUnSelectedLAbelStyle,
            currentIndex: viewModel.currentIndex,
            iconSize: 30,
            onTap: (value) {
              viewModel.setIndex(value);
            },
            // elevation: 5,
          ),
        ));
  }
}

class SupplyModuleLandingPageWebView
    extends ViewModelWidget<DemandModuleLandingPageViewModel> {
  const SupplyModuleLandingPageWebView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    DemandModuleLandingPageViewModel model,
  ) {
    return Scaffold(
      appBar: appbarWidget(context: context, title: 'Demand', options: [
        wSizedBox(width: 30),
        // if (model.currentIndex != 0)
        // AnimatedSearchWidget(
        //   hintText: labelSearchAllProducts,
        //   onSearch: ({required String searchTerm}) {
        //     model.searchProducts(searchTerm: searchTerm);
        //   },
        //   onCrossButtonClicked: () {
        //     model.clearSearch();
        //   },
        // ),
        // wSizedBox(width: 10),
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
            extended: false,
            groupAlignment: 1.0,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            selectedLabelTextStyle:
                Theme.of(context).textTheme.button!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
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
            labelType: NavigationRailLabelType.all,
            destinations: [
              buildRotatedTextRailDestinationWithIcon(
                text: labelDemandLandingPageCatalog,
                isTurned: true,
                icon: ImageIcon(
                  AssetImage(latestHomeIcon),
                ),
              ),
              buildRotatedTextRailDestinationWithIcon(
                text: labelDemandLandingPageCategories,
                isTurned: true,
                icon: const Icon(Icons.api),
              ),
              buildRotatedTextRailDestinationWithIcon(
                isTurned: true,
                icon: ImageIcon(
                  AssetImage(categoryIcon),
                ),
                text: labelDemandLandingPageSuppliers,
              ),
              buildRotatedTextRailDestinationWithIcon(
                isTurned: true,
                icon: ImageIcon(
                  AssetImage(newOrderIcon),
                ),
                text: labelDemandLandingPageOrder,
              ),
              buildRotatedTextRailDestinationWithIcon(
                isTurned: true,
                icon: const Icon(Icons.list),
                text: labelDemandLandingPageMore,
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child:
                  // model.showProductList && model.searchTerm.length > 2
                  // ? ProductListView(
                  //     key: UniqueKey(),
                  //     arguments: ProductListViewArguments.appbar(
                  //       brandsFilterList: [],
                  //       categoryFilterList: [],
                  //       subCategoryFilterList: [],
                  //       productTitle: model.searchTerm,
                  //       supplierId: -1,
                  //     ),
                  //   )
                  // :
                  model.getSelectedView(),
            ),
          ),
        ],
      ),
    );
  }
}

class DemandModuleLandingPageViewArguments {}
