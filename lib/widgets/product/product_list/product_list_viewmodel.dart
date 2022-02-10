import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/product_size_type.dart';
import 'package:scm/model_classes/product_sizes_response.dart';
import 'package:scm/model_classes/selected_suppliers_brands_response.dart';
import 'package:scm/model_classes/selected_suppliers_sub_types_response.dart';
import 'package:scm/model_classes/selected_suppliers_types_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/app/app.router.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/app_api_service_classes/product_list_apis.dart';
import 'package:scm/services/app_api_service_classes/product_sizes_apis.dart';
import 'package:scm/services/app_api_service_classes/product_sub_categories_apis.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/product/filter/filters_dialog_box_view.dart';
import 'package:scm/widgets/product/product_details/product_detail_dialog_box_view.dart';
import 'package:scm/widgets/product/product_list/add_to_cart_helper.dart';
import 'package:scm/widgets/product/product_list/add_to_catalog_helper.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductListViewModel extends GeneralisedBaseViewModel {
  late AddToCart addToCartObject;
  late AddToCatalog addToCatalog;
  late final ProductListViewArgs arguments;
  List<Brand?> brandsFilterList = [];
  List<Type?> categoryFilterList = [];
  int pageIndex = 0;
  ProductListResponse? productListResponse;
  ProductSizesListResponse productSizesListResponse =
      ProductSizesListResponse().empty();

  ApiStatus productSubTypeApiStatus = ApiStatus.LOADING;
  String? productTitle;
  List<ProductSize?> sizeFilterList = [];
  late ProductSizesType sizesType;
  List<SubType?> subCategoryFilterList = [];
  SuppliersSubTypesListResponse subCategoryListResponse =
      SuppliersSubTypesListResponse().empty();

  late final int? supplierId;

  final ProductListApis _productListApis = locator<ProductListApiImpl>();
  final ProductSizesApis _productSizesApis = locator<ProductSizesApisImpl>();
  final ProductSubCategoriesApisImpl _productSubCatgoriesApis =
      locator<ProductSubCategoriesApisImpl>();
  ApiStatus productListApiStatus = ApiStatus.LOADING;
  getProductList() async {
    if (sizeFilterList.isEmpty) {
      productListResponse = await _productListApis.getProductList(
        brandsFilterList: brandsFilterList.map((e) => e?.brand).toList(),
        categoryFilterList: categoryFilterList.map((e) => e?.type).toList(),
        subCategoryFilterList:
            subCategoryFilterList.map((e) => e?.subType).toList(),
        pageIndex: pageIndex,
        productTitle: productTitle,
        size: !arguments.showSeeAll
            ? Dimens.defaultProductListPageSize
            : Dimens.defaultProductListPageSizeWhenInHome,
        supplierId: supplierId,
        isSupplierCatalog: arguments.isSupplierCatalog,
      );
    } else {
      productListResponse = await _productListApis.getProductListForSizes(
        pageIndex: pageIndex,
        size: !arguments.showSeeAll
            ? Dimens.defaultProductListPageSize
            : Dimens.defaultProductListPageSizeWhenInHome,
        sizesFilterList: sizeFilterList
            .map((e) =>
                '${e?.measurement?.toStringAsFixed(1)} ${e?.measurementUnit}')
            .toList(),
        supplierId: supplierId,
        sizesType: sizesType,
        subType: subCategoryFilterList.first!.subType!,
      );
    }

    productListApiStatus = ApiStatus.FETCHED;

    notifyListeners();
  }

  init({required ProductListViewArgs arguments}) {
    this.arguments = arguments;
    if (arguments.supplierId != null) {
      supplierId = arguments.supplierId;

      addToCartObject = AddToCart(supplierId: supplierId!);
    } else {
      supplierId = null;
      addToCatalog = AddToCatalog();
    }

    brandsFilterList = arguments.brandsFilterList ?? [];
    categoryFilterList = arguments.categoryFilterList ?? [];
    subCategoryFilterList = arguments.subCategoryFilterList ?? [];
    productTitle = arguments.productTitle;

    getSubCategories();

    getProductList();

    if (arguments.isSupplierCatalog) {
      sizesType = ProductSizesType.CATALOG;
    } else if (isDemander()) {
      sizesType = ProductSizesType.DEMAND;
    } else {
      sizesType = ProductSizesType.STANDARD;
    }
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
        supplierId: supplierId,
        isSupplierCatalog: arguments.isSupplierCatalog,
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
      getSubCategories();
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
        productId: product.id,
        title: lableproductdetails.toUpperCase(),
        // product: product,
        product: null,
      ),
    );
  }

  takeToProductListFullScreen() {
    navigationService.navigateTo(
      productListViewPageRoute,
      arguments: ProductListViewArgs.fullScreen(
        brandsFilterList: [],
        categoryFilterList: [],
        subCategoryFilterList: [],
        productTitle: '',
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

  reloadPage() {
    getProductList();
  }

  void getSubCategories() async {
    if (categoryFilterList.length == 1) {
      subCategoryListResponse =
          await _productSubCatgoriesApis.getProductSubCategoriesList(
        pageIndex: 0,
        pageSize: 3,
        checkedBrandList: brandsFilterList.map((e) => e?.brand).toList(),
        checkedCategoryList: categoryFilterList.map((e) => e?.type).toList(),
        isSupplierCatalog: arguments.isSupplierCatalog,
        productTitle: productTitle,
        subCategoryTitle: '',
        supplierId: supplierId,
      );
      productSubTypeApiStatus = ApiStatus.FETCHED;
      notifyListeners();
    }
  }

  showAllSubCategoriesDialogBox() async {}

  showAllSizesDialogBox() async {}

  void addToSubCategoryFilterList({SubType? subType}) {
    subCategoryFilterList.add(
      subType,
    );
    getProductList();
    getSizeList();
  }

  void removeFromSubCategoryFilterList({SubType? subType}) {
    subCategoryFilterList.remove(
      subType,
    );
    getSizeList();
    getProductList();
  }

  void getSizeList() async {
    if (subCategoryFilterList.length == 1) {
      productSizesListResponse = await _productSizesApis.getProductSizesList(
        pageIndex: 0,
        pageSize: 5,
        subType: subCategoryFilterList.first!.subType!,
        supplierId: supplierId,
        sizesType: sizesType,
      );

      notifyListeners();
    }
  }

  void addToSizesFilterList({ProductSize? subType}) {
    sizeFilterList.add(
      subType,
    );
    getProductList();
  }

  void removeFromaSizesFilterList({ProductSize? subType}) {
    sizeFilterList.remove(
      subType,
    );
    getProductList();
  }
}
