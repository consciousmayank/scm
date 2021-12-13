import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class BrandsApiAbstractClass {
  Future<AllBrandsResponse> getAllBrands({
    required int pageNumber,
    required int pageSize,
  });
}

class BrandsApi extends BaseApi implements BrandsApiAbstractClass {
  @override
  Future<AllBrandsResponse> getAllBrands({
    required int pageNumber,
    required int pageSize,
  }) async {
    AllBrandsResponse response = AllBrandsResponse().empty();

    ParentApiResponse parentApiResponse = await apiService.getAllBrands(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    if (filterResponse(parentApiResponse) != null) {
      response = AllBrandsResponse.fromMap(parentApiResponse.response!.data);
    }

    return response;
  }
}
