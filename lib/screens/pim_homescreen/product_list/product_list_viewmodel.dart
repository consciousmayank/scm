import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_view.dart';
import 'package:scm/screens/pim_homescreen/update_product_dialog/update_product_dialog_view.dart';
import 'package:scm/services/app_api_service_classes/product_api.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductsListViewModel extends GeneralisedBaseViewModel {
  late final ProductsListViewArguments arguments;
  int pageNumber = 0, pageSize = 30;
  ProductListResponse productListResponse = ProductListResponse().empty();
  bool shouldCallGetProductsApi = true;

  final ProductApis _productApis = di<ProductApis>();

  getProductList({
    bool showLoader = false,
  }) async {
    if (shouldCallGetProductsApi) {
      if (showLoader) {
        setBusy(true);
      }
      ProductListResponse tempResponse;

      if (arguments.productListType == ProductListType.TODO) {
        tempResponse = await _productApis.getAllAddedProductsList(
          pageNumber: pageNumber,
          pageSize: pageSize,
        );
      } else {
        tempResponse = await _productApis.getAllPublishedProductsList(
          pageNumber: pageNumber,
          pageSize: pageSize,
        );
      }

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
      if (productListResponse.totalItems! ==
          productListResponse.products!.length) {
        shouldCallGetProductsApi = false;
      }
    }
    setBusy(false);
    notifyListeners();
  }

  init({required ProductsListViewArguments arguments}) {
    this.arguments = arguments;
    getProductList(showLoader: true);
  }

  void openProductDetailsDialog({required Product product}) async {
    DialogResponse? updateProductDialogResponse =
        await dialogService.showCustomDialog(
      variant: DialogType.UPDATE_PRODUCT,
      barrierDismissible: true,
      data: UpdateProductDialogBoxViewArguments(
        title: product.id!.toString(),
        product: product,
      ),
    );

    if (updateProductDialogResponse != null &&
        updateProductDialogResponse.confirmed) {
      shouldCallGetProductsApi = true;
      productListResponse = ProductListResponse().empty();
      pageNumber = 0;
      getProductList();
    }
  }
}
