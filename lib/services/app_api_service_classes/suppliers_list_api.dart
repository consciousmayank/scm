import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/suppliers_list_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class SuppliersListAbstractClass {
  Future<SuppliersListResponse> getSuppliersList({
    required int pageNumber,
    required int pageSize,
    String? type,
    String? title,
  });
}

class SuppliersListApi extends BaseApi implements SuppliersListAbstractClass {
  @override
  Future<SuppliersListResponse> getSuppliersList({
    required int pageNumber,
    required int pageSize,
    String? type,
    String? title,
  }) async {
    SuppliersListResponse returningResponse = SuppliersListResponse().empty();

    ParentApiResponse apiResponse = await apiService.getSuppliersList(
      pageNumber: pageNumber,
      pageSize: pageSize,
      type: type,
      title: title,
    );

    if (filterResponse(apiResponse) != null) {
      returningResponse = SuppliersListResponse.fromMap(
        apiResponse.response!.data,
      );
    }

    return returningResponse;
  }
}
