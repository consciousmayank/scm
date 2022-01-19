import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/app_themes_types.dart';
import 'package:scm/screens/demand_module_screens/demand_module_landing_page_viewmodel.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/cart_icon/cart_icon_view.dart';
import 'package:scm/services/notification/fcm_permissions.dart';
import 'package:scm/services/notification/notification_icon/notification_icon_view.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_navigation_rail_widget.dart';
import 'package:scm/widgets/app_pop_up_menu_widget.dart';
import 'package:stacked/stacked.dart';

class DemandModuleLandingPageView extends StatefulWidget {
  const DemandModuleLandingPageView({
    Key? key,
  }) : super(key: key);

  @override
  _DemandModuleLandingPageViewState createState() =>
      _DemandModuleLandingPageViewState();
}

class _DemandModuleLandingPageViewState
    extends State<DemandModuleLandingPageView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebasePushNotificationsPermissions().getPermission();
  }

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
              color: Theme.of(context).colorScheme.background,
            ),
            selectedItemColor: Theme.of(context).colorScheme.background,
            selectedLabelStyle: AppTextStyles(context: context)
                .mobileBottomNavigationSelectedLAbelStyle,
            unselectedIconTheme: IconThemeData(
              color: Colors.grey.shade500,
              // size: 45,
            ),
            unselectedItemColor: Colors.grey.shade900,
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
    DemandModuleLandingPageViewModel viewModel,
  ) {
    return Scaffold(
      appBar: appbarWidget(context: context, title: 'Demand', options: [
        wSizedBox(width: 30),
        Center(child: Text('Hi, ${viewModel.authenticatedUserName}')),
        wSizedBox(width: 30),
        CartIconView(
          arguments: CartIconViewArguments(),
        ),
        wSizedBox(width: 30),
        viewModel.profileApiStatus == ApiStatus.FETCHED
            ? AppPopUpMenuWidget.withCircleAvatar(
                profileResponse: viewModel.supplyProfileResponse,
                onOptionsSelected: ({value}) =>
                    viewModel.actionPopUpItemSelected(selectedValue: value),
                options: profileOptions,
                toolTipLabel: popUpMenuLabelToolTip,
              )
            : Container(),
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
                text: labelDemandLandingPageCatalog,
                isTurned: true,
                icon: ImageIcon(
                  AssetImage(latestHomeIcon),
                ),
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
            currentIndex: viewModel.currentIndex,
            onNavigationIndexChanged: (int index) {
              viewModel.clickedOrderStatus = orderStatusAll;
              viewModel.setIndex(index);
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: viewModel.getSelectedView(),
            ),
          ),
        ],
      ),
    );
  }
}
