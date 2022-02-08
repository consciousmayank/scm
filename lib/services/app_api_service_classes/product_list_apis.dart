import 'package:scm/app/dimens.dart';
import 'package:scm/enums/product_size_type.dart';
import 'package:scm/enums/update_product_api_type.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/model_classes/selected_suppliers_sub_types_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductListApis {
  Future<ProductListResponse?> getProductList({
    List<String?>? brandsFilterList,
    List<String?>? categoryFilterList,
    List<String?>? subCategoryFilterList,
    String? productTitle,
    int? pageIndex,
    int? supplierId,
    int size,
    bool isSupplierCatalog = false,
  });

  Future<ProductListResponse> getProductListForSizes({
    required List<String?> sizesFilterList,
    required int pageIndex,
    required int? supplierId,
    required int size,
    required ProductSizesType sizesType,
    required String subType,
  });

  Future<Product> getProductById({int? productId});

  Future<ApiResponse> updateProductById({
    required int? productId,
    // required int? supplierId,
    required UpdateProductApiSelection? apiToHit,
  });
}

class ProductListApiImpl extends BaseApi implements ProductListApis {
  @override
  Future<Product> getProductById({int? productId}) async {
    Product? product;
    ParentApiResponse apiResponse =
        await apiService.getProductById(productId: productId);
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      product = Product.fromMap(apiResponse.response?.data);
    }
    return product!;
  }

  @override
  Future<ProductListResponse?> getProductList({
    List<String?>? brandsFilterList,
    List<String?>? categoryFilterList,
    List<String?>? subCategoryFilterList,
    String? productTitle,
    int? pageIndex,
    int? supplierId,
    int size = Dimens.defaultProductListPageSize,
    bool isSupplierCatalog = false,
  }) async {
    ProductListResponse? productList;

    ParentApiResponse apiResponse = await apiService.getProductList(
      brandsFilterList: brandsFilterList,
      categoryFilterList: categoryFilterList,
      productTitle: productTitle,
      subCategoryFilterList: subCategoryFilterList,
      pageIndex: pageIndex,
      supplierId: supplierId,
      size: size,
      isSupplierCatalog: isSupplierCatalog,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      productList = ProductListResponse.fromMap(apiResponse.response!.data);
    }

    if (productList != null) {
      return productList;
    } else {
      return null;
    }
  }

  @override
  Future<ProductListResponse> getProductListForSizes({
    required List<String?> sizesFilterList,
    required int pageIndex,
    required ProductSizesType sizesType,
    int? supplierId,
    required int size,
    required String subType,
  }) async {
    ProductListResponse productList = ProductListResponse().empty();

    ParentApiResponse apiResponse = await apiService.getProductSizesList(
      pageIndex: pageIndex,
      pageSize: size,
      sizesFilterList: sizesFilterList,
      supplierId: supplierId,
      sizesType: sizesType,
      subType: subType,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      productList = ProductListResponse.fromMap(apiResponse.response!.data);
    }

    return productList;
  }

  @override
  Future<ApiResponse> updateProductById({
    required int? productId,
    // required int? supplierId,
    required UpdateProductApiSelection? apiToHit,
  }) async {
    ApiResponse? response;
    ParentApiResponse parentApiResponse = await apiService.updateProductById(
      productId: productId,
      // supplierId: supplierId,
      apiToHit: apiToHit,
    );

    if (filterResponse(parentApiResponse) != null) {
      response = ApiResponse.fromMap(parentApiResponse.response?.data);
      print('status code: ${parentApiResponse.response?.statusCode}');
      // return response;
    }
    return response!;
  }
}
