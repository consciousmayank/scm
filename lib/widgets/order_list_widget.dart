import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_footer_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/list_footer.dart';

class OrderListWidget extends StatelessWidget {
  const OrderListWidget.dashboard({
    Key? key,
    this.showCompactView = false,
    required this.orders,
    required this.isScrollable,
    required this.isSupplyRole,
    this.pageNumber = 0,
    this.totalPages = 0,
    this.onNextPageClick,
    this.onPreviousPageClick,
    this.onOrderClick,
    required this.label,
  }) : super(key: key);

  const OrderListWidget.orderPage({
    Key? key,
    this.showCompactView = true,
    required this.pageNumber,
    required this.totalPages,
    required this.orders,
    required this.isScrollable,
    required this.isSupplyRole,
    required this.onNextPageClick,
    required this.onPreviousPageClick,
    required this.onOrderClick,
    required this.label,
  }) : super(key: key);

  final Function({required Order selectedOrder})? onOrderClick;
  final bool isSupplyRole, isScrollable;
  final String label;
  final Function? onPreviousPageClick, onNextPageClick;
  final List<Order> orders;
  final bool showCompactView;
  final int pageNumber, totalPages;

  _buildFullView(BuildContext context) {
    return [
      Flexible(
        child: ListView.separated(
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

            return OrderListTableWidget.values(titles: [
              Value.withText(value: '${orders.elementAt(index).id}'),
              !isSupplyRole
                  ? Value.withText(
                      value: '${orders.elementAt(index).supplyBusinessName}',
                    )
                  : Value.withText(
                      value: '${orders.elementAt(index).demandBusinessName}',
                    ),
              Value.withText(
                value: (DateTimeToStringConverter.ddMMMMyy(
                        date: StringToDateTimeConverter.ddmmyy(
                                date: orders.elementAt(index).createDateTime!)
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
            ]);
          },
          separatorBuilder: (context, index) =>
              index == 0 ? Container() : const DottedDivider(),
          itemCount: orders.length,
        ),
      )
    ];
  }

  _buildCompactView(BuildContext context) {
    return [
      Flexible(
        child: ListView.separated(
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
              child: OrderListTableWidget.values(titles: [
                Value.withText(value: '${orders.elementAt(index).id}'),
                // !isSupplyRole
                //     ? Value.withText(
                //         value: '${orders.elementAt(index).supplyBusinessName}',
                //       )
                //     : Value.withText(
                //         value: '${orders.elementAt(index).demandBusinessName}',
                //       ),
                Value.withText(
                  value: (DateTimeToStringConverter.ddMMMMyy(
                          date: StringToDateTimeConverter.ddmmyy(
                                  date: orders.elementAt(index).createDateTime!)
                              .convert())
                      .convert()),
                ),
                // Value.withText(
                //   value: '${orders.elementAt(index).totalItems}',
                // ),
                Value.withText(
                  value: '${orders.elementAt(index).totalAmount}',
                ),
                // Value.withOutlinedContainer(
                //   value: '${orders.elementAt(index).status}',
                // ),
              ]),
            );
          },
          separatorBuilder: (context, index) => const DottedDivider(),
          itemCount: orders.length,
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
              child: Text(
                label,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            hSizedBox(
              height: 8,
            ),
            if (showCompactView)
              OrderListTableWidget.header(
                titles: [
                  Value.withText(value: 'ORDER ID'),
                  // Value.withText(value: 'ORDERED BY'),
                  Value.withText(value: 'PLACED ON'),
                  // Value.withText(value: 'TOTAL ITEMS'),
                  Value.withText(value: 'TOTAL AMOUNT'),
                  // Value.withText(value: 'STATUS'),
                ],
              ),
            ...(showCompactView
                ? _buildCompactView(context)
                : _buildFullView(context)),
            if (showCompactView)
              ListFooter.previousNext(
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
  }) : super(key: key);

  const OrderListTableWidget.values({
    Key? key,
    this.isHeader = false,
    required this.titles,
  }) : super(key: key);

  final bool isHeader;
  final List<Value> titles;

  getBorderColor({required String? status}) {
    if (status == null) {
      return Colors.transparent;
    } else if (status == "PROCESSING") {
      return AppColors().processingOrderBg;
    } else if (status == "CREATED") {
      return AppColors().placedOrderBg;
    } else if (status == "CANCELLED") {
      return AppColors().cancelledOrderBg;
    } else if (status == "DELIVERED") {
      return AppColors().deliveredOrderBg;
    } else if (status == "INTRANSIT") {
      return AppColors().shippedOrderBg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        8,
      ),
      color: isHeader ? AppColors().dashboardTableHeaderBg : Colors.white,
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
