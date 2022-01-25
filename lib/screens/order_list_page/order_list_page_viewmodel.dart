import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm/app/app.logger.dart';
import 'package:scm/app/di.dart';

import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/enums/order_filter_duration_type.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/model_classes/order_summary_response.dart';
import 'package:scm/screens/order_list_page/order_list_page_view.dart';
import 'package:scm/services/app_api_service_classes/common_dashboard_apis.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/delivery_details_dialog_box.dart';
import 'package:scm/widgets/product/product_details/product_detail_dialog_box_view.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderListPageViewModel extends GeneralisedBaseViewModel {
  late final OrderListPageViewArguments args;
  late DateTimeRange dateTimeRange;
  int indexForList = 0;
  final log = getLogger('OrderListPageViewModel');
  // late final TextEditingController toDateController;
  // late final TextEditingController fromDateController;
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
  OrderFiltersDurationType selectedOrderDuration =
      OrderFiltersDurationType.LAST_30_DAYS;

  late String selectedOrderStatus;

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
    dateTimeRange = DateTimeRange(
      end: DateTime.now(),
      start: DateTime.now().subtract(
        const Duration(
          days: 1,
        ),
      ),
    );
    // updateTextControllers();

    args = arguments;

    if (!args.hideOrdersList) {
      selectedOrderStatus = arguments.preDefinedOrderStatus;
      selectedOrder = arguments.selectedOrder ?? Order().empty();
      getOrderStatusList();
      getOrderList();
    } else {
      getOrdersDetails(orderId: arguments.orderId.toString());
    }
    log.wtf(selectedOrderStatus);
  }

  getOrderList() async {
    orderListApi = ApiStatus.LOADING;

    orderList = await _commonDashBoardApis.getOrdersList(
      pageSize: pageSize,
      pageNumber: pageNumber,
      status: selectedOrderStatus,
      selectedDuration: selectedOrderDuration,
      selectedDurationFromDate: DateTimeToStringConverter.yyyymmdd(
        date: dateTimeRange.start,
      ).convert(),
      selectedDurationToDate: DateTimeToStringConverter.yyyymmdd(
        date: dateTimeRange.end,
      ).convert(),
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

  void openOrderListFilters() async {
    indexForList = 1;

    notifyListeners();

    // DialogResponse? filtersDialogResponse;

    // filtersDialogResponse = await dialogService.showCustomDialog(
    //   variant: DialogType.ORDER_LIST_FILTERS,
    //   data: OrderFiltersDialogBoxViewArguments(
    //     title: orderFiltersDialogBoxTitle,
    //   ),
    // );

    // if (filtersDialogResponse != null && filtersDialogResponse.confirmed) {
    //   OrderFiltersDialogBoxViewOutArguments
    //       orderFiltersDialogBoxViewOutArguments = filtersDialogResponse.data;

    //   selectedOrderStatus =
    //       orderFiltersDialogBoxViewOutArguments.selectedOrderStatus;
    //   switch (orderFiltersDialogBoxViewOutArguments.orderFiltersDurationType) {
    //     case OrderFiltersDurationType.PAST_MONTHS:
    //       selectedOrderDurationMonths =
    //           orderFiltersDialogBoxViewOutArguments.selectedOrderDuration;
    //       break;
    //     case OrderFiltersDurationType.CUSTOM:
    //       selectedToDate = orderFiltersDialogBoxViewOutArguments.toDate;
    //       selectedFromDate = orderFiltersDialogBoxViewOutArguments.fromDate;

    //       break;
    //   }

    //   pageNumber = 0;
    //   getOrderList();
    // }
  }

  void updateDateRange(DateTimeRange? newDateTimeRange) {
    if (newDateTimeRange == null) {
      return;
    }

    dateTimeRange = newDateTimeRange;
    // updateTextControllers();
    notifyListeners();
  }

  // void updateTextControllers() {
  //   toDateController = TextEditingController(
  //     text: DateTimeToStringConverter.ddMMMMyy(
  //       date: dateTimeRange.end,
  //     ).convert(),
  //   );
  //   fromDateController = TextEditingController(
  //     text: DateTimeToStringConverter.ddMMMMyy(
  //       date: dateTimeRange.start,
  //     ).convert(),
  //   );
  // }
}
