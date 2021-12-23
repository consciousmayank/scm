import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/product_categories_response.dart';
import 'package:scm/services/app_api_service_classes/home_page_apis.dart';
import 'package:scm/services/app_api_service_classes/product_categories_apis.dart';
import 'package:scm/utils/utils.dart';

class PopularCategoriesViewModel extends GeneralisedBaseViewModel {
  ProductCategoriesResponse? categoriesResponse;

  final ProductCategoriesApis _productCategoriesApis =
      di<ProductCategoriesApiImpl>();

  getAllCategories() async {
    setBusy(true);
    categoriesResponse =
        await _productCategoriesApis.getProductCategoriesList(pageIndex: 0);
    setBusy(false);
    notifyListeners();
  }
}
