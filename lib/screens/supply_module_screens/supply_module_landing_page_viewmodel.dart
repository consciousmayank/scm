import 'package:flutter/material.dart';
import 'package:scm/app/generalised_index_tracking_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/demand_module_screens/supplier_profile/supplier_profile_view.dart';
import 'package:scm/screens/order_list_page/order_list_page_view.dart';
import 'package:scm/screens/pim_homescreen/change_password/change_password_dialog_box_view.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/common_dashboard/dashboard_view.dart';
import 'package:stacked_services/stacked_services.dart';

class SupplyModuleLandingPageViewModel
    extends GeneralisedIndexTrackingViewModel {
  String authenticatedUserName = '';
  String clickedOrderStatus = orderStatusAll;
  String searchTerm = '';
  Order? selectedOrder;
  bool showProductList = false;

  initScreen() {
    authenticatedUserName = preferences.getAuthenticatedUserName();
  }

  actionPopUpItemSelected({String? selectedValue}) {
    if (selectedValue == null) return;
    switch (selectedValue) {
      case popUpMenuLabelLogout:
        logout();
        break;

      case popUpMenuLabelChangePassword:
        changePassword();
        break;
    }
  }

  void logout() {
    preferences.clearPreferences();
    navigationService.pushNamedAndRemoveUntil(logInPageRoute);
  }

  void changePassword() async {
    DialogResponse? changePasswordDialogResponse =
        await dialogService.showCustomDialog(
      variant: DialogType.ChANGE_PASSWORD,
      data: ChangePasswordViewDialogBoxViewArguments(
        title: popUpMenuLabelChangePassword,
      ),
      barrierDismissible: true,
    );
  }

  getSelectedView() {
    switch (currentIndex) {
      case 0:
        return CommonDashboardView(
            arguments: CommonDashboardViewArguments(
          onClickOfOrderTile: ({required String clickedOrderStatus}) {
            this.clickedOrderStatus = clickedOrderStatus;
            setIndex(3);
          },
          onClickOfOrder: ({required Order clickedOrder}) {
            selectedOrder = clickedOrder;
            clickedOrderStatus = orderStatusAll;
            setIndex(3);
          },
        ));

      case 1:
        // return const SupplyProductsOptionsPageView();
        return const SuppplierProfileView(
          arguments: SuppplierProfileViewArguments.allProductsForSupplier(),
        );

      case 2:
        // return ProductCategoriesListView();
        return SuppplierProfileView(
          key: UniqueKey(),
          arguments: const SuppplierProfileViewArguments.catalog(),
        );

      case 3:
        // return OrderListView();
        return OrderListPageView(
          arguments: OrderListPageViewArguments(
            preDefinedOrderStatus: clickedOrderStatus,
            selectedOrder: selectedOrder,
          ),
        );
      case 4:
        // return MenuItemsView();
        return const Center(
          child: Text(
            'Supplier\'s More options Page',
          ),
        );
    }
  }

  void searchProducts({required String searchTerm}) {
    if (searchTerm.isEmpty) {
      showProductList = false;
    } else {
      showProductList = true;
      this.searchTerm = searchTerm;
    }
    notifyListeners();
  }

  void clearSearch() {
    showProductList = false;
    notifyListeners();
  }
}
