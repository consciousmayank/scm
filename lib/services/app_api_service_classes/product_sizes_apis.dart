import 'package:scm/enums/product_size_type.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_sizes_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductSizesApis {
  Future<ProductSizesListResponse> getProductSizesList({
    required int? pageIndex,
    required int? pageSize,
    required String subType,
    required ProductSizesType sizesType,
    required int? supplierId,
  });
}

class ProductSizesApisImpl extends BaseApi implements ProductSizesApis {
  @override
  Future<ProductSizesListResponse> getProductSizesList({
    required int? pageIndex,
    required int? pageSize,
    required String subType,
    required ProductSizesType sizesType,
    required int? supplierId,
  }) async {
    ProductSizesListResponse productSizesResponse =
        ProductSizesListResponse().empty();

    ParentApiResponse apiResponse = await apiService.getProductCategorySizeList(
      pageIndex: pageIndex ?? 0,
      pageSize: pageSize ?? 10,
      subType: subType,
      sizesType: sizesType,
      supplierId: supplierId,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      productSizesResponse =
          ProductSizesListResponse.fromMap(apiResponse.response?.data);
    }

    return productSizesResponse;
  }
}
