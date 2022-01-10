import 'package:scm/app/di.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/enums/update_product_api_type.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/app_api_service_classes/supplier_catalog_apis.dart';
import 'package:scm/services/streams/cart_stream.dart';
import 'package:scm/services/streams/catalog_stream.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/product/product_list/add_to_cart_helper.dart';
import 'package:scm/widgets/product/product_list/add_to_catalog_helper.dart';
import 'package:scm/widgets/product/product_list_item_v2/product_list_item_2.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const String _CatalogStreamKey = 'catalog-stream';
const String _CartStreamKey = 'cart-stream';

class ProductListItem2ViewModel extends MultipleStreamViewModel {
  // final AppPreferences _preferences = di<AppPreferences>();
  final CatalogStream _catalogStream = di<CatalogStream>();

  late Cart cartData;
  late CartItem cartItem;
  late CatalogItems catalogItem;
  late AddToCart? addToCarthelper;
  // late AddToCatalog? addToCataloghelper;

  onRemoveButtonClick() {
    if (addToCarthelper != null) {
      addToCarthelper!
          .updateProductInCart(cartItem: cartItem.copyWith(itemQuantity: 0));
    } else {
      removeProductFromCatalog(
        productId: args.product!.id!,
        productTitle: args.product!.title!,
      ).then((value) => args.onProductOperationCompleted());
    }
  }

  void onAddButtonClick() {
    if (addToCarthelper != null) {
      addToCarthelper!.openProductQuantityDialogBox(
        product: args.product!,
      );
    } else {
      addProductToCatalog(
        productId: args.product!.id!,
        productTitle: args.product!.title!,
      );
    }
  }

  late final ProductListItem2ViewArguments args;
  init({required ProductListItem2ViewArguments args}) {
    this.args = args;
    cartData = di<CartStream>().appCart;
    if (args.supplierId == null) {
      //this user is a supply user. He can only do Add to catalog.
      // addToCataloghelper = AddToCatalog();
      addToCarthelper = null;
    } else {
      addToCarthelper = AddToCart(
        supplierId: args.supplierId!,
      );
      // addToCataloghelper = null;
    }
  }

  @override
  Map<String, StreamData> get streamsMap => {
        _CartStreamKey: StreamData<Cart>(cartStream()),
        _CatalogStreamKey: StreamData<CatalogItems>(catalogStream()),
      };

  Stream<Cart> cartStream() => di<CartStream>().onNewData;
  Stream<CatalogItems> catalogStream() => di<CatalogStream>().onNewData;

  @override
  void onData(String key, data) {
    super.onData(key, data);
    if (key == _CartStreamKey) {
      cartData = data;
      notifyListeners();
    } else {
      catalogItem = data;
      notifyListeners();
    }
  }

  bool isProductInCart({required int? productId}) {
    if (productId == null) {
      return false;
    }

    if (cartData.id == null) {
      return false;
    }

    bool returningValue = false;

    cartData.cartItems?.forEach((element) {
      if (element.itemId == productId) {
        returningValue = true;
        cartItem = element;
        notifyListeners();
      }
    });

    return returningValue;
  }

  void onUpdateButtonClick() {
    if (addToCarthelper != null) {
      addToCarthelper!.openProductQuantityDialogBox(
        product: args.product!,
      );
    }
  }

  final SupplierCatalogApis _catalogApis = di<SupplierCatalogApis>();

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
      if (response.message == addedProductToCatalogServerMEssage) {
        showInfoSnackBar(
            message: addedProductToCatalogServerMEssage,
            secondsToShowSnackBar: 1);
        _catalogStream.addToStream(
          CatalogItems(
            productId: productId,
            productTitle: productTitle,
          ),
        );
      } else {
        showInfoSnackBar(
            message: addedProductToCatalog(
              productTitle: productTitle,
            ),
            secondsToShowSnackBar: 1);
      }
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
      _catalogStream.removeFromStream(
        CatalogItems(
          productId: productId,
          productTitle: productTitle,
        ),
      );
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

  SnackbarService snackBarService = di<SnackbarService>();
  void showErrorSnackBar({
    required String message,
    Function? onSnackBarOkButton,
    int secondsToShowSnackBar = 4,
  }) {
    if (onSnackBarOkButton != null) {
      snackBarService.showCustomSnackBar(
        variant: SnackbarType.ERROR,
        duration: Duration(
          seconds: secondsToShowSnackBar,
        ),
        mainButtonTitle: 'Ok',
        onMainButtonTapped: () {
          onSnackBarOkButton.call();
        },
        title: "Error",
        message: message,
      );
    } else {
      snackBarService.showCustomSnackBar(
        variant: SnackbarType.ERROR,
        duration: Duration(
          seconds: secondsToShowSnackBar,
        ),
        message: message,
        title: "Error",
      );
    }
  }

  ///This will help in showing info snackbar
  ///
  void showInfoSnackBar({
    required String message,
    int secondsToShowSnackBar = 4,
  }) {
    snackBarService.showCustomSnackBar(
      variant: SnackbarType.NORMAL,
      duration: Duration(
        seconds: secondsToShowSnackBar,
      ),
      message: message,
    );
  }

  isProductInCatalog({int? productId}) {
    if (productId == null) {
      return false;
    }

    if (_catalogStream.loggedInSupplerCatalogItemsList.isEmpty) {
      return false;
    }

    bool returningValue = false;

    _catalogStream.loggedInSupplerCatalogItemsList.forEach((element) {
      if (element.productId == productId) {
        returningValue = true;
        catalogItem = element;
        notifyListeners();
      }
    });

    return returningValue;
  }
}
