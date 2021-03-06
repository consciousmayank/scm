import 'package:flutter/material.dart';
import 'package:scm/routes/routes_constants.dart';

import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/app_api_service_classes/home_page_apis.dart';
import 'package:scm/services/app_api_service_classes/product_categories_apis.dart';
import 'package:scm/services/app_api_service_classes/product_list_apis.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:scm/app/di.dart';

class SupplyProductsOptionsPageViewModel extends GeneralisedBaseViewModel {
  AllBrandsResponse? _allBrandsResponse;
  // void takeToSecondLevelCategoriesView({
  //   required TopLevelProductCategoriesTypes categoriesTypes,
  // }) {
  //   navigationService.navigateTo(
  //     groceryCategoriesViewPageRoute,
  //     arguments: categoriesTypes,
  //   );
  // }

  //todo : used only for testing purpose
  // List<String> savedImageNames = [
  //   one,
  //   two,
  //   three,
  //   four,
  //   five,
  //   six,
  //   seven,
  //   eight,
  //   nine,
  //   ten,
  //   eleven,
  //   twelve,
  //   thirteen,
  //   fourteen,
  //   fifteen,
  //   sixteen,
  //   seventeen,
  //   eighteen,
  //   nineteen,
  //   twenty,
  // ];

  // getImageName({int? index}) {
  //   return savedImageNames[index!];
  // }

  // ProductCategoriesResponse? _categoriesResponse;

  final HomePageApis _homePageApis = locator<HomePageApisImpl>();

  int? _lengthOfCategoriesListView;
  int? _lengthOfListView;
  List<Brand>? _listOfBrands;
  final ProductCategoriesApis _productCategoriesApis =
      locator<ProductCategoriesApiImpl>();

  List<String>? _productCategoriesList;
  List<Product>? _productList;
  final ProductListApis _productListApis = locator<ProductListApiImpl>();
  ProductListResponse? _productsResponse;

  List<Brand>? get listOfBrands => _listOfBrands;

  set listOfBrands(List<Brand>? value) {
    _listOfBrands = value;
    notifyListeners();
  }

  AllBrandsResponse? get allBrandsResponse => _allBrandsResponse;

  set allBrandsResponse(AllBrandsResponse? value) {
    _allBrandsResponse = value;
    notifyListeners();
  }

  int? get lengthOfListView => _lengthOfListView;

  set lengthOfListView(int? value) {
    _lengthOfListView = value;
    notifyListeners();
  }

  int? get lengthOfCategoriesListView => _lengthOfCategoriesListView;

  set lengthOfCategoriesListView(int? value) {
    _lengthOfCategoriesListView = value;
    notifyListeners();
  }

  // ProductCategoriesResponse? get categoriesResponse => _categoriesResponse;

  // set categoriesResponse(ProductCategoriesResponse? value) {
  //   _categoriesResponse = value;
  //   notifyListeners();
  // }

  List<String>? get productCategoriesList => _productCategoriesList;

  set productCategoriesList(List<String>? value) {
    _productCategoriesList = value;
    notifyListeners();
  }

  ProductListResponse? get productsResponse => _productsResponse;

  set productsResponse(ProductListResponse? value) {
    _productsResponse = value;
    notifyListeners();
  }

  List<Product>? get productList => _productList;

  set productList(List<Product>? value) {
    _productList = value;
    notifyListeners();
  }

  getAllProducts() async {
    setBusy(true);
    productsResponse = await _productListApis.getProductList(
      pageIndex: 0,
    );
    productList = copyList(productsResponse?.products);
    setBusy(false);
    notifyListeners();
  }

  // void takeToProductListView({required String? productCategoryName}) {
  //   navigationService.navigateTo(
  //     searchProductsViewPageRoute,
  //     arguments: SearchProductsArgs(
  //         selectedBrandName: null,
  //         selectedCategoryName: productCategoryName,
  //         selectedSubCategoryName: null),
  //   );
  // }

  void takeToBrandsListView() {
    navigationService.navigateTo(brandsListViewPageRoute);
  }

  Future<void> openAddProductDialogBox() async {
    // DialogResponse? dialogResponse = await dialogService.showCustomDialog(
    //   variant: DialogType.ADD_PRODUCT_QUANTITY,
    //   barrierDismissible: true,
    // );

    // if (dialogResponse != null) {
    //   if (dialogResponse.confirmed) {
    //     AddProductDialogBoxOutputArgs args = dialogResponse.data;

    //     /// use the entered qty from here
    //     print(args.productQuantity);
    //   }
    // }
  }

  void takeToSearchProductsViewForAllProducts() {
    // navigationService.navigateTo(
    //   searchProductsViewPageRoute,
    //   arguments: SearchProductsArgs(
    //     selectedBrandName: null,
    //     selectedCategoryName: null,
    //     selectedSubCategoryName: null,
    //     callingScreen: CallingScreen.HOME_PAGE,
    //   ),
    // );
  }

  Future<void> openProductDescriptionBottomSheet(
      {required Product? product}) async {
    // SheetResponse? sheetResponse = await bottomSheetService.showCustomSheet(
    //   barrierDismissible: true,
    //   isScrollControlled: true,
    //   variant: BottomSheetType.PRODUCT_DESCRIPTION,
    //   data: ProductDescriptionBottomSheetInputArgs(
    //     productId: product?.id,
    //   ),
    // );
  }

  takeToFullScreenBrandsView() {
    navigationService.navigateTo(
      brandsListViewPageRoute,
      arguments: PopularBrandsViewArgs.fullScreen(),
    );
  }
}
