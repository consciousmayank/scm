import 'dart:developer';

import 'package:scm/routes/routes_constants.dart';
import 'package:scm/app/di.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/cart_icon/cart_icon_view.dart';
import 'package:scm/services/streams/cart_stream.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CartIconViewModel extends StreamViewModel<Cart> {
  late final CartIconViewArguments arguments;
  Cart cart = Cart().empty();

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
    }
    super.onData(data);
  }

  @override
  void onError(error) {}

  @override
  void onSubscribed() {}

  @override
  Stream<Cart> get stream => locator<CartStream>().onNewData;

  init({required CartIconViewArguments args}) {
    arguments = args;
    getCart();
  }

  void getCart() async {
    // cart = await _demandCartApi.getCart();
    cart = locator<CartStream>().appCart;
    notifyListeners();
  }

  takeToCart() {
    _navigationService.navigateTo(
      cartViewPageRoute,
    );
  }
}
