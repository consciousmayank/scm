import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:scm/app/app.locator.dart';
import 'package:scm/app/app.locator.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/model_classes/order_summary_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/order_list_page/order_list_page_view.dart';
import 'package:scm/services/app_api_service_classes/common_dashboard_apis.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/delivery_details_dialog_box.dart';
import 'package:scm/widgets/product/product_details/product_detail_dialog_box_view.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderListPageViewModel extends GeneralisedBaseViewModel {
  late final OrderListPageViewArguments args;
  OrderSummaryResponse orderDetails = OrderSummaryResponse().empty();
  ApiStatus orderDetailsApi = ApiStatus.LOADING;
  OrderListResponse orderList = OrderListResponse().empty();
  ApiStatus orderListApi = ApiStatus.LOADING;
  List<String> orderStatusList = ['ALL'];
  ApiStatus ordersStatusListApi = ApiStatus.LOADING;
  int pageNumber = 0;
  int pageSize = 15;
  List<TextEditingController> priceEditingControllers = [];
  List<FocusNode> priceEditingFocusnodes = [];
  List<TextEditingController> quantityEditingControllers = [];
  List<FocusNode> quantityEditingFocusnodes = [];
  Order selectedOrder = Order().empty();
  String selectedOrderStatus = 'ALL';

  final CommonDashBoardApis _commonDashBoardApis =
      locator<CommonDashBoardApis>();

  void initializeEditexts() {
    orderDetails.orderItems?.forEach((element) {
      element.edit = true;
      priceEditingControllers.add(TextEditingController());
      quantityEditingControllers.add(
        TextEditingController(
            // text: orderDetails.orderItems!
            //     .elementAt(orderDetails.orderItems!.indexOf(element))
            //     .itemQuantity
            //     .toString()
            //     .toString(),
            ),
      );
      priceEditingFocusnodes.add(FocusNode());
      quantityEditingFocusnodes.add(FocusNode());
    });
    notifyListeners();
  }

  init(OrderListPageViewArguments arguments) {
    args = arguments;

    if (!args.hideOrdersList) {
      selectedOrderStatus = arguments.preDefinedOrderStatus;
      selectedOrder = arguments.selectedOrder ?? Order().empty();
      getOrderStatusList();
      getOrderList();
    } else {
      getOrdersDetails(orderId: arguments.orderId.toString());
    }
  }

  getOrderList() async {
    orderListApi = ApiStatus.LOADING;
    orderList = await _commonDashBoardApis.getOrdersList(
      pageSize: pageSize,
      pageNumber: pageNumber,
      status: selectedOrderStatus,
    );

    if (args.selectedOrder == null) {
      //if selected order is null then we need to set the selected order to the first order
      if (selectedOrder.id == Order().empty().id) {
        selectedOrder = orderList.orders!.first;
      } else {
        selectedOrder = getSelectedOrder(ordersListResponse: orderList);
      }
    }

    if (orderList.orders!.isNotEmpty) {
      getOrdersDetails();
    } else {
      orderDetails = OrderSummaryResponse().empty();
    }
    orderListApi = ApiStatus.FETCHED;

    notifyListeners();
  }

  getOrdersDetails({
    String? orderId,
  }) async {
    orderDetailsApi = ApiStatus.LOADING;
    notifyListeners();
    orderDetails = await _commonDashBoardApis.getOrderDetails(
      orderId: orderId ?? selectedOrder.id.toString(),
    );

    if (orderDetails.status == OrderStatusTypes.PROCESSING.apiToAppTitles) {
      turnSelectedOrderItemsEditable();
      initializeEditexts();
    }

    orderDetailsApi = ApiStatus.FETCHED;

    notifyListeners();
  }

  void acceptOrder({required int? orderId}) async {
    orderDetailsApi = ApiStatus.LOADING;
    notifyListeners();
    orderDetails = await _commonDashBoardApis.acceptOrder(
      orderId: orderId.toString(),
    );
    if (orderDetails.id! > 0) {
      showInfoSnackBar(message: orderDetails.status ?? 'Success');
      turnSelectedOrderItemsEditable();
      initializeEditexts();
    }
    getOrderList();
    notifyListeners();
  }

  void rejectOrder({required int? orderId}) async {
    orderDetailsApi = ApiStatus.LOADING;
    notifyListeners();
    orderDetails = await _commonDashBoardApis.rejectOrder(
      orderId: orderId,
    );
    if (orderDetails.id! > 0) {
      showInfoSnackBar(message: orderDetails.status ?? 'Success');
      turnSelectedOrderItemsEditable(value: false);
    }
    orderDetailsApi = ApiStatus.FETCHED;
    orderListApi = ApiStatus.LOADING;
    getOrderList();
    notifyListeners();
  }

  Future<void> openDeliveryDetailsDialogBox({required int? orderId}) async {
    DialogResponse? dialogResponse = await dialogService.showCustomDialog(
      variant: DialogType.DELIVERY_DETAILS,
      barrierDismissible: true,
      data: DeliveryDetilasDialogBoxViewArguments(
          title: 'Enter Delivery Details'),
    );

    if (dialogResponse != null) {
      if (dialogResponse.confirmed) {
        DeliveryDetilasDialogBoxViewOutArguments? args = dialogResponse.data;
        if (args != null) {
          deliverOrder(
            orderId: orderId,
            deliveredBy: args.deliveredBy,
          );
        }
      }
    }
  }

  void deliverOrder({
    required int? orderId,
    required String deliveredBy,
  }) async {
    orderDetailsApi = ApiStatus.LOADING;
    notifyListeners();
    orderDetails = await _commonDashBoardApis.deliverOrder(
      orderId: orderId,
      deliveryBy: deliveredBy,
    );
    if (orderDetails.id! > 0) {
      showInfoSnackBar(message: orderDetails.status ?? 'Success');
      turnSelectedOrderItemsEditable(
        value: false,
      );
    }
    orderDetailsApi = ApiStatus.FETCHED;
    orderListApi = ApiStatus.LOADING;
    getOrderList();
    notifyListeners();
  }

  void openProductDetails({
    required int productId,
    required String productTitle,
  }) async {
    await dialogService.showCustomDialog(
      variant: DialogType.PRODUCT_DETAILS,
      data: ProductDetailDialogBoxViewArguments(
        // title: product.title ?? '',
        title: productTitle,
        productId: productId, product: null,
      ),
    );
  }

  void turnSelectedOrderItemsEditable({bool? value}) {
    List<OrderItem>? orderItems = orderDetails.orderItems;

    for (var element in orderItems!) {
      element.edit = value ?? true;
    }

    orderDetails = orderDetails.copyWith(
      orderItems: orderItems,
    );
    notifyListeners();
  }

  // String get selectedOrderStatus => _selectedOrderStatus;

  // set selectedOrderStatus(String selectedOrderStatus) {
  //   _selectedOrderStatus =
  //       getOrderStatus(status: selectedOrderStatus, getApiStatus: true)
  //           .getInAppStatusStringValues;
  // }

  void getOrderStatusList() async {
    setBusy(true);
    List<dynamic>? mapList = await _commonDashBoardApis.getOrderStatusList();
    mapList.forEach((element) {
      orderStatusList.add(
        getApiToAppOrderStatus(
          status: element,
        ),
      );
    });

    selectedOrderStatus = orderStatusList.first;
    setBusy(false);
  }

  updateQuantity({required int index, required String quantity}) {
    if (quantity.isEmpty) {
      quantity = '0';
    }

    List<OrderItem> orderItems = orderDetails.orderItems!;
    OrderItem orderItem = orderItems.elementAt(index);
    // orderItems.removeAt(index);
    orderItem.itemQuantity = int.parse(quantity);
    orderItem.itemTotalPrice = orderItem.itemPrice! * orderItem.itemQuantity!;

    double totalOrderPrice = getTotalOrderPrice(order: orderDetails);

    orderDetails = orderDetails.copyWith(
      orderItems: orderItems,
      totalAmount: totalOrderPrice,
    );
    notifyListeners();
  }

  void updatePrice({required int index, required String price}) {
    if (price.isEmpty) {
      price = '0';
    }
    List<OrderItem> orderItems = orderDetails.orderItems!;
    OrderItem orderItem = orderItems.elementAt(index);
    // orderItems.removeAt(index);
    orderItem.itemPrice = double.parse(price);
    orderItem.itemTotalPrice = orderItem.itemPrice! * orderItem.itemQuantity!;
    double totalOrderPrice = getTotalOrderPrice(order: orderDetails);
    orderDetails = orderDetails.copyWith(
      orderItems: orderItems,
      totalAmount: totalOrderPrice,
    );
    notifyListeners();
  }

  double getTotalOrderPrice({required OrderSummaryResponse order}) {
    double totalOrderPrice = 0;
    List<OrderItem>? orderItems = order.orderItems;
    for (var element in orderItems!) {
      totalOrderPrice += element.itemTotalPrice!;
    }
    return totalOrderPrice;
  }

  void updateTotal({
    required double price,
    required int quantity,
    required int index,
  }) {
    List<OrderItem> orderItems = orderDetails.orderItems!;
    OrderItem orderItem = orderItems.elementAt(index);
    // orderItems.removeAt(index);
    orderItem.itemPrice = price;
    orderItem.itemQuantity = quantity;
    orderItem.itemTotalPrice = orderItem.itemPrice! * orderItem.itemQuantity!;
    double totalOrderPrice = getTotalOrderPrice(order: orderDetails);
    orderDetails = orderDetails.copyWith(
      orderItems: orderItems,
      totalAmount: totalOrderPrice,
    );

    notifyListeners();
  }

  // void updateOrderItem({OrderItem orderItem}) {}

  updateOrder() async {
    orderDetailsApi = ApiStatus.LOADING;
    notifyListeners();
    orderDetails = await _commonDashBoardApis.updateOrder(
      orderDetials: orderDetails,
    );

    setBusy(false);
    orderDetailsApi = ApiStatus.FETCHED;
    orderListApi = ApiStatus.LOADING;
    getOrderList();
    notifyListeners();
  }

  Order getSelectedOrder({OrderListResponse? ordersListResponse}) {
    Order order = Order().empty();
    if (orderList.orders == null || orderList.orders!.isEmpty) {
      return order;
    }

    for (var element in orderList.orders!) {
      if (element.id == selectedOrder.id) {
        order = element;
        break;
      }
    }

    if (ordersListResponse!.orders!.isNotEmpty) {
      order = ordersListResponse.orders!.first;
    }

    return order;
  }
}
