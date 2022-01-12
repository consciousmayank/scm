import 'package:scm/app/app.locator.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/services/app_api_service_classes/brand_apis.dart';

class BrandsDialogBoxViewModel extends GeneralisedBaseViewModel {
  AllBrandsResponse allBrandsResponse = AllBrandsResponse().empty();
  String brandToSearch = '';
  int pageNumber = 0, pageSize = 20;

  final BrandsApi _brandsApi = locator<BrandsApi>();

  getAllBrands({
    bool showLoader = true,
  }) async {
    if (pageNumber <= allBrandsResponse.totalPages!) {
      if (showLoader) {
        setBusy(true);
      }

      AllBrandsResponse tempResponse = await _brandsApi.getAllBrandsFromPim(
        pageNumber: pageNumber,
        pageSize: pageSize,
        brandToSearch: brandToSearch,
      );

      if (pageNumber == 0) {
        allBrandsResponse = tempResponse;
      } else {
        allBrandsResponse = allBrandsResponse.copyWith(
          brands: List.from(allBrandsResponse.brands!)
            ..addAll(tempResponse.brands!),
          currentPage: tempResponse.currentPage,
          totalItems: tempResponse.totalItems,
          totalPages: tempResponse.totalPages,
        );
      }
      pageNumber++;
    }

    setBusy(false);
  }

  void searchBrands(String value) {
    brandToSearch = value;
    pageNumber = 0;
    getAllBrands();
  }
}
