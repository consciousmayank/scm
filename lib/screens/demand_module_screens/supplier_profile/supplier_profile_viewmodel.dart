import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/product_categories_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/demand_module_screens/supplier_profile/supplier_profile_view.dart';
import 'package:scm/services/app_api_service_classes/home_page_apis.dart';
import 'package:scm/services/app_api_service_classes/product_categories_apis.dart';
import 'package:scm/services/app_api_service_classes/product_list_apis.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:scm/widgets/popular_categories/popular_categories_view.dart';
import 'package:scm/widgets/product/product_details/product_detail_dialog_box_view.dart';
import 'package:scm/widgets/product/product_list/add_to_cart_helper.dart';
import 'package:scm/widgets/product/product_list/add_to_catalog_helper.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';

class SuppplierProfileViewModel extends GeneralisedBaseViewModel {
  late final AddToCart addToCartObject;
  late final AddToCatalog addToCatalogObject;
  AllBrandsResponse? allBrandsResponse = AllBrandsResponse().empty();
  late final SuppplierProfileViewArguments arguments;
  ApiStatus brandsApiStatus = ApiStatus.LOADING;
  List<String?> brandsFilterList = [];
  ApiStatus categoriesApiStatus = ApiStatus.LOADING;
  List<String?> categoryFilterList = [];
  int pageIndex = 0;
  ProductCategoriesResponse? productCategoriesResponse =
      ProductCategoriesResponse().empty();
  ApiStatus productListApiStatus = ApiStatus.LOADING;
  ProductListResponse? productListResponse = ProductListResponse().empty();
  String? productTitle;
  List<String?> subCategoryFilterList = [];
  late final int? supplierId;

  final HomePageApis _homePageApis = di<HomePageApisImpl>();
  final ProductCategoriesApis _productCategoriesApis =
      di<ProductCategoriesApiImpl>();

  final ProductListApis _productListApis = di<ProductListApiImpl>();

  getCategories() async {
    productCategoriesResponse =
        await _productCategoriesApis.getProductCategoriesList(
      pageIndex: 0,
      pageSize: arguments.selectedSupplier != null ? 6 : 12,
      checkedBrandList: [],
      checkedSubCategoriesList: [],
      categoryTitle: null,
      productTitle: null,
      supplierId: arguments.selectedSupplier?.id,
      isSupplierCatalog: arguments.isSupplierCatalog,
    );

    categoriesApiStatus = ApiStatus.FETCHED;
    notifyListeners();
  }

  getProductList() async {
    productListResponse = await _productListApis.getProductList(
      brandsFilterList: brandsFilterList,
      categoryFilterList: categoryFilterList,
      subCategoryFilterList: subCategoryFilterList,
      pageIndex: pageIndex,
      productTitle: productTitle,
      size: 6,
      supplierId: supplierId,
      isSupplierCatalog: arguments.isSupplierCatalog,
    );

    productListApiStatus = ApiStatus.FETCHED;

    notifyListeners();
  }

  getBrands() async {
    allBrandsResponse = await _homePageApis.getAllBrands(
      size: arguments.selectedSupplier != null ? 6 : 12,
      pageIndex: 0,
      searchTerm: '',
      supplierId: supplierId,
      isSupplierCatalog: arguments.isSupplierCatalog,
    );
    brandsApiStatus = ApiStatus.FETCHED;
    notifyListeners();
  }

  void takeToProductListView({Brand? selectedBrand, String? selectedCategory}) {
    navigationService.navigateTo(
      productListViewPageRoute,
      arguments: ProductListViewArgs.asSupplierProductList(
        brandsFilterList: selectedBrand == null
            ? []
            : [
                selectedBrand.title,
              ],
        categoryFilterList: selectedCategory == null
            ? []
            : [
                selectedCategory,
              ],
        subCategoryFilterList: [],
        productTitle: '',
        supplierId: arguments.selectedSupplier?.id,
        supplierName: arguments.selectedSupplier?.businessName,
        isSupplierCatalog: arguments.isSupplierCatalog,
      ),
    );
  }

  init({required SuppplierProfileViewArguments args}) {
    arguments = args;

    if (arguments.selectedSupplier != null) {
      supplierId = args.selectedSupplier!.id;

      addToCartObject = AddToCart(supplierId: args.selectedSupplier!.id!);
    } else {
      supplierId = null;
      addToCatalogObject = AddToCatalog();
    }

    getBrands();
    getProductList();
    getCategories();
  }

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

  navigateToPopularBrandsFullScreenForSupplier() {
    navigationService.navigateTo(
      brandsListViewPageRoute,
      arguments: PopularBrandsViewArgs.fullScreen(
        isSupplierCatalog: arguments.isSupplierCatalog,
      ),
    );
  }

  navigateToPopularBrandsFullScreenForDemander() {
    navigationService.navigateTo(
      brandsListViewPageRoute,
      arguments: PopularBrandsViewArgs.demanderPopularBrands(
        supplierId: arguments.selectedSupplier?.id,
        supplierName: arguments.selectedSupplier?.businessName,
      ),
    );
  }

  navigateToCategoriesFullScreenForSupplier() {
    navigationService.navigateTo(
      categoriesListViewPageRoute,
      arguments: PopularCategoriesViewArgs(
          isSupplierCatalog: arguments.isSupplierCatalog),
    );
  }

  navigateToCategoriesFullScreenForDemander() {
    navigationService.navigateTo(
      categoriesListViewPageRoute,
      arguments: PopularCategoriesViewArgs.demanderPopularBrands(
        supplierId: arguments.selectedSupplier?.id,
        supplierName: arguments.selectedSupplier?.businessName,
      ),
    );
  }

  navigateToProductListFullScreenForSupplier() {
    navigationService.navigateTo(
      productListViewPageRoute,
      arguments: ProductListViewArgs.fullScreen(
        isSupplierCatalog: arguments.isSupplierCatalog,
        brandsFilterList: [],
        categoryFilterList: [],
        subCategoryFilterList: [],
        productTitle: '',
      ),
    );
  }

  navigateToProductListFullScreenForDemander() {
    navigationService.navigateTo(
      productListViewPageRoute,
      arguments: ProductListViewArgs.asSupplierProductList(
        brandsFilterList: [],
        categoryFilterList: [],
        subCategoryFilterList: [],
        productTitle: '',
        supplierId: arguments.selectedSupplier?.id,
        supplierName: arguments.selectedSupplier?.businessName,
      ),
    );
  }

  reloadPage() {
    brandsApiStatus = ApiStatus.LOADING;
    categoriesApiStatus = ApiStatus.LOADING;
    productListApiStatus = ApiStatus.LOADING;
    notifyListeners();
    getBrands();
    getCategories();
    getProductList();
  }
}
