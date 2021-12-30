import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart'
    as supplierModuleBrandsResponse;
import 'package:scm/model_classes/image_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/selected_suppliers_brands_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class HomePageApis {
  Future<AllBrandsResponse?> getAllBrands(
      {required int size,
      required int pageIndex,
      String searchTerm,
      int? supplierId});

  Future<ImageResponse?> getProductImage({required imageName});
}

class HomePageApisImpl extends BaseApi implements HomePageApis {
  @override
  Future<AllBrandsResponse?> getAllBrands(
      {required int size,
      required int pageIndex,
      String? searchTerm,
      int? supplierId}) async {
    AllBrandsResponse? allBrandsResponse;

    ParentApiResponse apiResponse = await apiService.getAllBrands(
        brandToSearch: searchTerm,
        pageNumber: pageIndex,
        pageSize: size,
        supplierId: supplierId);
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      if (supplierId == null) {
        return AllBrandsResponse.fromMap(apiResponse.response?.data);
      } else {
        SuppliersBrandsListResponse suppliersBrandsListResponse =
            SuppliersBrandsListResponse().empty();
        suppliersBrandsListResponse =
            SuppliersBrandsListResponse.fromMap(apiResponse.response?.data);

        return AllBrandsResponse(
          brands: suppliersBrandsListResponse.brands!
              .map(
                (element) => supplierModuleBrandsResponse.Brand(
                  title: element.brand,
                  image: null,
                  id: null,
                ),
              )
              .toList(),
          currentPage: suppliersBrandsListResponse.currentPage,
          totalItems: suppliersBrandsListResponse.totalItems,
          totalPages: suppliersBrandsListResponse.totalPages,
        );
      }
    }
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
