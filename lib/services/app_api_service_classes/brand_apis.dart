import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class BrandsApiAbstractClass {
  Future<AllBrandsResponse> getAllBrands({
    required int pageNumber,
    required int pageSize,
    required String brandToSearch,
  });

  Future<Brand> addBrand({
    required Brand brand,
  });
}

class BrandsApi extends BaseApi implements BrandsApiAbstractClass {
  @override
  Future<Brand> addBrand({
    required Brand brand,
  }) async {
    Brand returningResponse = Brand.empty();

    ParentApiResponse parentApiResponse = await apiService.addBrand(
      brand: brand,
    );

    if (filterResponse(parentApiResponse) != null) {
      returningResponse = Brand.fromMap(parentApiResponse.response!.data);
    }

    return returningResponse;
  }

  @override
  Future<AllBrandsResponse> getAllBrands({
    required int pageNumber,
    required int pageSize,
    required String brandToSearch,
  }) async {
    AllBrandsResponse response = AllBrandsResponse().empty();

    ParentApiResponse parentApiResponse = await apiService.getAllBrands(
      pageNumber: pageNumber,
      pageSize: pageSize,
      brandToSearch: brandToSearch,
    );

    if (filterResponse(parentApiResponse) != null) {
      response = AllBrandsResponse.fromMap(parentApiResponse.response!.data);
    }

    return response;
  }
}
