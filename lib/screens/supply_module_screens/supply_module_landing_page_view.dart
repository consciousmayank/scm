import 'package:flutter/material.dart';

import 'package:scm/app/appcolors.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/screens/not_supported_screens/not_supportd_screens.dart';
import 'package:scm/screens/supply_module_screens/supply_module_landing_page_viewmodel.dart';
import 'package:scm/services/notification/fcm_permissions.dart';
import 'package:scm/services/notification/notification_icon/notification_icon_view.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/animated_search_widget.dart';
import 'package:scm/widgets/app_bottom_navigation_bar_widget.dart';
import 'package:scm/widgets/app_navigation_rail_widget.dart';
import 'package:scm/widgets/app_pop_up_menu_widget.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';
import 'package:scm/widgets/version_widget/version_widget.dart';
import 'package:stacked/stacked.dart';

class SupplyModuleLandingPageView extends StatefulWidget {
  const SupplyModuleLandingPageView({
    Key? key,
  }) : super(key: key);

  @override
  _SupplyModuleLandingPageViewState createState() =>
      _SupplyModuleLandingPageViewState();
}

class _SupplyModuleLandingPageViewState
    extends State<SupplyModuleLandingPageView> {
  @override
  void initState() {
    super.initState();
    FirebasePushNotificationsPermissions().getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SupplyModuleLandingPageViewModel>.reactive(
      onModelReady: (model) => model.initScreen(),
      builder: (context, model, child) => ScreenTypeLayout.builder(
        mobile: (
          mobileViewContext,
        ) =>
            const NotSupportedScreensView(),
        desktop: (webViewContext) => const SupplyModuleLandingPageWebView(),
        tablet: (tabletViewContext) => const NotSupportedScreensView(),
      ),
      viewModelBuilder: () => SupplyModuleLandingPageViewModel(),
    );
  }
}

class SupplyModuleLandingPageMobileView
    extends ViewModelWidget<SupplyModuleLandingPageViewModel> {
  const SupplyModuleLandingPageMobileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
      BuildContext context, SupplyModuleLandingPageViewModel viewModel) {
    return Scaffold(
        appBar: appbarWidget(context: context, title: 'Supply', options: [
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
          child: AppBottomNavigationBarWidget(
            options: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(latestHomeIcon),
                  size: 25,
                ),
                label: labelSupplyLandingPageCatalog,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.api),
                label: labelSupplyLandingPageProduct,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(categoryIcon),
                  size: 25,
                ),
                label: labelSupplyLandingPageCategories,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(newOrderIcon),
                  size: 25,
                ),
                label: labelSupplyLandingPageOrder,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  orderReportImage,
                  height: 25,
                ),
                label: labelSupplyLandingPageReports,
              ),
            ],
            selectedIndex: viewModel.currentIndex,
            onSingleOptionClicked: (value) {
              viewModel.setIndex(value);
            },
            // elevation: 5,
          ),
        ));
  }
}

class SupplyModuleLandingPageWebView
    extends ViewModelWidget<SupplyModuleLandingPageViewModel> {
  const SupplyModuleLandingPageWebView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    SupplyModuleLandingPageViewModel viewModel,
  ) {
    return Scaffold(
      appBar: appbarWidget(
          context: context,
          title: viewModel.selectedOptionTitle(),
          options: [
            const VersionWidgetView(),
            wSizedBox(width: 10),
            // if (model.currentIndex != 0)
            AnimatedSearchWidget(
              hintText: labelSearchAllProducts,
              onSearch: ({required String searchTerm}) {
                viewModel.searchProducts(searchTerm: searchTerm);
              },
              onCrossButtonClicked: () {
                viewModel.clearSearch();
              },
            ),
            wSizedBox(width: 10),
            AppPopUpMenuWidget.withProfile(
              onOptionsSelected: ({value}) =>
                  viewModel.actionPopUpItemSelected(selectedValue: value),
              options: profileOptions,
              toolTipLabel:
                  'Hi, ${viewModel.supplyProfileResponse?.businessName}',
              profileResponse: viewModel.supplyProfileResponse,
            ),
            wSizedBox(width: 10),
          ]),
      body: Row(
        children: [
          AppNavigationRailWidget(
            leading: NotificationIconView(
              arguments: NotificationIconViewArguments(),
            ),
            destinations: [
              buildRotatedTextRailDestinationWithIcon(
                text: labelSupplyLandingPageCatalog,
                isTurned: true,
                icon: ImageIcon(
                  AssetImage(latestHomeIcon),
                ),
              ),
              buildRotatedTextRailDestinationWithIcon(
                text: labelSupplyLandingPageProduct,
                isTurned: true,
                icon: ImageIcon(
                  AssetImage(
                    newProductIcon,
                  ),
                ),
              ),
              buildRotatedTextRailDestinationWithIcon(
                isTurned: true,
                icon: ImageIcon(
                  AssetImage(catalogIcon),
                ),
                text: labelSupplyLandingPageMyCatalog,
              ),
              buildRotatedTextRailDestinationWithIcon(
                isTurned: true,
                icon: ImageIcon(
                  AssetImage(newOrderIcon),
                ),
                text: labelSupplyLandingPageOrder,
              ),
              buildRotatedTextRailDestinationWithIcon(
                isTurned: true,
                icon: const Icon(Icons.list),
                text: labelSupplyLandingPageReports,
              ),
            ],
            currentIndex: viewModel.currentIndex,
            onNavigationIndexChanged: (int index) {
              viewModel.clickedOrderStatus = orderStatusAll;
              viewModel.showProductList = false;
              viewModel.setIndex(index);
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child:
                  viewModel.showProductList && viewModel.searchTerm.length > 2
                      ? ProductListView(
                          key: UniqueKey(),
                          arguments: ProductListViewArgs.appbar(
                            brandsFilterList: [],
                            categoryFilterList: [],
                            subCategoryFilterList: [],
                            productTitle: viewModel.searchTerm,
                            supplierId: -1,
                          ),
                        )
                      : viewModel.getSelectedView(),
            ),
          ),
        ],
      ),
    );
  }
}
