import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/services/app_api_service_classes/brand_apis.dart';

class BrandsDialogBoxViewModel extends GeneralisedBaseViewModel {
  AllBrandsResponse allBrandsResponse = AllBrandsResponse().empty();
  int pageNumber = 0, pageSize = 20;

  final BrandsApi _brandsApi = di<BrandsApi>();

  getAllBrands({
    bool showLoader = true,
  }) async {
    if (pageNumber <= allBrandsResponse.totalPages!) {
      if (showLoader) {
        setBusy(true);
      }

      AllBrandsResponse tempResponse = await _brandsApi.getAllBrands(
        pageNumber: pageNumber,
        pageSize: pageSize,
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
}
