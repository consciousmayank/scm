import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/screens/pim_homescreen/get_product_by_id_dialog_box/get_product_by_id_dialog_box_view.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_view.dart';
import 'package:scm/screens/pim_homescreen/update_product_dialog/update_product_dialog_view.dart';
import 'package:scm/services/app_api_service_classes/product_api.dart';
import 'package:scm/utils/strings.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductsListViewModel extends GeneralisedBaseViewModel {
  late final ProductsListViewArguments arguments;
  int pageNumber = 0, pageSize = 15;
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

      productListResponse = tempResponse;
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

  getProductById() async {
    await dialogService.showCustomDialog(
      variant: DialogType.GET_PRODUCT_BY_ID,
      barrierDismissible: true,
      data: GetProductByIdDialogBoxViewArguments(title: labelGetProductById),
    );
  }

  // void sort<T>(
  //   Comparable<T> Function(Product user) getField,
  //   int colIndex,
  //   bool asc,
  //   ProductListDataSource _src,
  //   UserDataNotifier _provider,
  // ) {
  //   _src.sort<T>(getField, asc);
  //   _provider.sortAscending = asc;
  //   _provider.sortColumnIndex = colIndex;
  // }
}
