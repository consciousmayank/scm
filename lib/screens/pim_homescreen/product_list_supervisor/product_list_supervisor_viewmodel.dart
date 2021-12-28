import 'package:flutter/material.dart';
import 'package:scm/app/generalised_index_tracking_view_model.dart';
import 'package:scm/enums/pim_product_list_types.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_view.dart';

class ProductListSupervisorViewModel extends GeneralisedIndexTrackingViewModel {
  // bool navRailIsExtended = false;

  getSelectedView() {
    switch (currentIndex) {
      case 0:
        return ProductsListView(
          key: UniqueKey(),
          arguments: ProductsListViewArguments(
            productListType: PimProductListType.TODO,
          ),
        );

      case 1:
        return ProductsListView(
          key: UniqueKey(),
          arguments: ProductsListViewArguments(
            productListType: PimProductListType.PUBLISHED,
          ),
        );

      case 2:
        return ProductsListView(
          key: UniqueKey(),
          arguments: ProductsListViewArguments(
            productListType: PimProductListType.DISCARDED,
          ),
        );

      default:
        return ProductsListView(
          arguments: ProductsListViewArguments(
            productListType: PimProductListType.TODO,
          ),
        );
    }
  }
}
