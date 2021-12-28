import 'package:scm/enums/product_operations.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductApisAbstractClass {
  Future<ApiResponse> addProduct({
    required Product product,
  });

  Future<ApiResponse> updateProduct({
    required Product product,
  });

  Future<ProductListResponse> getAllAddedProductsList({
    required int pageNumber,
    required int pageSize,
  });

  Future<ProductListResponse> getAllPublishedProductsList({
    required int pageNumber,
    required int pageSize,
  });

  Future<Product?> getProductById({
    required int productId,
  });

  Future<ApiResponse> discardProduct({required Product product});
}

class ProductApis extends BaseApi implements ProductApisAbstractClass {
  @override
  Future<ApiResponse> addProduct({
    required Product product,
  }) async {
    ApiResponse response = ApiResponse();

    ParentApiResponse apiResponse = await apiService.performOperationOnProduct(
      productToBeAdded: product,
      productOperation: ProductOperations.ADD,
    );

    if (filterResponse(apiResponse) != null) {
      response = ApiResponse.fromMap(apiResponse.response!.data);
    }
    return response;
  }

  @override
  Future<ProductListResponse> getAllAddedProductsList({
    required int pageNumber,
    required int pageSize,
  }) async {
    ProductListResponse response = ProductListResponse().empty();

    ParentApiResponse apiResponse = await apiService.getAllAddedProductsList(
        pageNumber: pageNumber, pageSize: pageSize);

    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      response = ProductListResponse.fromMap(apiResponse.response!.data);
    }

    return response;
  }

  @override
  Future<ProductListResponse> getAllPublishedProductsList({
    required int pageNumber,
    required int pageSize,
  }) async {
    ProductListResponse response = ProductListResponse().empty();

    ParentApiResponse apiResponse =
        await apiService.getAllPublishedProductsList(
            pageNumber: pageNumber, pageSize: pageSize);

    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      response = ProductListResponse.fromMap(apiResponse.response!.data);
    }

    return response;
  }

  @override
  Future<Product?> getProductById({required int productId}) async {
    Product? product;

    ParentApiResponse apiResponse = await apiService.getProductById(
      productId: productId,
    );

    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      product = Product.fromMap(apiResponse.response!.data);
    }

    return product;
  }

  @override
  Future<ApiResponse> updateProduct({
    required Product product,
  }) async {
    ApiResponse response = ApiResponse();

    ParentApiResponse apiResponse = await apiService.performOperationOnProduct(
      productToBeAdded: product,
      productOperation: ProductOperations.UPDATE,
    );

    if (filterResponse(apiResponse) != null) {
      response = ApiResponse.fromMap(apiResponse.response!.data);
    }
    return response;
  }

  @override
  Future<ApiResponse> discardProduct({required Product product}) async {
    ApiResponse response = ApiResponse();

    ParentApiResponse apiResponse = await apiService.performOperationOnProduct(
      productToBeAdded: product,
      productOperation: ProductOperations.DISCARD,
    );

    if (filterResponse(apiResponse) != null) {
      response = ApiResponse.fromMap(apiResponse.response!.data);
    }
    return response;
  }
}
