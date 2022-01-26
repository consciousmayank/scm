import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scm/app/app.logger.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/order_filter_duration_type.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/screens/order_list_page/helper_widgets/order_status_widget.dart';
import 'package:scm/screens/order_list_page/helper_widgets/processing_order_widget_view.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/list_footer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class OrderListWidget extends StatelessWidget {
  const OrderListWidget.dashboard({
    Key? key,
    required this.orders,
    required this.isScrollable,
    required this.isSupplyRole,
    this.pageNumber = 0,
    this.totalPages = 0,
    this.onNextPageClick,
    this.onPreviousPageClick,
    this.onOrderClick,
    this.selectedOrderId = -1,
    required this.label,
    this.onOrderStatusClick,
    this.selectedOrderStatus = '',
  })  : orderStatuses = const [],
        showCompactView = false,
        selectedOrdersDurationType = null,
        fromDateString = null,
        toDateString = null,
        numberOfOrders = null,
        super(key: key);

  const OrderListWidget.orderPage({
    Key? key,
    this.showCompactView = true,
    required this.orderStatuses,
    required this.pageNumber,
    required this.totalPages,
    required this.orders,
    required this.isScrollable,
    required this.isSupplyRole,
    required this.onNextPageClick,
    required this.onPreviousPageClick,
    required this.onOrderClick,
    required this.label,
    required this.selectedOrderId,
    required this.onOrderStatusClick,
    required this.selectedOrderStatus,
    required this.selectedOrdersDurationType,
    required this.fromDateString,
    required this.toDateString,
    required this.numberOfOrders,
  }) : super(key: key);

  final Function({required Order selectedOrder})? onOrderClick;
  final Function({required String selectedOrderStatus})? onOrderStatusClick;
  final bool isSupplyRole, isScrollable;
  final String label;
  final int? numberOfOrders;
  final Function? onPreviousPageClick, onNextPageClick;
  final List<String> orderStatuses;
  final List<Order> orders;
  final int pageNumber, totalPages, selectedOrderId;
  final String selectedOrderStatus;
  final OrderFiltersDurationType? selectedOrdersDurationType;
  final bool showCompactView;
  final String? fromDateString, toDateString;

  _buildFullView(BuildContext context) {
    return [
      Flexible(
        child: orders.isNotEmpty
            ? ListView.separated(
                controller: ScrollController(
                  keepScrollOffset: true,
                ),
                physics: isScrollable
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return OrderListTableWidget.header(
                      titles: [
                        Value.withText(value: 'ORDER ID'),
                        Value.withText(value: 'ORDERED BY'),
                        Value.withText(value: 'PLACED ON'),
                        Value.withText(value: 'TOTAL ITEMS'),
                        Value.withText(value: 'TOTAL AMOUNT'),
                        Value.withText(value: 'STATUS'),
                      ],
                    );
                  }

                  index -= 1;

                  return OrderListTableWidget.values(
                    titles: [
                      Value.withText(value: '${orders.elementAt(index).id}'),
                      !isSupplyRole
                          ? Value.withText(
                              value:
                                  '${orders.elementAt(index).supplyBusinessName}',
                            )
                          : Value.withText(
                              value:
                                  '${orders.elementAt(index).demandBusinessName}',
                            ),
                      Value.withText(
                        value: (DateTimeToStringConverter.ddMMMMyy(
                                date: StringToDateTimeConverter.ddmmyy(
                                        date: orders
                                            .elementAt(index)
                                            .createDateTime!)
                                    .convert())
                            .convert()),
                      ),
                      Value.withText(
                        value: '${orders.elementAt(index).totalItems}',
                      ),
                      Value.withText(
                        value: '${orders.elementAt(index).totalAmount}',
                      ),
                      Value.withOutlinedContainer(
                        value: '${orders.elementAt(index).status}',
                      ),
                    ],
                    isSelected: selectedOrderId > 0 &&
                        selectedOrderId == orders.elementAt(index).id,
                    onOrderClick: () {
                      onOrderClick!(
                        selectedOrder: orders.elementAt(
                          index,
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    index == 0 ? Container() : const DottedDivider(),
                itemCount: orders.length,
              )
            : const Center(
                child: Text('No orders found'),
              ),
      )
    ];
  }

  _buildCompactView(BuildContext context) {
    final ItemPositionsListener orderListItemPositionsListener =
        ItemPositionsListener.create();

    final ItemScrollController orderListItemScrollController =
        ItemScrollController();

    return [
      Flexible(
        child: orders.isNotEmpty
            ? ScrollablePositionedList.separated(
                itemScrollController: orderListItemScrollController,
                itemPositionsListener: orderListItemPositionsListener,
                key: const PageStorageKey('Order_list'),
                physics: isScrollable
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index >= orders.length) {
                    return ListFooter.previousNext(
                      pageNumber: pageNumber,
                      totalPages: totalPages,
                      onPreviousPageClick: () {
                        onPreviousPageClick?.call();
                        orderListItemScrollController.jumpTo(
                          index: 0,
                        );
                      },
                      onNextPageClick: () {
                        onNextPageClick?.call();
                        orderListItemScrollController.jumpTo(
                          index: 0,
                        );
                      },
                    );
                  }

                  return AppInkwell(
                    onTap: () {
                      onOrderClick!(
                        selectedOrder: orders.elementAt(
                          index,
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          color: (selectedOrderId > 0 &&
                                  selectedOrderId == orders.elementAt(index).id)
                              ? Theme.of(context).primaryColorLight
                              : AppColors().white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: OrderItemViewWidget(
                                      label: 'ORDER ID',
                                      value: '${orders.elementAt(index).id}',
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: !isSupplyRole
                                        ? OrderItemViewWidget(
                                            label: 'DEMAND BY',
                                            value:
                                                '${orders.elementAt(index).supplyBusinessName}',
                                          )
                                        : OrderItemViewWidget(
                                            label: 'SUPPLY BY',
                                            value:
                                                '${orders.elementAt(index).demandBusinessName}',
                                          ),
                                    flex: 3,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 4.0,
                          ),
                          child:

                              // OrderStatusWidget.compact(
                              //   status: getApiToAppOrderStatus(
                              //     status: orders.elementAt(index).status,
                              //   ),
                              //   statusColor: getBorderColor(
                              //     status: orders.elementAt(index).status,
                              //   ),
                              //   statusStyle:
                              //       Theme.of(context).textTheme.overline!.copyWith(
                              //             color: AppColors().white,
                              //           ),
                              // )

                              Container(
                            margin: const EdgeInsets.only(
                              top: 8,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  60,
                                ),
                              ),
                              color: getBorderColor(
                                status: orders.elementAt(index).status,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              getApiToAppOrderStatus(
                                status: orders.elementAt(index).status,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .overline!
                                  .copyWith(
                                    color: AppColors().black,
                                  ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                  ),
                  color: Theme.of(context).primaryColorLight,
                  height: 0.5,
                  width: double.infinity,
                ),
                itemCount: orders.length + 1,
              )
            : const Center(
                child: Text('No orders found'),
              ),
      )
    ];
  }

  String getOrderStatus({required String status}) {
    // String orderNumber = '${numberOfOrders == 0 ? 'No' : numberOfOrders}';

    if (status == OrderStatusTypes.CANCELLED.apiToAppTitles) {
      // return '$orderNumber ${numberOfOrders == 1 || numberOfOrders == 0 ? 'Cancelled Order' : 'Cancelled Orders'}';
      return 'Cancelled Orders';
    } else if (status == OrderStatusTypes.NEW_ORDER.apiToAppTitles) {
      // return '$orderNumber ${numberOfOrders == 1 || numberOfOrders == 0 ? 'New Order' : 'New Orders'}';
      return 'New Orders';
    } else if (status == OrderStatusTypes.UNDER_PROCESS.apiToAppTitles) {
      // return '$orderNumber ${numberOfOrders == 1 || numberOfOrders == 0 ? 'Order Under Process' : 'Orders Under Process'}';
      return 'Orders Under Process';
    } else if (status == OrderStatusTypes.SHIPPED.apiToAppTitles) {
      // return '$orderNumber ${numberOfOrders == 1 || numberOfOrders == 0 ? 'Shipped Order' : 'Shipped Orders'}';
      return 'Shipped Orders';
    } else if (status == OrderStatusTypes.DELIVERED.apiToAppTitles) {
      // return '$orderNumber ${numberOfOrders == 1 || numberOfOrders == 0 ? 'Delivered Order' : 'Delivered Orders'}';
      return 'Delivered Orders';
    } else {
      // return 'All Orders ($numberOfOrders)';
      return 'All Orders';
    }
  }

  @override
  Widget build(BuildContext context) {
    final log = getLogger('OrderListPageViewModel');
    log.wtf(selectedOrderStatus);
    return Card(
      shape: Dimens().getCardShape(),
      elevation: Dimens().getDefaultElevation,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: showCompactView
                  ? const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    )
                  : const EdgeInsets.all(
                      8.0,
                    ),
              child: showCompactView
                  ? Container(
                      color: AppColors().white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getOrderStatus(
                                        status: selectedOrderStatus,
                                      ).toUpperCase(),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      'Record Count: $numberOfOrders',
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: AppInkwell(
                                  onTap: () {
                                    onOrderStatusClick!(
                                      selectedOrderStatus: '',
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Filter By'.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                            textAlign: TextAlign.end,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                      // SizedBox(
                                      //   child: AppButton.appbar(
                                      //     onTap: () {

                                      //     },
                                      //     title: 'Filter By',
                                      //     leading: Icon(Icons.filter),
                                      //   ),
                                      //   height: Dimens().buttonHeight,
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 16,
                                        ),
                                        child: Text(
                                          selectedOrdersDurationType ==
                                                  OrderFiltersDurationType
                                                      .CUSTOM
                                              ? orderListSubtitleLabelWithDates(
                                                  fromDate:
                                                      fromDateString ?? '',
                                                  toDate: toDateString ?? '',
                                                )
                                              : orderListSubtitleLabel(
                                                  duration:
                                                      selectedOrdersDurationType!
                                                          .getNames,
                                                ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 8,
                            ),
                            color: Theme.of(context).colorScheme.primary,
                            height: 1,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    )
                  : Text(
                      label,
                      style: Theme.of(context).textTheme.headline6,
                    ),
            ),
            hSizedBox(
              height: 8,
            ),
            ...(showCompactView
                ? _buildCompactView(context)
                : _buildFullView(context)),
            // if (showCompactView)
            //   ListFooter.previousNext(
            //     pageNumber: pageNumber,
            //     totalPages: totalPages,
            //     onPreviousPageClick: onPreviousPageClick,
            //     onNextPageClick: onNextPageClick,
            //   )
          ],
        ),
      ),
    );
  }
}

class OrderListTableWidget extends StatelessWidget {
  const OrderListTableWidget.header({
    Key? key,
    this.isHeader = true,
    required this.titles,
    this.isSelected = false,
  })  : onOrderClick = null,
        super(key: key);

  const OrderListTableWidget.values({
    Key? key,
    this.isHeader = false,
    required this.titles,
    required this.isSelected,
    required this.onOrderClick,
  }) : super(key: key);

  final bool isHeader, isSelected;
  final Function? onOrderClick;
  final List<Value> titles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        8,
      ),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(
        //   Dimens().suppliersListItemImageCircularRaduis,
        // ),
        color:
            isHeader ? Theme.of(context).primaryColorDark : Colors.transparent,
      ),
      child: Row(
        children: titles
            .map(
              (title) => Expanded(
                flex: titles.indexOf(title) == 0 ? 1 : 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: title.widgetType == WidgetType.OUTLINED_CONTAINER
                      ? AppInkwell.withBorder(
                          onTap: onOrderClick != null
                              ? () => onOrderClick!()
                              : null,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: getBorderColor(status: title.value),
                              border: Border.all(
                                  color: getBorderColor(status: title.value),
                                  width: 1),
                              borderRadius: BorderRadius.circular(
                                Dimens().defaultBorder,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                getApiToAppOrderStatus(
                                  status: title.value,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      color: isHeader
                                          ? AppColors().primaryHeaderTextColor
                                          : AppColors().black,
                                    ),
                              ),
                            ),
                          ),
                        )
                      : Text(
                          title.value,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: titles.indexOf(title) == titles.length - 1
                              ? TextAlign.center
                              : TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: isHeader
                                        ? AppColors().primaryHeaderTextColor
                                        : AppColors().black,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    decoration: isSelected
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                  ),
                        ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class Value {
  Value.withOutlinedContainer({
    this.widgetType = WidgetType.OUTLINED_CONTAINER,
    required this.value,
  });

  Value.withText({
    this.widgetType = WidgetType.TEXT,
    required this.value,
  });

  final String value;
  final WidgetType widgetType;
}

enum WidgetType {
  TEXT,
  OUTLINED_CONTAINER,
}

class OrderItemViewWidget extends StatelessWidget {
  const OrderItemViewWidget({
    Key? key,
    required this.label,
    required this.value,
  })  : isCustomChild = false,
        customChild = null,
        super(key: key);

  const OrderItemViewWidget.customChild({
    Key? key,
    required this.customChild,
  })  : isCustomChild = true,
        label = '',
        value = '',
        super(key: key);

  final Widget? customChild;
  final bool isCustomChild;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 16,
        bottom: 8,
      ),
      child: isCustomChild
          ? customChild
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
    );
  }
}
