import 'package:scm/app/app.locator.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/update_product_api_type.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/services/app_api_service_classes/supplier_catalog_apis.dart';
import 'package:scm/utils/strings.dart';

class AddToCatalog extends GeneralisedBaseViewModel {
  AddToCatalog();

  final SupplierCatalogApis _catalogApis = locator<SupplierCatalogApis>();

  void addProductToCatalog({
    required int productId,
    required String productTitle,
  }) async {
    setBusy(true);
    ApiResponse response = await _catalogApis.updateProductById(
      productId: productId,
      apiToHit: UpdateProductApiSelection.ADD_PRODUCT,
    );

    setBusy(false);

    if (response.isSuccessful()) {
      showInfoSnackBar(
          message: addedProductToCatalog(
            productTitle: productTitle,
          ),
          secondsToShowSnackBar: 1);
    } else {
      showErrorSnackBar(
        message: addedProductToCatalogError(
          productTitle: productTitle,
        ),
      );
    }
  }

  Future removeProductFromCatalog({
    required int productId,
    required String productTitle,
  }) async {
    setBusy(true);
    ApiResponse response = await _catalogApis.updateProductById(
      productId: productId,
      apiToHit: UpdateProductApiSelection.DELETE_PRODUCT,
    );

    setBusy(false);

    if (response.isSuccessful()) {
      showInfoSnackBar(
          message: removeProductToCatalog(
            productTitle: productTitle,
          ),
          secondsToShowSnackBar: 1);
      return Future.value(true);
    } else {
      showErrorSnackBar(
        message: removeProductTocartError(
          productTitle: productTitle,
        ),
      );
      return Future.value(false);
    }
  }
}
