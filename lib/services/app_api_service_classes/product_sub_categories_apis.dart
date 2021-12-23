import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_sub_categories_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductSubCategoriesApis {
  Future<ProductSubCategoriesResponse> getProductSubCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedCategoryList,
    String? subCategoryTitle,
    String? productTitle,
  });
}

class ProductSubCategoriesApisImpl extends BaseApi
    implements ProductSubCategoriesApis {
  @override
  Future<ProductSubCategoriesResponse> getProductSubCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedCategoryList,
    String? subCategoryTitle,
    String? productTitle,
  }) async {
    ProductSubCategoriesResponse? subCategoriesResponse;

    ParentApiResponse apiResponse =
        await apiService.getProductSubCategoriesList(
            pageIndex: pageIndex,
            checkedBrandList: checkedBrandList,
            checkedCategoryList: checkedCategoryList,
            subCategoryTitle: subCategoryTitle,
            productTitle: productTitle);
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      subCategoriesResponse =
          ProductSubCategoriesResponse.fromMap(apiResponse.response!.data);
    }

    return subCategoriesResponse!;
  }
}