import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/services/app_api_service_classes/product_list_apis.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/product/filter/filters_dialog_box_view.dart';
import 'package:scm/widgets/product/filter/filters_view.dart';
import 'package:scm/widgets/product/product_details/product_detail_dialog_box_view.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductListViewModel extends GeneralisedBaseViewModel {
  late final ProductListViewArguments arguments;
  List<String?> brandsFilterList = [];
  List<String?> categoryFilterList = [];
  int pageIndex = 0;
  ProductListResponse? productListResponse;
  String? productTitle;
  List<String?> subCategoryFilterList = [];
  late final int? supplierId;

  final ProductListApis _productListApis = di<ProductListApiImpl>();

  getProductList() async {
    setBusy(true);

    productListResponse = await _productListApis.getProductList(
      brandsFilterList: brandsFilterList,
      categoryFilterList: categoryFilterList,
      subCategoryFilterList: subCategoryFilterList,
      pageIndex: pageIndex,
      productTitle: productTitle,
      size: !arguments.showSeeAll
          ? Dimens.defaultProductListPageSize
          : Dimens.defaultProductListPageSizeWhenInHome,
    );

    //Enable endless list
    // ProductListResponse? tempObject = await _productListApis.getProductList(
    //   brandsFilterList: brandsFilterList,
    //   categoryFilterList: categoryFilterList,
    //   subCategoryFilterList: subCategoryFilterList,
    //   pageIndex: pageIndex,
    //   size: !arguments.showSeeAll
    //       ? Dimens.defaultProductListPageSize
    //       : Dimens.defaultProductListPageSizeWhenInHome,
    // );

    // if (productListResponse == null) {
    //   productListResponse = ProductListResponse(
    //     products: tempObject!.products,
    //     totalItems: tempObject.totalItems,
    //     totalPages: tempObject.totalPages,
    //     currentPage: tempObject.currentPage,
    //     filters: tempObject.filters,
    //   );
    // } else {
    //   productListResponse!.products!.addAll(tempObject!.products!);
    //   productListResponse = productListResponse!.copyWith(
    //     totalItems: tempObject.totalItems,
    //     totalPages: tempObject.totalPages,
    //     currentPage: tempObject.currentPage,
    //     filters: tempObject.filters,
    //   );
    // }

    setBusy(false);

    notifyListeners();
  }

  init({required ProductListViewArguments arguments}) {
    this.arguments = arguments;
    brandsFilterList = arguments.brandsFilterList ?? [];
    categoryFilterList = arguments.categoryFilterList ?? [];
    subCategoryFilterList = arguments.subCategoryFilterList ?? [];
    productTitle = arguments.productTitle;
    supplierId = arguments.supplierId;

    getProductList();
  }

  void openFiltersDialogBox() async {
    DialogResponse? filterDialogBoxResponse =
        await dialogService.showCustomDialog(
      variant: DialogType.PRODUCTS_FILTER,
      data: ProductFilterDialogBoxViewArguments(
        title: productTitle == null || productTitle!.isEmpty
            ? 'Filters'
            : 'Filters for "$productTitle\"',
        selectedBrand: brandsFilterList,
        selectedCategory: categoryFilterList,
        selectedSuCategory: subCategoryFilterList,
        searchProductTitle: productTitle,
      ),
    );

    if (filterDialogBoxResponse != null && filterDialogBoxResponse.confirmed) {
      ProductFilterDialogBoxViewOutputArgs args = filterDialogBoxResponse.data;
      brandsFilterList = args.checkedBrands ?? [];
      categoryFilterList = args.checkedCategories ?? [];
      subCategoryFilterList = args.checkedSubCategories ?? [];
      // productTitle = productTitle;
      pageIndex = 0;
      getProductList();
    }
  }

  // onFilterApplyButtonClicked(
  //     {required ProductsFilterViewOutputArguments outArgs}) {
  //   brandsFilterList = outArgs.checkedBrands ?? [];
  //   categoryFilterList = outArgs.checkedCategories ?? [];
  //   subCategoryFilterList = outArgs.checkedSubCategories ?? [];
  //   pageIndex = 0;
  //   getProductList();
  // }

  void openProductDetails({required Product product}) async {
    await dialogService.showCustomDialog(
      variant: DialogType.PRODUCT_DETAILS,
      data: ProductDetailDialogBoxViewArguments(
        // title: product.title ?? '',
        title: lableproductdetails.toUpperCase(),
        product: product,
      ),
    );
  }

  takeToProductListFullScreen() {
    navigationService.navigateTo(
      productListViewPageRoute,
      arguments: ProductListViewArguments.fullScreen(
        brandsFilterList: [],
        categoryFilterList: [],
        subCategoryFilterList: [],
        productTitle: '',
        supplierId: -1,
      ),
    );
  }

  bool isFilterApplied() {
    return brandsFilterList.isNotEmpty ||
        categoryFilterList.isNotEmpty ||
        subCategoryFilterList.isNotEmpty ||
        (productTitle != null && productTitle!.isNotEmpty);
  }

  int getAppliedFiltersCount() {
    int count = 0;
    if (productTitle != null && productTitle!.isNotEmpty) {
      count = count + 1;
    }
    if (brandsFilterList.isNotEmpty) {
      count = count + brandsFilterList.length;
    }
    if (categoryFilterList.isNotEmpty) {
      count = count + categoryFilterList.length;
    }
    if (subCategoryFilterList.isNotEmpty) {
      count = count + subCategoryFilterList.length;
    }
    return count;
  }

  openSortDialogBox() {}
}