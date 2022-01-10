import 'dart:async';

class CatalogStream {
  List<CatalogItems> loggedInSupplerCatalogItemsList = [];

  StreamController<CatalogItems> catalogController =
      StreamController<CatalogItems>.broadcast();

  Stream<CatalogItems> get onNewData => catalogController.stream;

  StreamController get controller => catalogController;

  void addToStream(CatalogItems data) {
    loggedInSupplerCatalogItemsList.add(data);
    controller.add(data);
  }

  void removeFromStream(CatalogItems data) {
    loggedInSupplerCatalogItemsList.remove(data);
    controller.add(data);
  }

  List<CatalogItems> get getCatalog => loggedInSupplerCatalogItemsList;

  void dispose() {
    catalogController.close();
  }
}

class CatalogItems {
  final int productId;
  final String productTitle;
  CatalogItems({
    required this.productId,
    required this.productTitle,
  });
}
