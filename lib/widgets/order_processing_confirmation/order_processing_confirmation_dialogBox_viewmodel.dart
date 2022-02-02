import 'package:scm/model_classes/order_list_response.dart';
import 'package:stacked/stacked.dart';

class OrderProcessingConfirmationDialogBoxViewModel extends BaseViewModel {
  isPriceInAnyProductMissing({required List<OrderItem> orderList}) {
    for (var i = 0; i < orderList.length; i++) {
      if (orderList[i].itemPrice == null || orderList[i].itemPrice == 0) {
        return true;
      }
    }
    return false;
  }
}
