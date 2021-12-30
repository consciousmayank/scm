import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_index_tracking_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/demand_module_screens/suppliers_list/suppliers_list_view.dart';
import 'package:scm/screens/order_list_page/order_list_page_view.dart';
import 'package:scm/screens/pim_homescreen/change_password/change_password_dialog_box_view.dart';
import 'package:scm/services/app_api_service_classes/demand_cart_api.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/common_dashboard/dashboard_view.dart';
import 'package:stacked_services/stacked_services.dart';

class DemandModuleLandingPageViewModel
    extends GeneralisedIndexTrackingViewModel {
  String authenticatedUserName = '';
  String searchTerm = '';
  bool showProductList = false;

  final DemandCartApi _demandCartApi = di<DemandCartApi>();

  ApiStatus getCartApiStatus = ApiStatus.LOADING;

  initScreen() {
    authenticatedUserName = preferences.getAuthenticatedUserName();
    getCart();
  }

  void getCart() async {
    Cart cart = await _demandCartApi.getCart();
    preferences.setDemandersCart(cart: cart);
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
        ;

      case 1:
        // return const HomePageView();
        return const Center(
          child: Text(
            'Demander\'s Home Page',
          ),
        );

      case 2:
        // return ProductCategoriesListView();
        return SuppliersListView(
          arguments: SuppliersListViewArguments(),
        );

      case 3:
        // return OrderListView();
        return OrderListPageView(
          arguments: OrderListPageViewArguments(),
        );
      case 4:
        // return MenuItemsView();
        return const Center(
          child: Text(
            'Demander\'s More options Page',
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
