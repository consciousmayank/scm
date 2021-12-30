import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/cart_icon/cart_icon_view.dart';
import 'package:scm/services/app_api_service_classes/demand_cart_api.dart';
import 'package:scm/utils/utils.dart';

class CartIconViewModel extends GeneralisedBaseViewModel {
  final DemandCartApi _demandCartApi = di<DemandCartApi>();
  Cart cart = Cart().empty();

  ApiStatus getCartApiStatus = ApiStatus.LOADING;

  late final CartIconViewArguments arguments;
  init({required CartIconViewArguments args}) {
    arguments = args;
    getCart();
  }

  void getCart() async {
    cart = await _demandCartApi.getCart();
    getCartApiStatus = ApiStatus.FETCHED;
    notifyListeners();
  }
}
