import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/selected_suppliers_types_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductCategoriesApis {
  Future<SuppliersTypesListResponse?> getProductCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedSubCategoriesList,
    String? categoryTitle,
    String? productTitle,
    int? pageSize,
    int? supplierId,
    bool isSupplierCatalog,
  });
}

class ProductCategoriesApiImpl extends BaseApi
    implements ProductCategoriesApis {
  @override
  Future<SuppliersTypesListResponse?> getProductCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedSubCategoriesList,
    String? categoryTitle,
    String? productTitle,
    int? supplierId,
    int? pageSize,
    bool isSupplierCatalog = false,
  }) async {
    SuppliersTypesListResponse suppliersTypesListResponse =
        SuppliersTypesListResponse().empty();
    ParentApiResponse apiResponse = await apiService.getProductCategoriesList(
      pageIndex: pageIndex,
      checkedBrandList: checkedBrandList,
      categoryTitle: categoryTitle,
      checkedSubCategoriesList: checkedSubCategoriesList,
      productTitle: productTitle,
      supplierId: supplierId,
      pageSize: pageSize,
      isSupplierCatalog: isSupplierCatalog,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      // print(apiResponse.response!.data.);
      // if (supplierId == null && !isSupplierCatalog) {
      suppliersTypesListResponse =
          SuppliersTypesListResponse.fromMap(apiResponse.response?.data);

      return suppliersTypesListResponse;
      // } else {
      //   TypesCategoryStringListResponse typesCategoryStringListResponse =
      //       TypesCategoryStringListResponse.fromMap(apiResponse.response!.data);

      //   return ProductCategoriesResponse(
      //     types: typesCategoryStringListResponse.types!
      //         .map(
      //           (element) => element,
      //         )
      //         .toList(),
      //     currentPage: typesCategoryStringListResponse.currentPage,
      //     totalItems: typesCategoryStringListResponse.totalItems,
      //     totalPages: typesCategoryStringListResponse.totalPages,
      //   );
      // }
    }
  }
}
