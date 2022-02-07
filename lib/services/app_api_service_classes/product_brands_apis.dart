import 'package:scm/enums/user_roles.dart';
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
    bool isSupplierCatalog = false,
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
    bool isSupplierCatalog = false,
  }) async {
    ParentApiResponse apiResponse = await apiService.getBrandsList(
      productTitle: productTitle,
      pageIndex: pageIndex,
      brandTitle: brandTitle,
      checkedCategoryFilterList: checkedCategoryFilterList,
      checkedSubCategoryFilterList: checkedSubCategoryFilterList,
      supplierId: supplierId,
      isSupplierCatalog: isSupplierCatalog,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      return getBrands(apiResponse.response?.data);

      // if (supplierId == null && !isSupplierCatalog) {
      //   return ProductBrandsResponse.fromMap(apiResponse.response!.data);
      // } else {
      //   return getBrands(apiResponse.response?.data);
      // }
    }
  }

  ProductBrandsResponse getBrands(data) {
    SuppliersBrandsListResponse suppliersBrandsListResponse =
        SuppliersBrandsListResponse().empty();
    suppliersBrandsListResponse = SuppliersBrandsListResponse.fromMap(
      data,
    );

    return ProductBrandsResponse(
      brands: suppliersBrandsListResponse.brands!
          .map(
            (element) => element,
          )
          .toList(),
      currentPage: suppliersBrandsListResponse.currentPage,
      totalItems: suppliersBrandsListResponse.totalItems,
      totalPages: suppliersBrandsListResponse.totalPages,
    );
  }
}
