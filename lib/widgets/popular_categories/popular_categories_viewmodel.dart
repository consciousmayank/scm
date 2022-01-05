import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/product_categories_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/services/app_api_service_classes/product_categories_apis.dart';
import 'package:scm/widgets/popular_categories/popular_categories_view.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';

class PopularCategoriesViewModel extends GeneralisedBaseViewModel {
  late final PopularCategoriesViewArguments args;
  ProductCategoriesResponse? categoriesResponse;
  String? categoryTitle;
  int pageIndex = 0;

  final ProductCategoriesApis _productCategoriesApis =
      di<ProductCategoriesApiImpl>();

  getAllCategories() async {
    setBusy(true);
    categoriesResponse = await _productCategoriesApis.getProductCategoriesList(
        pageIndex: pageIndex,
        supplierId: args.supplierId,
        categoryTitle: categoryTitle);
    setBusy(false);
    notifyListeners();
  }

  init({required PopularCategoriesViewArguments args}) {
    this.args = args;
    getAllCategories();
  }

  void takeToProductListView({
    required String selectedCategory,
  }) {
    navigationService.navigateTo(
      productListViewPageRoute,
      arguments: ProductListViewArguments.asSupplierProductList(
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
