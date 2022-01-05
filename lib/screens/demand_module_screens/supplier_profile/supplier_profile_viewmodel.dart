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
import 'package:scm/widgets/product/product_list/product_list_view.dart';

class SuppplierProfileViewModel extends GeneralisedBaseViewModel {
  late final AddToCart addToCartObject;
  AllBrandsResponse? allBrandsResponse;
  late final SuppplierProfileViewArguments arguments;
  ApiStatus brandsApiStatus = ApiStatus.LOADING;
  List<String?> brandsFilterList = [];
  ApiStatus categoriesApiStatus = ApiStatus.LOADING;
  List<String?> categoryFilterList = [];
  int pageIndex = 0;
  ProductCategoriesResponse? productCategoriesResponse;
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
      pageSize: 6,
      checkedBrandList: [],
      checkedSubCategoriesList: [],
      categoryTitle: null,
      productTitle: null,
      supplierId: arguments.selectedSupplier!.id,
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
      size: 8,
      supplierId: supplierId,
    );

    productListApiStatus = ApiStatus.FETCHED;

    notifyListeners();
  }

  getBrands() async {
    allBrandsResponse = await _homePageApis.getAllBrands(
        size: 6, pageIndex: 0, searchTerm: '', supplierId: supplierId);
    brandsApiStatus = ApiStatus.FETCHED;
    notifyListeners();
  }

  void takeToProductListView({Brand? selectedBrand, String? selectedCategory}) {
    navigationService.navigateTo(
      productListViewPageRoute,
      arguments: ProductListViewArguments.asSupplierProductList(
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
        supplierId: arguments.selectedSupplier!.id,
        supplierName: arguments.selectedSupplier!.businessName,
      ),
    );
  }

  init({required SuppplierProfileViewArguments args}) {
    arguments = args;
    supplierId = args.selectedSupplier!.id;

    addToCartObject = AddToCart(supplierId: args.selectedSupplier!.id!);

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

  navigateToPopularBrandsFullScreenForDemander() {
    navigationService.navigateTo(
      brandsListViewPageRoute,
      arguments: PopularBrandsViewArguments.demanderPopularBrands(
        supplierId: arguments.selectedSupplier!.id,
        supplierName: arguments.selectedSupplier!.businessName,
      ),
    );
  }

  navigateToCategoriesFullScreenForDemander() {
    navigationService.navigateTo(
      categoriesListViewPageRoute,
      arguments: PopularCategoriesViewArguments.demanderPopularBrands(
        supplierId: arguments.selectedSupplier!.id,
        supplierName: arguments.selectedSupplier!.businessName,
      ),
    );
  }

  navigateToProductListFullScreenForDemander() {
    navigationService.navigateTo(
      productListViewPageRoute,
      arguments: ProductListViewArguments.asSupplierProductList(
        brandsFilterList: [],
        categoryFilterList: [],
        subCategoryFilterList: [],
        productTitle: '',
        supplierId: arguments.selectedSupplier!.id,
        supplierName: arguments.selectedSupplier!.businessName,
      ),
    );
  }
}
