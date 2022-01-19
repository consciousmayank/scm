import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_sub_categories_response.dart';
import 'package:scm/model_classes/selected_suppliers_brands_response.dart';
import 'package:scm/model_classes/selected_suppliers_sub_types_response.dart';
import 'package:scm/model_classes/selected_suppliers_types_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductSubCategoriesApis {
  Future<ProductSubCategoriesResponse> getProductSubCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedCategoryList,
    String? subCategoryTitle,
    String? productTitle,
    int? supplierId,
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
    int? supplierId,
  }) async {
    ProductSubCategoriesResponse subCategoriesResponse =
        ProductSubCategoriesResponse().empty();

    ParentApiResponse apiResponse =
        await apiService.getProductSubCategoriesList(
      pageIndex: pageIndex,
      checkedBrandList: checkedBrandList,
      checkedCategoryList: checkedCategoryList,
      subCategoryTitle: subCategoryTitle,
      productTitle: productTitle,
      supplierId: supplierId,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      if (supplierId == null) {
        subCategoriesResponse =
            ProductSubCategoriesResponse.fromMap(apiResponse.response!.data);
      } else {
        SuppliersSubTypesListResponse suppliersSubTypesListResponse =
            SuppliersSubTypesListResponse().empty();
        suppliersSubTypesListResponse =
            SuppliersSubTypesListResponse.fromMap(apiResponse.response?.data);

        subCategoriesResponse = ProductSubCategoriesResponse(
          subtypes: suppliersSubTypesListResponse.subTypes!
              .map(
                (element) => element.subType!,
              )
              .toList(),
          currentPage: suppliersSubTypesListResponse.currentPage,
          totalItems: suppliersSubTypesListResponse.totalItems,
          totalPages: suppliersSubTypesListResponse.totalPages,
        );
      }
    }

    return subCategoriesResponse;
  }
}
