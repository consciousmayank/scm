import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/app_api_service_classes/demand_cart_api.dart';
import 'package:scm/widgets/product/product_details/product_add_to_cart_dialogbox_view.dart';
import 'package:stacked_services/stacked_services.dart';

class AddToCart extends GeneralisedBaseViewModel {
  final int supplierId;

  final DemandCartApi _cartApi = di<DemandCartApi>();

  AddToCart({
    required this.supplierId,
  });

  void openProductQuantityDialogBox({
    required Product product,
  }) async {
    DialogResponse? resetCartResponse;
    if (preferences.getDemandersCart().supplyId != supplierId) {
      resetCartResponse = await dialogService.showConfirmationDialog(
        title: 'Reset Cart ?',
        description:
            'You already have a cart populated with another suppleir\'s products. Adding this product will reset your old cart. Do you want to reset the cart ?',
        barrierDismissible: true,
        cancelTitle: 'Cancel',
        confirmationTitle: 'Yes',
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
      showInfoSnackBar(message: '$productTitle added to cart');
    } else {
      showErrorSnackBar(message: '$productTitle not added to cart');
    }
  }

  void updateProductInCart({required CartItem cartItem}) async {
    setBusy(true);
    Cart cart = await _cartApi.updateCart(
      cartItem: cartItem,
      supplierId: supplierId,
    );

    setBusy(false);

    if (cart.id! > 0) {
      showInfoSnackBar(
          message:
              '${cartItem.itemTitle} quantity updated to ${cartItem.itemQuantity}');
    } else {
      showErrorSnackBar(
          message:
              '${cartItem.itemTitle} quantity not updated to ${cartItem.itemQuantity}');
    }
  }
}
