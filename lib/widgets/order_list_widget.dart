import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/screens/order_list_page/helper_widgets/order_status_widget.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_footer_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/list_footer.dart';

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
  }) : super(key: key);

  final Function({required Order selectedOrder})? onOrderClick;
  final Function({required String selectedOrderStatus})? onOrderStatusClick;
  final bool isSupplyRole, isScrollable;
  final String label;
  final Function? onPreviousPageClick, onNextPageClick;
  final List<String> orderStatuses;
  final List<Order> orders;
  final int pageNumber, totalPages, selectedOrderId;
  final String selectedOrderStatus;
  final bool showCompactView;

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
    return [
      Flexible(
        child: orders.isNotEmpty
            ? ListView.separated(
                controller: ScrollController(
                  keepScrollOffset: true,
                ),
                key: const PageStorageKey('Order_list'),
                physics: isScrollable
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AppInkwell(
                    onTap: showCompactView
                        ? () {
                            onOrderClick!(
                              selectedOrder: orders.elementAt(
                                index,
                              ),
                            );
                          }
                        : null,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        OrderListTableWidget.values(
                          titles: [
                            Value.withText(
                                value: '${orders.elementAt(index).id}'),
                            !isSupplyRole
                                ? Value.withText(
                                    value:
                                        '${orders.elementAt(index).supplyBusinessName}',
                                  )
                                : Value.withText(
                                    value:
                                        '${orders.elementAt(index).demandBusinessName}',
                                  ),
                            // Value.withText(
                            //   value: (DateTimeToStringConverter.ddMMMMyy(
                            //           date: StringToDateTimeConverter.ddmmyy(
                            //                   date: orders.elementAt(index).createDateTime!)
                            //               .convert())
                            //       .convert()),
                            // ),
                            Value.withText(
                              value: '${orders.elementAt(index).totalItems}',
                            ),
                            // Value.withText(
                            //   value: '${orders.elementAt(index).totalAmount}',
                            // ),
                            // Value.withOutlinedContainer(
                            //   value: '${orders.elementAt(index).status}',
                            // ),
                          ],
                          isSelected: selectedOrderId > 0 &&
                              selectedOrderId == orders.elementAt(index).id,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                          ),
                          child: OrderStatusWidget.compact(
                            status: getApiToAppOrderStatus(
                              status: orders.elementAt(index).status,
                            ),
                            statusColor: getBorderColor(
                              status: orders.elementAt(index).status,
                            ),
                            statusStyle:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: AppColors().white,
                                    ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const DottedDivider(),
                itemCount: orders.length,
              )
            : const Center(
                child: Text('No orders found'),
              ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
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
                      left: 8,
                      right: 8,
                      bottom: 8,
                    )
                  : const EdgeInsets.all(
                      8.0,
                    ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  selectedOrderStatus.isNotEmpty
                      ? SizedBox(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                                color: AppColors().white,
                                borderRadius: BorderRadius.circular(6)),
                            child: DropdownButton<String>(
                              hint: const Text('Select'),
                              value: selectedOrderStatus,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              iconSize: 30,
                              underline: Container(),
                              onChanged: (String? value) {
                                onOrderStatusClick!(
                                        selectedOrderStatus: value ?? '')
                                    .call();
                              },
                              items:
                                  orderStatuses.map<DropdownMenuItem<String>>(
                                (String location) {
                                  return DropdownMenuItem<String>(
                                    child: Text(
                                      location,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: location == 'ALL'
                                                ? AppColors().black
                                                : getBorderColor(
                                                    status: location,
                                                  ),
                                          ),
                                    ),
                                    value: location,
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            hSizedBox(
              height: 8,
            ),
            if (showCompactView)
              OrderListTableWidget.header(
                titles: [
                  Value.withText(value: 'ORDER ID'),
                  Value.withText(value: 'ORDERED BY'),
                  // Value.withText(value: 'PLACED ON'),
                  Value.withText(value: 'TOTAL ITEMS'),
                  // Value.withText(value: 'TOTAL AMOUNT'),
                  // Value.withText(value: 'STATUS'),
                ],
              ),
            ...(showCompactView
                ? _buildCompactView(context)
                : _buildFullView(context)),
            if (showCompactView)
              ListFooter.previousNextCompact(
                pageNumber: pageNumber,
                totalPages: totalPages,
                onPreviousPageClick: onPreviousPageClick,
                onNextPageClick: onNextPageClick,
              )
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
  }) : super(key: key);

  const OrderListTableWidget.values({
    Key? key,
    this.isHeader = false,
    required this.titles,
    required this.isSelected,
  }) : super(key: key);

  final bool isHeader, isSelected;
  final List<Value> titles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Dimens().suppliersListItemImageCiircularRaduis,
        ),
        color:
            isHeader ? Theme.of(context).colorScheme.background : Colors.white,
      ),
      child: Row(
        children: titles
            .map((title) => Expanded(
                  flex: titles.indexOf(title) == 0 ? 1 : 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: title.widgetType == WidgetType.OUTLINED_CONTAINER
                        ? Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: getBorderColor(status: title.value),
                                  width: 1),
                              borderRadius: BorderRadius.circular(
                                Dimens().defaultBorder,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                title.value,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: getBorderColor(
                                        status: title.value,
                                      ),
                                    ),
                              ),
                            ),
                          )
                        : Text(
                            title.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign:
                                titles.indexOf(title) == titles.length - 1
                                    ? TextAlign.center
                                    : TextAlign.left,
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  decoration: isSelected
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                          ),
                  ),
                ))
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
