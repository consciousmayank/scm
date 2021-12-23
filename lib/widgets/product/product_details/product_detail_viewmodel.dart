import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/app_api_service_classes/product_list_apis.dart';
import 'package:scm/widgets/product/product_details/product_detail_view.dart';

class ProductDetailViewModel extends GeneralisedBaseViewModel {
  late final ProductDetailViewArguments arguments;
  Product? product;

  final ProductListApis _productListApis = di<ProductListApiImpl>();

  init({required ProductDetailViewArguments arguments}) {
    if (arguments.product == null) {
      this.arguments = arguments;
    } else {
      product = arguments.product;
    }
  }

  getProductById({int? productId}) async {
    setBusy(true);
    product = await _productListApis.getProductById(productId: productId);
    setBusy(false);
    notifyListeners();
  }
}
