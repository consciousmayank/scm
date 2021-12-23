import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/model_classes/order_summary_response.dart';
import 'package:scm/screens/order_list_page/order_list_page_view.dart';
import 'package:scm/services/app_api_service_classes/common_dashboard_apis.dart';

class OrderListPageViewModel extends GeneralisedBaseViewModel {
  OrderSummaryResponse orderDetails = OrderSummaryResponse().empty();
  ApiStatus orderDetailsApi = ApiStatus.LOADING;
  OrderListResponse orderList = OrderListResponse().empty();
  ApiStatus orderListApi = ApiStatus.LOADING;
  int pageNumber = 0;
  int pageSize = 15;
  late Order selectedOrder;

  final CommonDashBoardApis _commonDashBoardApis = di<CommonDashBoardApis>();

  init(OrderListPageViewArguments arguments) {
    getOrderList();
  }

  getOrderList() async {
    orderList = await _commonDashBoardApis.getOrdersList(
      pageSize: pageSize,
      pageNumber: pageNumber,
    );
    selectedOrder =
        orderList.orders == null ? Order().empty() : orderList.orders!.first;
    orderListApi = ApiStatus.FETCHED;
    getOrdersDetails();
    notifyListeners();
  }

  getOrdersDetails() async {
    orderDetailsApi = ApiStatus.LOADING;
    notifyListeners();
    orderDetails = await _commonDashBoardApis.getOrderDetails(
      orderId: selectedOrder.id.toString(),
    );
    orderDetailsApi = ApiStatus.FETCHED;
    notifyListeners();
  }
}
