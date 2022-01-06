import 'package:flutter/material.dart';
import 'package:scm/app/generalised_index_tracking_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
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
  String searchTerm = '';
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
        return CommonDashboardView(arguments: CommonDashboardViewArguments());

      case 1:
        // return const SupplyProductsOptionsPageView();
        return const SuppplierProfileView(
          arguments: SuppplierProfileViewArguments(
            selectedSupplier: null,
          ),
        );

      case 2:
        // return ProductCategoriesListView();
        return SuppplierProfileView(
          key: UniqueKey(),
          arguments: const SuppplierProfileViewArguments.catalog(),
        );

      case 3:
        // return OrderListView();
        return OrderListPageView(arguments: OrderListPageViewArguments());
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
