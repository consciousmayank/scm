import 'dart:async';

import 'package:scm/model_classes/cart.dart';

class CartStream {
  StreamController<Cart> cartController = StreamController<Cart>.broadcast();

  Stream<Cart> get onNewData => cartController.stream;

  StreamController get controller => cartController;

  void dispose() {
    cartController.close();
  }
}
