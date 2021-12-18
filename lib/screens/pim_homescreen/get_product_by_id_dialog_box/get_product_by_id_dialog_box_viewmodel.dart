import 'package:flutter/cupertino.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/app_api_service_classes/product_api.dart';

class GetProductByIdDialogBoxViewModel extends GeneralisedBaseViewModel {
  Product? product;
  TextEditingController productIdController = TextEditingController();
  FocusNode productIdFocusNode = FocusNode();

  final ProductApis _productApis = di<ProductApis>();

  void getProductById({required int productId}) async {
    setBusy(true);
    product = await _productApis.getProductById(productId: productId);
    setBusy(false);
    notifyListeners();
  }
}
