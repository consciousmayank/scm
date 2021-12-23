import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/product_categories_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/services/app_api_service_classes/home_page_apis.dart';
import 'package:scm/services/app_api_service_classes/product_categories_apis.dart';
import 'package:scm/services/app_api_service_classes/product_list_apis.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:stacked_services/stacked_services.dart';

class SupplyProductsOptionsPageViewModel extends GeneralisedBaseViewModel {
  final HomePageApis _homePageApis = di<HomePageApisImpl>();
  AllBrandsResponse? _allBrandsResponse;

  List<Brand>? _listOfBrands;

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

  int? _lengthOfListView;

  int? get lengthOfListView => _lengthOfListView;

  set lengthOfListView(int? value) {
    _lengthOfListView = value;
    notifyListeners();
  }

  int? _lengthOfCategoriesListView;

  int? get lengthOfCategoriesListView => _lengthOfCategoriesListView;

  set lengthOfCategoriesListView(int? value) {
    _lengthOfCategoriesListView = value;
    notifyListeners();
  }

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

  ProductCategoriesResponse? _categoriesResponse;

  ProductCategoriesResponse? get categoriesResponse => _categoriesResponse;

  set categoriesResponse(ProductCategoriesResponse? value) {
    _categoriesResponse = value;
    notifyListeners();
  }

  final ProductCategoriesApis _productCategoriesApis =
      di<ProductCategoriesApiImpl>();

  List<String>? _productCategoriesList;

  List<String>? get productCategoriesList => _productCategoriesList;

  set productCategoriesList(List<String>? value) {
    _productCategoriesList = value;
    notifyListeners();
  }

  ProductListResponse? _productsResponse;

  ProductListResponse? get productsResponse => _productsResponse;

  set productsResponse(ProductListResponse? value) {
    _productsResponse = value;
    notifyListeners();
  }

  List<Product>? _productList;

  List<Product>? get productList => _productList;

  set productList(List<Product>? value) {
    _productList = value;
    notifyListeners();
  }

  final ProductListApis _productListApis = di<ProductListApiImpl>();

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

  void takeToProductCategories() {
    navigationService.navigateTo(allProductCategoriesViewPageRoute);
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

  void takeToCustomSearchView() {
    navigationService.navigateTo(showSearchDemo);
  }

  void takeToSearchProductsView() {
    navigationService.navigateTo(
      searchProductsViewPageRoute,
    );
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
      arguments: PopularBrandsViewArguments.fullScreen(),
    );
  }
}
