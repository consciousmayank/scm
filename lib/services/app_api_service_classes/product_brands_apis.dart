import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/products_brands_response.dart';
import 'package:scm/model_classes/products_brands_response.dart'
    as supplierModuleBrandsResponse;
import 'package:scm/model_classes/selected_suppliers_brands_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductBrandsApis {
  Future<ProductBrandsResponse?> getBrandsList({
    required int? pageIndex,
    String? brandTitle,
    String? productTitle,
    List<String?>? checkedCategoryFilterList,
    List<String?>? checkedSubCategoryFilterList,
    int? supplierId,
  });
}

class ProductBrandsApiImpl extends BaseApi implements ProductBrandsApis {
  @override
  Future<ProductBrandsResponse?> getBrandsList({
    required int? pageIndex,
    String? brandTitle,
    String? productTitle,
    List<String?>? checkedCategoryFilterList,
    List<String?>? checkedSubCategoryFilterList,
    int? supplierId,
  }) async {
    ParentApiResponse apiResponse = await apiService.getBrandsList(
      productTitle: productTitle,
      pageIndex: pageIndex,
      brandTitle: brandTitle,
      checkedCategoryFilterList: checkedCategoryFilterList,
      checkedSubCategoryFilterList: checkedSubCategoryFilterList,
      supplierId: supplierId,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      if (supplierId == null) {
        return ProductBrandsResponse.fromMap(apiResponse.response!.data);
      } else {
        SuppliersBrandsListResponse suppliersBrandsListResponse =
            SuppliersBrandsListResponse().empty();
        suppliersBrandsListResponse =
            SuppliersBrandsListResponse.fromMap(apiResponse.response?.data);

        return ProductBrandsResponse(
          brands: suppliersBrandsListResponse.brands!
              .map(
                (element) => element.brand!,
              )
              .toList(),
          currentPage: suppliersBrandsListResponse.currentPage,
          totalItems: suppliersBrandsListResponse.totalItems,
          totalPages: suppliersBrandsListResponse.totalPages,
        );
      }
    }
  }
}
