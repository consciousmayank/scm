import 'package:scm/enums/update_product_api_type.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class SuppllierCatalogApisAbstractClass {
  Future<ApiResponse> updateProductById({
    required int? productId,
    // required int? supplierId,
    required UpdateProductApiSelection apiToHit,
  });
}

class SupplierCatalogApis extends BaseApi
    implements SuppllierCatalogApisAbstractClass {
  @override
  Future<ApiResponse> updateProductById(
      {required int? productId,
      required UpdateProductApiSelection apiToHit}) async {
    ApiResponse response = ApiResponse(
      message: '',
      status: '',
      statusCode: 400,
    );
    ParentApiResponse parentApiResponse = await apiService.updateProductById(
      productId: productId,
      // supplierId: supplierId,
      apiToHit: apiToHit,
    );

    if (filterResponse(parentApiResponse) != null) {
      response = ApiResponse.fromMap(parentApiResponse.response?.data);
    }
    return response;
  }
}
