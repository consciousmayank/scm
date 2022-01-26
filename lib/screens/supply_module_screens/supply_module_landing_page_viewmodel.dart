import 'package:flutter/material.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/app/app.router.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_index_tracking_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/model_classes/supply_profile_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/demand_module_screens/supplier_profile/supplier_profile_view.dart';
import 'package:scm/screens/login/login_view.dart';
import 'package:scm/screens/more_options/more_options_view.dart';
import 'package:scm/screens/order_list_page/order_list_page_view.dart';
import 'package:scm/screens/pim_homescreen/change_password/change_password_dialog_box_view.dart';
import 'package:scm/services/app_api_service_classes/profile_apis.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/common_dashboard/dashboard_view.dart';
import 'package:stacked_services/stacked_services.dart';

class SupplyModuleLandingPageViewModel
    extends GeneralisedIndexTrackingViewModel {
  String authenticatedUserName = '';
  String clickedOrderStatus = orderStatusAll;
  ApiStatus profileApiStatus = ApiStatus.LOADING;
  String searchTerm = '';
  Order? selectedOrder;
  bool showProductList = false;
  SupplyProfileResponse? supplyProfileResponse;

  final ProfileApis _profileApis = locator<ProfileApisImpl>();

  initScreen() {
    authenticatedUserName = preferences.getAuthenticatedUserName();
    getProfile();
  }

  void getProfile() async {
    supplyProfileResponse = await _profileApis.getSupplierProfile();
    if (supplyProfileResponse != null &&
        supplyProfileResponse!.businessName != null &&
        supplyProfileResponse!.businessName!.isNotEmpty) {
      authenticatedUserName = supplyProfileResponse!.businessName!;
      profileApiStatus = ApiStatus.FETCHED;
      notifyListeners();
    }

    getCatalogProducts();
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
      arguments: LoginViewArgs(),
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

    if (changePasswordDialogResponse != null &&
        changePasswordDialogResponse.confirmed) {
      await dialogService.showDialog(
        title: passwordChangedTitle,
        description: passwordChangedDescription,
        buttonTitle: labelOk,
        dialogPlatform: DialogPlatform.Material,
      );
    }
  }

  String selectedOptionTitle() {
    switch (currentIndex) {
      case 0:
        return supplyModuleLandingPageHomeTitle;

      case 1:
        // return const SupplyProductsOptionsPageView();
        return supplyModuleLandingPageProductsTitle;

      case 2:
        // return ProductCategoriesListView();
        return supplyModuleLandingPageCatalogTitle;

      case 3:
        // return OrderListView();
        return supplyModuleLandingPageOrdersTitle;
      case 4:
        // return MenuItemsView();
        return supplyModuleLandingPageMoreTitle;
      default:
        return '';
    }
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
        return MoreOptionsView(
          arguments: MoreOptionsViewArguments(),
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

  void getCatalogProducts() async {
    if (supplyProfileResponse != null && supplyProfileResponse!.id != null) {
      await _profileApis.getCatalog(
        supplierId: supplyProfileResponse!.id!,
      );
    }
  }
}
