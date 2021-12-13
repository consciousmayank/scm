import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/app_api_service_classes/product_api.dart';

class ProductsListViewModel extends GeneralisedBaseViewModel {
  int pageNumber = 0, pageSize = 20;
  ProductListResponse productListResponse = ProductListResponse().empty();

  final ProductApis _productApis = di<ProductApis>();

  getProductList() async {
    if (pageNumber <= productListResponse.totalPages!) {
      setBusy(true);
      ProductListResponse tempResponse =
          await _productApis.getAllAddedProductsList(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

      if (pageNumber == 0) {
        productListResponse = tempResponse;
      } else {
        productListResponse = productListResponse.copyWith(
          products: List.from(productListResponse.products!)
            ..addAll(tempResponse.products!),
          currentPage: tempResponse.currentPage,
          totalItems: tempResponse.totalItems,
          totalPages: tempResponse.totalPages,
        );
      }
      pageNumber++;
    }
    setBusy(false);
    notifyListeners();
  }
}
