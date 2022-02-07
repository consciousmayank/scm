import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/selected_suppliers_sub_types_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductSubCategoriesApis {
  Future<SuppliersSubTypesListResponse> getProductSubCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedCategoryList,
    String? subCategoryTitle,
    String? productTitle,
    int? supplierId,
    bool isSupplierCatalog,
  });
}

class ProductSubCategoriesApisImpl extends BaseApi
    implements ProductSubCategoriesApis {
  @override
  Future<SuppliersSubTypesListResponse> getProductSubCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedCategoryList,
    String? subCategoryTitle,
    String? productTitle,
    int? supplierId,
    bool isSupplierCatalog = false,
  }) async {
    SuppliersSubTypesListResponse subCategoriesResponse =
        SuppliersSubTypesListResponse().empty();

    ParentApiResponse apiResponse =
        await apiService.getProductSubCategoriesList(
      pageIndex: pageIndex,
      checkedBrandList: checkedBrandList,
      checkedCategoryList: checkedCategoryList,
      subCategoryTitle: subCategoryTitle,
      productTitle: productTitle,
      supplierId: supplierId,
      isSupplierCatalog: isSupplierCatalog,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      subCategoriesResponse =
          SuppliersSubTypesListResponse.fromMap(apiResponse.response?.data);
    }

    return subCategoriesResponse;
  }
}
