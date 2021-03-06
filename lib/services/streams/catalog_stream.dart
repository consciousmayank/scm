import 'dart:async';

class CatalogStream {
  StreamController<CatalogItems> catalogController =
      StreamController<CatalogItems>.broadcast();

  List<CatalogItems> loggedInSupplerCatalogItemsList = [];

  Stream<CatalogItems> get onNewData => catalogController.stream;

  StreamController get controller => catalogController;

  void addToStream(CatalogItems data) {
    if (!loggedInSupplerCatalogItemsList.contains(data)) {
      loggedInSupplerCatalogItemsList.add(data);
      controller.add(data);
    }
  }

  void removeFromStream(CatalogItems data) {
    loggedInSupplerCatalogItemsList
        .removeWhere((element) => element.productId == data.productId);
    controller.add(data);
  }

  List<CatalogItems> get getCatalog => loggedInSupplerCatalogItemsList;

  void dispose() {
    catalogController.close();
  }
}

class CatalogItems {
  CatalogItems({
    required this.productId,
    required this.productTitle,
  });

  final int productId;
  final String productTitle;
}
