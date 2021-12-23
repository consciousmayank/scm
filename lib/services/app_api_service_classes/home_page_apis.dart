import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/image_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class HomePageApis {
  Future<AllBrandsResponse?> getAllBrands({
    required int size,
    required int pageIndex,
    String searchTerm,
  });
  Future<ImageResponse?> getProductImage({required imageName});
}

class HomePageApisImpl extends BaseApi implements HomePageApis {
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

  @override
  Future<AllBrandsResponse?> getAllBrands({
    required int size,
    required int pageIndex,
    String? searchTerm,
  }) async {
    AllBrandsResponse? allBrandsResponse;

    ParentApiResponse apiResponse = await apiService.getAllBrands(
      brandToSearch: searchTerm,
      pageNumber: pageIndex,
      pageSize: size,
    );
    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      allBrandsResponse = AllBrandsResponse.fromMap(apiResponse.response?.data);
    }

    if (allBrandsResponse != null) {
      return allBrandsResponse;
    } else {
      return null;
    }
  }
}
