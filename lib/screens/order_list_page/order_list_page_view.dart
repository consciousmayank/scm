import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/model_classes/address.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/screens/order_list_page/oder_item_containing_container_widget.dart';
import 'package:scm/screens/order_list_page/order_list_page_viewmodel.dart';
import 'package:scm/screens/order_list_page/order_process_buttons.dart';
import 'package:scm/screens/order_list_page/orderitem_row_widget.dart';
import 'package:scm/screens/order_list_page/processing_order_widget_view.dart';
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
                                model.getOrderList();
                              },
                              orderStatuses: model.orderStatusList,
                            ),
                      flex: 1,
                    ),
                    Expanded(
                      key: UniqueKey(),
                      child: model.orderDetailsApi == ApiStatus.LOADING
                          ? const LoadingWidgetWithText(
                              text: 'Fetching Orders. Please Wait...')
                          : model.orderDetails.status == 'PROCESSING'
                              ? const ProcessingOrderWidget()
                              : Card(
                                  shape: Dimens().getCardShape(),
                                  color: AppColors().white,
                                  elevation: Dimens().getDefaultElevation,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              labelOrderDetail,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                  Dimens().defaultBorder,
                                                ),
                                                bottomLeft: Radius.circular(
                                                  Dimens().defaultBorder,
                                                ),
                                              ),
                                              color: isSelectedOrderDeliveredOrCancelled(
                                                          model) ==
                                                      null
                                                  ? Colors.red
                                                  : isSelectedOrderDeliveredOrCancelled(
                                                          model)!
                                                      ? Colors.green
                                                      : Colors.grey,
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              model.selectedOrder.status
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    color: AppColors().white,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      hSizedBox(
                                        height: 8,
                                      ),
                                      Flexible(
                                        child: CustomScrollView(
                                          controller: ScrollController(
                                            keepScrollOffset: true,
                                          ),
                                          slivers: [
                                            SliverToBoxAdapter(
                                              child: OrderItemContainerWidget(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      labelOrderSummary,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                    OrderItemRowWidget
                                                        .customPadding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              bottom: 2,
                                                              left: 8,
                                                              right: 8),
                                                      label: 'Order Id',
                                                      value: model
                                                          .orderDetails.id
                                                          .toString(),
                                                    ),
                                                    OrderItemRowWidget
                                                        .customPadding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 8),
                                                      label: 'Total Amount',
                                                      value: model.orderDetails
                                                          .totalAmount
                                                          .toString(),
                                                    ),
                                                    OrderItemRowWidget
                                                        .customPadding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 8),
                                                      label: 'Total Items',
                                                      value: model.orderDetails
                                                          .totalItems
                                                          .toString(),
                                                    ),
                                                    OrderItemRowWidget
                                                        .customPadding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 8),
                                                      label: 'Order Placed On',
                                                      value: model.orderDetails
                                                          .createDateTime
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SliverToBoxAdapter(
                                              child: hSizedBox(
                                                height: 8,
                                              ),
                                            ),
                                            SliverToBoxAdapter(
                                              child: OrderItemContainerWidget(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            labelShippingAddress,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              getAddressString(
                                                                address: model
                                                                    .orderDetails
                                                                    .shippingAddress,
                                                              ),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            labelBillingAddress,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              getAddressString(
                                                                address: model
                                                                    .orderDetails
                                                                    .billingAddress,
                                                              ),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SliverToBoxAdapter(
                                              child: hSizedBox(
                                                height: 8,
                                              ),
                                            ),
                                            SliverToBoxAdapter(
                                              child: hSizedBox(
                                                height: 8,
                                              ),
                                            ),
                                            SliverToBoxAdapter(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  labelProductItems,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                ),
                                              ),
                                            ),
                                            SliverList(
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                (BuildContext context,
                                                    int index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 8,
                                                      bottom: 8,
                                                    ),
                                                    child:
                                                        OrderItemContainerWidget
                                                            .noPadding(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 16,
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      12.0,
                                                                  vertical: 10,
                                                                ),
                                                                child: Text(
                                                                  '${index + 1}',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2!
                                                                      .copyWith(
                                                                        color: AppColors()
                                                                            .white,
                                                                      ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  // shape: BoxShape.rectangle,
                                                                  borderRadius: const BorderRadius
                                                                          .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              8),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              8)),
                                                                  color: AppColors()
                                                                          .primaryColor[
                                                                      500],
                                                                ),
                                                              ),
                                                              AppInkwell(
                                                                onTap: () {
                                                                  model
                                                                      .openProductDetails(
                                                                    productId: model
                                                                            .orderDetails
                                                                            .orderItems!
                                                                            .elementAt(index)
                                                                            .itemId ??
                                                                        0,
                                                                    productTitle: model
                                                                            .orderDetails
                                                                            .orderItems!
                                                                            .elementAt(index)
                                                                            .itemTitle ??
                                                                        'NA',
                                                                  );
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          16.0),
                                                                  child: Text(
                                                                    'View Product',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2!
                                                                        .copyWith(
                                                                          color:
                                                                              Colors.blue,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          OrderItemRowWidget
                                                              .noValueWithLabelStyle(
                                                            label: model
                                                                .orderDetails
                                                                .orderItems!
                                                                .elementAt(
                                                                    index)
                                                                .itemTitle,
                                                            labelStyle:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6!
                                                                    .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                          ),
                                                          OrderItemRowWidget(
                                                            label: 'Quantity',
                                                            value: model.orderDetails
                                                                        .orderItems!
                                                                        .elementAt(
                                                                            index)
                                                                        .itemQuantity ==
                                                                    null
                                                                ? null
                                                                : model
                                                                    .orderDetails
                                                                    .orderItems!
                                                                    .elementAt(
                                                                        index)
                                                                    .itemQuantity!
                                                                    .toString(),
                                                          ),
                                                          OrderItemRowWidget(
                                                            label: 'Price',
                                                            value: model.orderDetails
                                                                        .orderItems!
                                                                        .elementAt(
                                                                            index)
                                                                        .itemPrice ==
                                                                    null
                                                                ? null
                                                                : model
                                                                    .orderDetails
                                                                    .orderItems!
                                                                    .elementAt(
                                                                        index)
                                                                    .itemPrice!
                                                                    .toString(),
                                                          ),
                                                          OrderItemRowWidget(
                                                            label:
                                                                'Total Amount',
                                                            value: model.orderDetails
                                                                        .orderItems!
                                                                        .elementAt(
                                                                            index)
                                                                        .itemTotalPrice ==
                                                                    null
                                                                ? null
                                                                : model
                                                                    .orderDetails
                                                                    .orderItems!
                                                                    .elementAt(
                                                                        index)
                                                                    .itemTotalPrice!
                                                                    .toString(),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                childCount: model.orderDetails
                                                            .orderItems ==
                                                        null
                                                    ? 0
                                                    : model.orderDetails
                                                        .orderItems!.length,
                                              ),
                                            ),
                                            SliverToBoxAdapter(
                                              child: model.isSupplier()
                                                  ? const OrderPorcessButtonsWidget()
                                                  : Container(),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                      flex: 2,
                    ),
                  ],
                ),
        ),
      ),
      viewModelBuilder: () => OrderListPageViewModel(),
    );
  }

  bool? isSelectedOrderDeliveredOrCancelled(OrderListPageViewModel model) {
    return model.orderDetails.status == 'DELIVERED'
        ? true
        : model.orderDetails.status == 'CANCELLED'
            ? null
            : false;
  }
}

class OrderListPageViewArguments {}
