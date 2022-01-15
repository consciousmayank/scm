import 'package:scm/app/di.dart';
import 'package:scm/enums/cart_api_types.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/services/network/base_api.dart';
import 'package:scm/services/streams/cart_stream.dart';

abstract class DemandCartApiAbstractClass {
  Future<Cart> getCart();

  Future<Cart> addToCart({
    required int productId,
    required int quantity,
    required String productTitle,
    required int supplierId,
  });

  Future<Cart> updateCart({
    required CartItem cartItem,
    required int supplierId,
  });

  Future<Cart> updateCartItem({
    required CartItem cartItem,
    required int supplierId,
  });
}

class DemandCartApi extends BaseApi implements DemandCartApiAbstractClass {
  final CartStream cartService = locator<CartStream>();

  @override
  Future<Cart> addToCart({
    required int productId,
    required int quantity,
    required String productTitle,
    required int supplierId,
  }) async {
    Cart returningCart = cartService.appCart;
    String? userName = preferences.getApiToken();

    if (returningCart.id == null) {
      returningCart = returningCart.copyWith(
        supplyId: supplierId,
        id: null,
        cartItems: [
          CartItem(
            itemId: productId,
            itemPrice: 0,
            itemQuantity: quantity,
            itemTitle: productTitle,
          )
        ],
      );
    } else {
      returningCart.cartItems!.add(
        CartItem(
          itemId: productId,
          itemPrice: 0,
          itemQuantity: quantity,
          itemTitle: productTitle,
        ),
      );
    }

    ParentApiResponse cartResponse = await apiService.performCartOperation(
      apiType: CartApiTypes.ADD_TO_CART,
      addCartJson: returningCart.toJson(),
    );

    if (filterResponse(cartResponse) != null) {
      returningCart = Cart.fromMap(
        cartResponse.response!.data,
      );
    }
    cartService.addToStream(returningCart);
    return returningCart;
  }

  @override
  Future<Cart> getCart() async {
    Cart cart = Cart().empty();
    ParentApiResponse cartResponse = await apiService.performCartOperation(
      apiType: CartApiTypes.GET_CART,
    );

    if (filterResponse(
          cartResponse,
          showSnackBar: false,
        ) !=
        null) {
      cart = Cart.fromMap(
        cartResponse.response!.data,
      );
    }

    cartService.addToStream(cart);

    return cart;
  }

  @override
  Future<Cart> updateCart({
    required CartItem cartItem,
    required int supplierId,
  }) async {
    Cart returningCart = cartService.appCart;

    if (returningCart.id == null) {
      addToCart(
        productId: cartItem.itemId!,
        quantity: cartItem.itemQuantity!,
        productTitle: cartItem.itemTitle!,
        supplierId: supplierId,
      );
    } else {
      int index = -1;

      for (var element in returningCart.cartItems!) {
        if (element.itemId == cartItem.itemId) {
          index = returningCart.cartItems!.indexOf(element);
        }
      }

      if (index != -1) {
        returningCart.cartItems!.removeAt(index);
        if (cartItem.itemQuantity! > 0) {
          returningCart.cartItems!.add(cartItem);
        }
      }

      // returningCart.cartItems!.add(
      //   CartItem(
      //     itemId: cartItem.itemId!,
      //     itemPrice: 0,
      //     itemQuantity: cartItem.itemQuantity!,
      //     itemTitle: cartItem.itemTitle!,
      //   ),
      // );
    }

    ParentApiResponse cartResponse = await apiService.performCartOperation(
      apiType: CartApiTypes.UPDATE_CART,
      updateCartJson: returningCart.toJson(),
    );

    if (filterResponse(cartResponse) != null) {
      returningCart = Cart.fromMap(
        cartResponse.response!.data,
      );
    }
    cartService.addToStream(returningCart);
    return returningCart;
  }

  @override
  Future<Cart> updateCartItem(
      {required CartItem cartItem, required int supplierId}) {
    // TODO: implement updateCartItem
    throw UnimplementedError();
  }
}
