import 'package:flutter/material.dart';
import 'package:scm/app/app.locator.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/services/app_api_service_classes/home_page_apis.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';

class PopularBrandsViewModel extends GeneralisedBaseViewModel {
  AllBrandsResponse? allBrandsResponse;
  late final PopularBrandsViewArgs arguments;
  // TextEditingController searchController = TextEditingController();
  // FocusNode searchFocusNode = FocusNode();

  String brandTitle = '';

  int pageIndex = 0;

  final HomePageApis _homePageApis = locator<HomePageApisImpl>();

  getAllBrands() async {
    setBusy(true);

    //for adding infinite list load
    allBrandsResponse = await _homePageApis.getAllBrands(
      size: Dimens.defaultProductListPageSize,
      pageIndex: pageIndex,
      searchTerm: brandTitle,
      supplierId: arguments.supplierId,
      isSupplierCatalog: arguments.isSupplierCatalog,
    );
    // AllBrandsResponse? tempObj = await _homePageApis.getAllBrands(
    //   size: Dimens.defaultProductListPageSize,
    //   pageIndex: pageIndex,
    // );

    // if (allBrandsResponse == null) {
    //   allBrandsResponse = tempObj;
    // } else {
    //   allBrandsResponse!.brands!.addAll(tempObj!.brands!);

    //   allBrandsResponse = allBrandsResponse!.copyWith(
    //     totalItems: tempObj.totalItems ?? 0,
    //     totalPages: tempObj.totalPages ?? 0,
    //     currentPage: tempObj.currentPage ?? 0,
    //   );
    // }

    setBusy(false);
    notifyListeners();
  }

  void takeToProductListView({required Brand selectedItem}) {
    navigationService.navigateTo(
      productListViewPageRoute,
      arguments: ProductListViewArgs.fullScreen(
        brandsFilterList: [selectedItem.title],
        categoryFilterList: [],
        subCategoryFilterList: [],
        productTitle: '',
        isSupplierCatalog: arguments.isSupplierCatalog,
      ),
    );
  }

  init({required PopularBrandsViewArgs arguments}) {
    this.arguments = arguments;
    getAllBrands();
  }
}
