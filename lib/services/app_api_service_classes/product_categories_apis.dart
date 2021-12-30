import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_categories_response.dart';
import 'package:scm/model_classes/selected_suppliers_types_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductCategoriesApis {
  Future<ProductCategoriesResponse?> getProductCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedSubCategoriesList,
    String? categoryTitle,
    String? productTitle,
    int? supplierId,
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
    int? supplierId,
  }) async {
    ParentApiResponse apiResponse = await apiService.getProductCategoriesList(
      pageIndex: pageIndex,
      checkedBrandList: checkedBrandList,
      categoryTitle: categoryTitle,
      checkedSubCategoriesList: checkedSubCategoriesList,
      productTitle: productTitle,
      supplierId: supplierId,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      // print(apiResponse.response!.data.);
      if (supplierId == null) {
        return ProductCategoriesResponse.fromMap(apiResponse.response!.data);
      } else {
        SuppliersTypesListResponse suppliersTypesListResponse =
            SuppliersTypesListResponse().empty();
        suppliersTypesListResponse =
            SuppliersTypesListResponse.fromMap(apiResponse.response?.data);

        return ProductCategoriesResponse(
          types: suppliersTypesListResponse.types!
              .map(
                (element) => element.type!,
              )
              .toList(),
          currentPage: suppliersTypesListResponse.currentPage,
          totalItems: suppliersTypesListResponse.totalItems,
          totalPages: suppliersTypesListResponse.totalPages,
        );
      }
    }
  }
}
