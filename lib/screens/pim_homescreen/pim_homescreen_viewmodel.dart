import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/app/generalised_index_tracking_view_model.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/pim_homescreen/add_brand/add_brand_view.dart';
import 'package:scm/screens/pim_homescreen/add_product/add_product_view.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_view.dart';
import 'package:scm/screens/pim_homescreen/product_list_supervisor/product_list_supervisor_view.dart';
import 'package:scm/widgets/brands_dialog_box/brands_dialogbox_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PimHomeScreenViewModel extends GeneralisedIndexTrackingViewModel {
  String authenticatedUserName = '';
  bool navRailIsExtended = false;

  void logout() {
    preferences.clearPreferences();
    di<NavigationService>().pushNamedAndRemoveUntil(logInPageRoute);
  }

  getSelectedView() {
    if (isDeo()) {
      //if authenticated user is a DEO then show add product view, show product list view
      switch (currentIndex) {
        case 0:
          return AddProductView(
            arguments: AddProductViewArguments(),
          );

        case 1:
          return ProductsListView(
            arguments: ProductsListViewArguments(
              productListType: ProductListType.TODO,
            ),
          );
        // case 2:
        //   return AddBrandView(
        //     arguments: AddBrandViewArguments(),
        //   );

        default:
          return AddProductView(
            arguments: AddProductViewArguments(),
          );
      }
    } else if (isDeoGd()) {
      //if authenticated user is a GD then show product list view, update brand view
      switch (currentIndex) {
        case 0:
          return ProductsListView(
            arguments: ProductsListViewArguments(
              productListType: ProductListType.TODO,
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
        case 0:
          return ProductListSuervisorView(
            arguments: ProductListSuervisorViewArguments(),
          );

        case 1:
          return AddBrandView(
            arguments: AddBrandViewArguments(),
          );
        case 2:
          return AddProductView(
            arguments: AddProductViewArguments(),
          );

        default:
          return ProductListSuervisorView(
            arguments: ProductListSuervisorViewArguments(),
          );
      }
    }
  }

  initScreen() {
    authenticatedUserName = preferences.getAuthenticatedUserName();
  }
}
