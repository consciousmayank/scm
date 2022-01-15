import 'dart:developer';

import 'package:scm/app/di.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/cart_icon/cart_icon_view.dart';
import 'package:scm/services/streams/cart_stream.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CartIconViewModel extends StreamViewModel<Cart> {
  late final CartIconViewArguments arguments;
  Cart cart = Cart().empty();
  ApiStatus getCartApiStatus = ApiStatus.LOADING;

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void dispose() {
    log('streams: inside dispose');
    super.dispose();
  }

  @override
  void onData(Cart? data) {
    if (data != null) {
      cart = data;
      getCartApiStatus = ApiStatus.FETCHED;
    }
    super.onData(data);
  }

  @override
  void onError(error) {
    log('streams: inside onError $error');
  }

  @override
  void onSubscribed() {
    log('streams: inside onSubscribed');
  }

  @override
  Stream<Cart> get stream => locator<CartStream>().onNewData;

  init({required CartIconViewArguments args}) {
    arguments = args;
    getCart();
  }

  void getCart() async {
    // cart = await _demandCartApi.getCart();
    cart = locator<CartStream>().appCart;
    getCartApiStatus = ApiStatus.FETCHED;
    notifyListeners();
  }

  takeToCart() {
    _navigationService.navigateTo(
      cartViewPageRoute,
    );
  }
}
