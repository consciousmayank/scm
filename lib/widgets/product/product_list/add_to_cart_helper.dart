import 'package:scm/app/app.locator.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/app_api_service_classes/demand_cart_api.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/product/product_details/product_add_to_cart_dialogbox_view.dart';
import 'package:stacked_services/stacked_services.dart';

class AddToCart extends GeneralisedBaseViewModel {
  AddToCart({
    required this.supplierId,
  });

  final int supplierId;

  final DemandCartApi _cartApi = locator<DemandCartApi>();

  void openProductQuantityDialogBox({
    required Product product,
    int? quantity,
  }) async {
    DialogResponse? resetCartResponse;
    if (preferences.getDemandersCart().supplyId != null &&
        preferences.getDemandersCart().supplyId != supplierId) {
      resetCartResponse = await dialogService.showConfirmationDialog(
        title: labelResetOrder,
        description: labelResetOrderDescription,
        barrierDismissible: true,
        cancelTitle: labelCancel,
        confirmationTitle: labelYes,
        dialogPlatform: DialogPlatform.Material,
      );

      if (resetCartResponse != null && resetCartResponse.confirmed) {
        preferences.setDemandersCart(cart: null);

        await dialogService
            .showCustomDialog(
          variant: DialogType.ADD_PRODUCT_TO_CART,
          data: ProductAddToCartDialogBoxViewArguments(
            title: product.title!,
            productId: product.id!,
            supplierId: supplierId,
          ),
        )
            .then((value) async {
          if (value != null && value.confirmed) {
            ProductAddToCartDialogBoxViewOutArguments args = value.data;

            if (args.cartItem == null) {
              addProductToCart(
                  productId: args.productId,
                  productQuantity: args.quantity,
                  productTitle: product.title!);
            } else {
              updateProductInCart(cartItem: args.cartItem!);
            }
          }
        });
      }
    } else {
      await dialogService
          .showCustomDialog(
        variant: DialogType.ADD_PRODUCT_TO_CART,
        data: ProductAddToCartDialogBoxViewArguments(
          title: product.title!,
          quantity: quantity,
          productId: product.id!,
          supplierId: supplierId,
        ),
      )
          .then((value) async {
        if (value != null && value.confirmed) {
          ProductAddToCartDialogBoxViewOutArguments args = value.data;

          if (args.cartItem == null) {
            addProductToCart(
                productId: args.productId,
                productQuantity: args.quantity,
                productTitle: product.title!);
          } else {
            updateProductInCart(cartItem: args.cartItem!);
          }
        }
      });
    }
  }

  void addProductToCart({
    required int productId,
    required int productQuantity,
    required String productTitle,
  }) async {
    setBusy(true);
    Cart cart = await _cartApi.addToCart(
      productId: productId,
      quantity: productQuantity,
      productTitle: productTitle,
      supplierId: supplierId,
    );

    setBusy(false);

    if (cart.id! > 0) {
      showInfoSnackBar(
          message: addedProductTocart(
            productTitle: productTitle,
          ),
          secondsToShowSnackBar: 1);
    } else {
      showErrorSnackBar(
        message: addedProductTocartError(
          productTitle: productTitle,
        ),
      );
    }
  }

  Future updateProductInCart({required CartItem cartItem}) async {
    setBusy(true);
    Cart cart = await _cartApi.updateCart(
      cartItem: cartItem,
      supplierId: supplierId,
    );

    setBusy(false);

    if (cart.id! > 0) {
      if (cartItem.itemQuantity == 0) {
        showInfoSnackBar(
            message: removedFromCart(productTitle: cartItem.itemTitle!),
            secondsToShowSnackBar: 1);
      } else {
        showInfoSnackBar(
            message: updatedInCart(
                productTitle: cartItem.itemTitle!,
                quantity: cartItem.itemQuantity!),
            secondsToShowSnackBar: 1);
      }
    } else {
      showErrorSnackBar(
          message: notUpdatedInCart(
              productTitle: cartItem.itemTitle!,
              quantity: cartItem.itemQuantity!),
          secondsToShowSnackBar: 1);
    }

    return cart;
  }
}
