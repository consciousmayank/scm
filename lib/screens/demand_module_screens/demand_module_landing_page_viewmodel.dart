import 'package:flutter/material.dart';

import 'package:scm/app/app.router.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_index_tracking_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/model_classes/supply_profile_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/demand_module_screens/suppliers_list/suppliers_list_view.dart';
import 'package:scm/screens/login/login_view.dart';
import 'package:scm/screens/order_list_page/order_list_page_view.dart';
import 'package:scm/screens/pim_homescreen/change_password/change_password_dialog_box_view.dart';
import 'package:scm/services/app_api_service_classes/demand_cart_api.dart';
import 'package:scm/services/app_api_service_classes/profile_apis.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/common_dashboard/dashboard_view.dart';
import 'package:stacked_services/stacked_services.dart';

class DemandModuleLandingPageViewModel
    extends GeneralisedIndexTrackingViewModel {
  String authenticatedUserName = '';
  String clickedOrderStatus = orderStatusAll;
  ApiStatus getCartApiStatus = ApiStatus.LOADING;
  String searchTerm = '';
  Order? selectedOrder;
  bool showProductList = false;

  final DemandCartApi _demandCartApi = locator<DemandCartApi>();

  initScreen() {
    // setIndex(2);
    authenticatedUserName = preferences.getAuthenticatedUserName();
    getProfile();
    getCart();
  }

  void getCart() async {
    Cart cart = await _demandCartApi.getCart();
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
    navigationService.pushNamedAndRemoveUntil(
      logInPageRoute,
      arguments: LoginViewArguments(
        arguments: LoginViewArgs(),
      ),
    );
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
            onClickOfOrder: ({required Order clickedOrder}) {
              selectedOrder = clickedOrder;
              setIndex(2);
            },
            onClickOfOrderTile: ({required String clickedOrderStatus}) {
              this.clickedOrderStatus = clickedOrderStatus;
              clickedOrderStatus = orderStatusAll;
              setIndex(2);
            },
          ),
        );

      case 1:
        // return ProductCategoriesListView();
        return SuppliersListView(
          arguments: SuppliersListViewArguments(),
        );

      case 2:
        // return OrderListView();
        return OrderListPageView(
          arguments: OrderListPageViewArguments(
            preDefinedOrderStatus: clickedOrderStatus,
            selectedOrder: selectedOrder,
          ),
        );
      case 3:
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

  final ProfileApis _profileApis = locator<ProfileApisImpl>();
  SupplyProfileResponse? supplyProfileResponse;
  ApiStatus profileApiStatus = ApiStatus.LOADING;
  void getProfile() async {
    supplyProfileResponse = await _profileApis.getSupplierProfile();
    if (supplyProfileResponse != null &&
        supplyProfileResponse!.businessName != null &&
        supplyProfileResponse!.businessName!.isNotEmpty) {
      authenticatedUserName = supplyProfileResponse!.businessName!;
      profileApiStatus = ApiStatus.FETCHED;
      notifyListeners();
    }
  }
}
