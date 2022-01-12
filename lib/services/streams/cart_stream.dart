import 'dart:async';

import 'package:scm/model_classes/cart.dart';

class CartStream {
  Cart appCart = Cart().empty();
  StreamController<Cart> cartController = StreamController<Cart>.broadcast();

  Stream<Cart> get onNewData => cartController.stream;

  StreamController get controller => cartController;

  void addToStream(Cart data) {
    appCart = data;
    controller.add(data);
  }

  Cart get getCart => appCart;

  void dispose() {
    cartController.close();
  }
}
