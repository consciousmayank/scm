import 'package:scm/model_classes/selected_suppliers_types_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/app/app.router.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/services/app_api_service_classes/product_categories_apis.dart';
import 'package:scm/widgets/popular_categories/popular_categories_view.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';

class PopularCategoriesViewModel extends GeneralisedBaseViewModel {
  late final PopularCategoriesViewArgs args;
  SuppliersTypesListResponse? categoriesResponse;
  String? categoryTitle;
  int pageIndex = 0;

  final ProductCategoriesApis _productCategoriesApis =
      locator<ProductCategoriesApiImpl>();

  getAllCategories() async {
    setBusy(true);
    categoriesResponse = await _productCategoriesApis.getProductCategoriesList(
      pageIndex: pageIndex,
      supplierId: args.supplierId,
      categoryTitle: categoryTitle,
      isSupplierCatalog: args.isSupplierCatalog,
    );
    setBusy(false);
    notifyListeners();
  }

  init({required PopularCategoriesViewArgs args}) {
    this.args = args;
    getAllCategories();
  }

  void takeToProductListView({
    required Type selectedCategory,
  }) {
    if (args.supplierId == null) {
      navigationService.navigateTo(
        productListViewPageRoute,
        arguments: ProductListViewArgs.fullScreen(
          brandsFilterList: [],
          categoryFilterList: [selectedCategory],
          subCategoryFilterList: [],
          productTitle: '',
          isSupplierCatalog: args.isSupplierCatalog,
        ),
      );
    } else {
      navigationService.navigateTo(
        productListViewPageRoute,
        arguments: ProductListViewArgs.asSupplierProductList(
          brandsFilterList: [],
          categoryFilterList: [selectedCategory],
          subCategoryFilterList: [],
          productTitle: '',
          supplierId: args.supplierId,
          supplierName: args.supplierName,
        ),
      );
    }
  }
}
