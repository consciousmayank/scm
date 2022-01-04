import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/model_classes/address.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/screens/order_list_page/helper_widgets/oder_item_containing_container_widget.dart';
import 'package:scm/screens/order_list_page/helper_widgets/order_process_buttons.dart';
import 'package:scm/screens/order_list_page/helper_widgets/order_status_widget.dart';
import 'package:scm/screens/order_list_page/helper_widgets/orderitem_row_widget.dart';
import 'package:scm/screens/order_list_page/helper_widgets/processing_order_widget_view.dart';
import 'package:scm/screens/order_list_page/order_list_page_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/loading_widget.dart';
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
                    Expanded(
                      child: model.orderListApi == ApiStatus.LOADING
                          ? const LoadingWidgetWithText(
                              text: 'Fetching Orders. Please Wait...')
                          : OrderListWidget.orderPage(
                              key: UniqueKey(),
                              selectedOrderId: model.selectedOrder.id ?? -1,
                              onOrderClick: ({
                                required Order selectedOrder,
                              }) {
                                model.selectedOrder = selectedOrder;
                                model.getOrdersDetails();
                              },
                              label: labelOrders,
                              isScrollable: true,
                              isSupplyRole:
                                  model.preferences.getSelectedUserRole() ==
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
                              selectedOrderStatus: model.selectedOrderStatus,
                              onOrderStatusClick: (
                                  {required String selectedOrderStatus}) {
                                model.selectedOrderStatus = selectedOrderStatus;
                                model.notifyListeners();
                                model.pageNumber = 0;
                                model.getOrderList();
                              },
                              // orderStatuses: model.getInAppOrderStatusList(),
                              orderStatuses: model.orderStatusList,
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

class OrderListPageViewArguments {}
