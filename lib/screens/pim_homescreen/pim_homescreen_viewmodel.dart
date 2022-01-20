import 'package:flutter/material.dart';
import 'package:scm/routes/routes_constants.dart';

import 'package:scm/app/app.router.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/app/generalised_index_tracking_view_model.dart';

import 'package:scm/enums/dialog_type.dart';
import 'package:scm/enums/pim_product_list_types.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/screens/login/login_view.dart';
import 'package:scm/screens/pim_homescreen/add_brand/add_brand_view.dart';
import 'package:scm/screens/pim_homescreen/add_product/add_product_view.dart';
import 'package:scm/screens/pim_homescreen/change_password/change_password_dialog_box_view.dart';
import 'package:scm/screens/pim_homescreen/dashboard/pim_dashboard_view.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_view.dart';
import 'package:scm/screens/pim_homescreen/product_list_supervisor/product_list_supervisor_view.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/brands_dialog_box/brands_dialogbox_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:scm/app/di.dart';

class PimHomeScreenViewModel extends GeneralisedIndexTrackingViewModel {
  String authenticatedUserName = '';
  bool navRailIsExtended = false;

  void logout() {
    preferences.clearPreferences();
    locator<NavigationService>().pushNamedAndRemoveUntil(
      logInPageRoute,
      arguments: LoginViewArguments(
        arguments: LoginViewArgs(),
      ),
    );
  }

  getSelectedView() {
    if (isDeo()) {
      //if authenticated user is a DEO then show add product view, show product list view
      switch (currentIndex) {
        case 0:
          return AddProductView(
            arguments: AddProductViewArguments(
              productListType: PimProductListType.TODO,
            ),
          );

        case 1:
          return ProductsListView(
            arguments: ProductsListViewArguments(
              productListType: PimProductListType.TODO,
            ),
          );
        // case 2:
        //   return AddBrandView(
        //     arguments: AddBrandViewArguments(),
        //   );

        default:
          return AddProductView(
            arguments: AddProductViewArguments(
              productListType: PimProductListType.TODO,
            ),
          );
      }
    } else if (isDeoGd()) {
      //if authenticated user is a GD then show product list view, update brand view
      switch (currentIndex) {
        case 0:
          return ProductsListView(
            arguments: ProductsListViewArguments(
              productListType: PimProductListType.TODO,
            ),
          );
        case 1:
          return const Center(
            child: Text(
                'Coming soon this page will allow you to add images to brands.'),
          );

        default:
          return const Center(
            child: Text('You are not Authorised to view this page'),
          );
      }
    } else {
      //if authenticated user is a SUPERVISOR then show add product view, add brand view, product list view
      switch (currentIndex) {
        // case 0:
        // return const Center(
        //   child:
        //       Text('Coming Soon. Here all the stats will be shown to you.'),
        // );

        case 0:
          return PimDashboardView(
            arguments: PimDashboardViewArguments(),
          );
        case 1:
          return ProductListSupervisorView(
            arguments: ProductListSupervisorViewArguments(),
          );

        case 2:
          return AddBrandView(
            arguments: AddBrandViewArguments(),
          );
        case 3:
          return AddProductView(
            arguments: AddProductViewArguments(
              productListType: PimProductListType.TODO,
            ),
          );

        default:
          return ProductListSupervisorView(
            arguments: ProductListSupervisorViewArguments(),
          );
      }
    }
  }

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
}
