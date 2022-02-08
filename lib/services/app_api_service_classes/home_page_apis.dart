import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart'
    as supplierModuleBrandsResponse;
import 'package:scm/model_classes/image_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/selected_suppliers_brands_response.dart';
import 'package:scm/model_classes/supplier_demander_brands.dart';
import 'package:scm/services/network/base_api.dart';

abstract class HomePageApis {
  Future<SuppliersBrandsListResponse> getAllBrands({
    required int size,
    required int pageIndex,
    String searchTerm,
    int? supplierId,
    bool isSupplierCatalog = false,
  });

  Future<ImageResponse?> getProductImage({required imageName});
}

class HomePageApisImpl extends BaseApi implements HomePageApis {
  @override
  Future<SuppliersBrandsListResponse> getAllBrands({
    required int size,
    required int pageIndex,
    String? searchTerm,
    int? supplierId,
    bool isSupplierCatalog = false,
  }) async {
    SuppliersBrandsListResponse allBrandsResponse =
        SuppliersBrandsListResponse().empty();

    ParentApiResponse apiResponse = await apiService.getAllBrands(
      brandToSearch: searchTerm,
      pageNumber: pageIndex,
      pageSize: size,
      supplierId: supplierId,
      isSupplierCatalog: isSupplierCatalog,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      allBrandsResponse =
          SuppliersBrandsListResponse.fromMap(apiResponse.response?.data);
    }

    return allBrandsResponse;
  }

  @override
  Future<ImageResponse?> getProductImage({required imageName}) async {
    ImageResponse? imageResponse;
    ParentApiResponse apiResponse =
        await apiService.getProductImage(imageName: imageName);
    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      //
      // if(!apiResponse.isNoDataFound())

      imageResponse = ImageResponse.fromMap(apiResponse.response?.data);
    }

    return imageResponse;
  }
}
