import 'package:scm/app/di.dart';
import 'package:scm/enums/product_image_types.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/enums/update_product_api_type.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/app_api_service_classes/image_api.dart';
import 'package:scm/services/app_api_service_classes/supplier_catalog_apis.dart';
import 'package:scm/services/sharepreferences_service.dart';
import 'package:scm/services/streams/cart_stream.dart';
import 'package:scm/services/streams/catalog_stream.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/product/product_list/add_to_cart_helper.dart';
import 'package:scm/widgets/product/product_list_item_v2/product_list_item_2.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const String _CatalogStreamKey = 'catalog-stream';
const String _CartStreamKey = 'cart-stream';

class ProductListItem2ViewModel extends MultipleStreamViewModel {
  late AddToCart? addToCarthelper;
  late final ProductListItem2ViewArguments args;
  late Cart cartData;
  late CartItem cartItem;
  late CatalogItems catalogItem;
  bool imageLoaded = false;
  final preferences = locator<AppPreferencesService>();
  String? productImage;
  List<Image> productImages = [];
  SnackbarService snackBarService = locator<SnackbarService>();

  final SupplierCatalogApis _catalogApis = locator<SupplierCatalogApis>();
  // final AppPreferences _preferences = locator<AppPreferences>();
  final CatalogStream _catalogStream = locator<CatalogStream>();

  final ImageApi _imageApi = locator<ImageApi>();

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

  @override
  Map<String, StreamData> get streamsMap => {
        _CartStreamKey: StreamData<Cart>(cartStream()),
        _CatalogStreamKey: StreamData<CatalogItems>(catalogStream()),
      };

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

  init({required ProductListItem2ViewArguments args}) {
    this.args = args;
    cartData = locator<CartStream>().appCart;
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

  Stream<Cart> cartStream() => locator<CartStream>().onNewData;

  Stream<CatalogItems> catalogStream() => locator<CatalogStream>().onNewData;

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
      _catalogStream.addToStream(
        CatalogItems(
          productId: productId,
          productTitle: productTitle,
        ),
      );
      if (response.message == addedProductToCatalogServerMEssage) {
        showInfoSnackBar(
            message: addedProductToCatalogServerMEssage,
            secondsToShowSnackBar: 1);
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
    notifyListeners();
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
      _catalogStream.removeFromStream(
        CatalogItems(
          productId: productId,
          productTitle: productTitle,
        ),
      );
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

    for (var element in _catalogStream.loggedInSupplerCatalogItemsList) {
      if (element.productId == productId) {
        returningValue = true;
        catalogItem = element;
        notifyListeners();
      }
    }

    return returningValue;
  }

  bool isSupplier() {
    return preferences.getSelectedUserRole() ==
        AuthenticatedUserRoles.ROLE_SUPPLY.getStatusString;
  }

  void getProductImageFromApi({
    required int productId,
    int? supplierId,
    bool? isForCatalog,
  }) async {
    setBusy(true);

    ProductImagesType productImagesType = ProductImagesType.STANDARD;
    if (isForCatalog != null && isForCatalog) {
      productImagesType = ProductImagesType.SUPPLIER_CATALOG;
      supplierId = preferences.getSupplierDemandProfile()?.id;
    } else if (supplierId != null) {
      productImagesType = ProductImagesType.DEMAND;
    } else {
      productImagesType = ProductImagesType.STANDARD;
    }

    productImages = await _imageApi.getProductImage(
      productId: productId,
      productImagesType: productImagesType,
      supplierId: supplierId,
    );
    if (productImages.isNotEmpty) {
      productImage = checkImageUrl(
        imageUrl: productImages[0].image,
      );
    } else {
      productImage = null;
    }
    setBusy(false);
    notifyListeners();
  }
}
