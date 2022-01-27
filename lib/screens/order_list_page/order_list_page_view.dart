import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/model_classes/address.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/screens/order_list_page/helper_widgets/processing_order_widget_view.dart';
import 'package:scm/screens/order_list_page/order_list_page_viewmodel.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/order_filters/order_filters_view.dart';
import 'package:scm/widgets/order_list_widget.dart';
import 'package:stacked/stacked.dart';

class OrderListPageView extends StatelessWidget {
  const OrderListPageView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final OrderListPageViewArguments arguments;

  String getAddressString({required Address? address}) {
    if (address == null) {
      return '';
    }
    return '${address.addressLine1}, ${address.addressLine2}, \n${address.locality} ${address.nearby}, \n${address.city}, ${address.state}, ${address.country}, ${address.pincode}';
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderListPageViewModel>.reactive(
      onModelReady: (model) => model.init(arguments),
      builder: (context, model, child) => Scaffold(
        body: getValueForScreenType(
          context: context,
          mobile: Container(),
          tablet: Container(),
          desktop: model.isBusy
              ? const LoadingWidget()
              : Row(
                  children: [
                    if (!arguments.hideOrdersList)
                      Expanded(
                        child: model.orderListApi == ApiStatus.LOADING
                            ? const LoadingWidgetWithText(
                                text: 'Fetching Orders. Please Wait...')
                            : IndexedStack(
                                index: model.indexForList,
                                children: [
                                  OrderListWidget.orderPage(
                                    numberOfOrders: model.orderList.totalItems,
                                    selectedOrdersDurationType:
                                        model.selectedOrderDuration,
                                    key: UniqueKey(),
                                    selectedOrderId:
                                        arguments.selectedOrder != null
                                            ? arguments.selectedOrder!.id ?? -1
                                            : model.selectedOrder.id ?? -1,
                                    onOrderClick: ({
                                      required Order selectedOrder,
                                    }) {
                                      model.selectedOrder = selectedOrder;
                                      model.getOrdersDetails();
                                    },
                                    label: labelOrders,
                                    isScrollable: true,
                                    isSupplyRole: model.preferences
                                            .getSelectedUserRole() ==
                                        AuthenticatedUserRoles
                                            .ROLE_SUPPLY.getStatusString,
                                    orders: model.orderList.orders!,
                                    onNextPageClick: () {
                                      model.pageNumber++;
                                      model.getOrderList();
                                    },
                                    onPreviousPageClick: () {
                                      model.pageNumber--;
                                      model.getOrderList();
                                    },
                                    pageNumber: model.pageNumber,
                                    totalPages: model.orderList.totalPages! - 1,
                                    selectedOrderStatus:
                                        model.selectedOrderStatus,
                                    onOrderStatusClick: ({
                                      required String selectedOrderStatus,
                                    }) {
                                      model.openOrderListFilters();
                                    },
                                    // orderStatuses: model.getInAppOrderStatusList(),
                                    orderStatuses: model.orderStatusList,
                                    fromDateString:
                                        DateTimeToStringConverter.ddMMMyy(
                                      date: model.dateTimeRange.start,
                                    ).convert(),
                                    toDateString:
                                        DateTimeToStringConverter.ddMMMyy(
                                      date: model.dateTimeRange.end,
                                    ).convert(),
                                  ),
                                  const OrderFiltersView()
                                ],
                              ),
                        flex: 1,
                      ),
                    Expanded(
                      key: UniqueKey(),
                      child: model.orderDetailsApi == ApiStatus.LOADING
                          ? const LoadingWidgetWithText(
                              text: 'Fetching Orders. Please Wait...')
                          : model.orderDetails.status!.isEmpty
                              ? const Center(
                                  child: Text('No orders found'),
                                )
                              : const ProcessingOrderWidget(),
                      flex: 2,
                    ),
                  ],
                ),
        ),
      ),
      viewModelBuilder: () => OrderListPageViewModel(),
    );
  }
}

class OrderListPageViewArguments {
  OrderListPageViewArguments({
    this.preDefinedOrderStatus = 'All',
    this.selectedOrder,
  })  : hideOrdersList = false,
        orderId = null;

  OrderListPageViewArguments.notification({
    required this.orderId,
  })  : hideOrdersList = true,
        preDefinedOrderStatus = '',
        selectedOrder = null;

  final bool hideOrdersList;
  final int? orderId;
  final String preDefinedOrderStatus;
  final Order? selectedOrder;
}
