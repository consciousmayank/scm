import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_categories_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductCategoriesApis {
  Future<ProductCategoriesResponse?> getProductCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedSubCategoriesList,
    String? categoryTitle,
    String? productTitle,
  });
}

class ProductCategoriesApiImpl extends BaseApi
    implements ProductCategoriesApis {
  @override
  Future<ProductCategoriesResponse?> getProductCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedSubCategoriesList,
    String? categoryTitle,
    String? productTitle,
  }) async {
    ProductCategoriesResponse? categoriesResponse;

    ParentApiResponse apiResponse = await apiService.getProductCategoriesList(
      pageIndex: pageIndex,
      checkedBrandList: checkedBrandList,
      categoryTitle: categoryTitle,
      checkedSubCategoriesList: checkedSubCategoriesList,
      productTitle: productTitle,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      // print(apiResponse.response!.data.);
      categoriesResponse =
          ProductCategoriesResponse.fromMap(apiResponse.response!.data);
    }

    if (categoriesResponse != null) {
      return categoriesResponse;
    } else {
      return null;
    }
  }
}
