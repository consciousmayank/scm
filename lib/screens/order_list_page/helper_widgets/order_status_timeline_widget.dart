import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/enums/timeline_order_status_types.dart';
import 'package:scm/screens/order_list_page/order_list_page_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:stacked/stacked.dart';

const double circleRadius = 10;
// const double circleOutlineRadius = 5;

class OrderStatusTimeLineWidget
    extends ViewModelWidget<OrderListPageViewModel> {
  const OrderStatusTimeLineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, OrderListPageViewModel viewModel) {
    return SizedBox(
      height: 100,
      child: viewModel.orderDetails.status ==
              OrderStatusTypes.CANCELLED.apiToAppTitles
          ? const CancelledOrderTrackingWidget()
          : const NormalOrderTrackingWidget(),
    );
  }
}

class CancelledOrderTrackingWidget
    extends ViewModelWidget<OrderListPageViewModel> {
  const CancelledOrderTrackingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, OrderListPageViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
            top: 8,
            left: 32,
            right: 36,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //New Order
              CircleAvatar(
                backgroundColor: viewModel.getColor(
                  orderStatus: viewModel.orderDetails.status,
                  timeLineStatus: TimeLineOrderStatusTypes.PLACED,
                ),
                radius: circleRadius,
              ),
              Expanded(
                flex: 50,
                child: Container(
                  height: 2,
                  color: viewModel.getColor(
                    orderStatus: viewModel.orderDetails.status,
                    timeLineStatus: TimeLineOrderStatusTypes.PROCESSING,
                  ),
                ),
              ),

              //Cancelled
              const CircleAvatar(
                backgroundColor: Colors.red,
                radius: circleRadius,
              ),
            ],
          ),
        ),
        Flexible(
          child: Row(
            children: [
              //New Order
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        // timeLineOrderStatuses.elementAt(0),
                        TimeLineOrderStatusTypes.PLACED.getName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    StatusDateWidget(
                      textAlign: TextAlign.left,
                      status: OrderStatusTypes.CREATED.apiToAppTitles,
                    )
                  ],
                ),
                flex: 1,
              ),

              //Delivered
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      // timeLineOrderStatuses.elementAt(3),
                      TimeLineOrderStatusTypes.CANCELLED.getName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.red),
                    ),
                    StatusDateWidget(
                      status: OrderStatusTypes.CANCELLED.apiToAppTitles,
                    ),
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NormalOrderTrackingWidget
    extends ViewModelWidget<OrderListPageViewModel> {
  const NormalOrderTrackingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, OrderListPageViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
            top: 8,
            left: 32,
            right: 36,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //New Order
              CircleAvatar(
                backgroundColor: viewModel.getColor(
                  orderStatus: viewModel.orderDetails.status,
                  timeLineStatus: TimeLineOrderStatusTypes.PLACED,
                ),
                radius: circleRadius,
              ),
              Expanded(
                flex: 50,
                child: Container(
                  height: 2,
                  color: viewModel.getColor(
                    orderStatus: viewModel.orderDetails.status,
                    timeLineStatus: TimeLineOrderStatusTypes.PROCESSING,
                  ),
                ),
              ),

              //Processed
              CircleAvatar(
                backgroundColor: viewModel.getColor(
                  orderStatus: viewModel.orderDetails.status,
                  timeLineStatus: TimeLineOrderStatusTypes.PROCESSING,
                ),
                radius: circleRadius,
              ),

              Expanded(
                flex: 40,
                child: Container(
                  height: 2,
                  color: viewModel.getColor(
                    orderStatus: viewModel.orderDetails.status,
                    timeLineStatus: TimeLineOrderStatusTypes.SHIPPED,
                  ),
                ),
              ),

              //Shipped
              CircleAvatar(
                backgroundColor: viewModel.getColor(
                  orderStatus: viewModel.orderDetails.status,
                  timeLineStatus: TimeLineOrderStatusTypes.SHIPPED,
                ),
                radius: circleRadius,
              ),

              Expanded(
                flex: 50,
                child: Container(
                  height: 2,
                  color: viewModel.getColor(
                    orderStatus: viewModel.orderDetails.status,
                    timeLineStatus: TimeLineOrderStatusTypes.DELIVERED,
                  ),
                ),
              ),
              //Delivered
              CircleAvatar(
                backgroundColor: viewModel.getColor(
                  orderStatus: viewModel.orderDetails.status,
                  timeLineStatus: TimeLineOrderStatusTypes.DELIVERED,
                ),
                radius: circleRadius,
              ),
            ],
          ),
        ),
        Flexible(
          child: Row(
            children: [
              //New Order
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        // timeLineOrderStatuses.elementAt(0),
                        TimeLineOrderStatusTypes.PLACED.getName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    StatusDateWidget(
                      textAlign: TextAlign.left,
                      status: OrderStatusTypes.CREATED.apiToAppTitles,
                    )
                  ],
                ),
                flex: 1,
              ),

              //Processed
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 4,
                      ),
                      child: Text(
                        // timeLineOrderStatuses.elementAt(1),
                        TimeLineOrderStatusTypes.PROCESSING.getName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    StatusDateWidget(
                      status: OrderStatusTypes.PROCESSING.apiToAppTitles,
                    ),
                  ],
                ),
                flex: 1,
              ),

              //Shipped
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                      ),
                      child: Text(
                        // timeLineOrderStatuses.elementAt(2),
                        TimeLineOrderStatusTypes.SHIPPED.getName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    StatusDateWidget(
                      status: OrderStatusTypes.INTRANSIT.apiToAppTitles,
                    )
                  ],
                ),
                flex: 1,
              ),

              //Delivered
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      // timeLineOrderStatuses.elementAt(3),
                      TimeLineOrderStatusTypes.DELIVERED.getName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    StatusDateWidget(
                      status: OrderStatusTypes.DELIVERED.apiToAppTitles,
                    ),
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StatusDateWidget extends ViewModelWidget<OrderListPageViewModel> {
  const StatusDateWidget({
    Key? key,
    this.textAlign = TextAlign.center,
    required this.status,
  }) : super(key: key);

  final String? status;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context, OrderListPageViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4,
      ),
      child: Text(
        viewModel.getDateForStatus(
          status: status,
        ),
        style: Theme.of(context).textTheme.caption?.copyWith(
              fontSize: 12,
            ),
        textAlign: textAlign,
      ),
    );
  }
}
