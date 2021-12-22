import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/products_brands_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProductBrandsApis {
  Future<ProductBrandsResponse?> getBrandsList({
    required int? pageIndex,
    String? brandTitle,
    String? productTitle,
    List<String?>? checkedCategoryFilterList,
    List<String?>? checkedSubCategoryFilterList,
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
  }) async {
    ProductBrandsResponse? brandsResponse;

    ParentApiResponse apiResponse = await apiService.getBrandsList(
      productTitle: productTitle,
      pageIndex: pageIndex,
      brandTitle: brandTitle,
      checkedCategoryFilterList: checkedCategoryFilterList,
      checkedSubCategoryFilterList: checkedSubCategoryFilterList,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      brandsResponse =
          ProductBrandsResponse.fromMap(apiResponse.response!.data);
    }

    if (brandsResponse != null) {
      return brandsResponse;
    } else {
      return null;
    }
  }
}
