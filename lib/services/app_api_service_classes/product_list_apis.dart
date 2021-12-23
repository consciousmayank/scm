import 'package:scm/app/dimens.dart';
import 'package:scm/enums/update_product_api_type.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
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
  Future<ProductListResponse?> getProductList({
    List<String?>? brandsFilterList,
    List<String?>? categoryFilterList,
    List<String?>? subCategoryFilterList,
    String? productTitle,
    int? pageIndex,
    int? supplierId,
    int size = Dimens.defaultProductListPageSize,
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
