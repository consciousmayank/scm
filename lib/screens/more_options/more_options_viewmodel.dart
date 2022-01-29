import 'package:flutter/material.dart';
import 'package:scm/app/app.router.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/screens/more_options/more_options_view.dart';
import 'package:scm/screens/reports/orders_report/order_report_view.dart';
import 'package:scm/utils/strings.dart';

class MoreOptionsViewModel extends GeneralisedBaseViewModel {
  final Map<String, OrderStatusTypes> orderStatuses = {
    "New Order": OrderStatusTypes.CREATED,
    "Shipped": OrderStatusTypes.INTRANSIT,
    "Delivered": OrderStatusTypes.DELIVERED,
  };

  final List<String> orderIcons = [
    newOrdersIcon,
    shippedOrdersIcon,
    deliveredOrdersIcon,
  ];

  takeToOrderReports({
    required OrderStatusTypes orderStatus,
  }) {
    navigationService.navigateTo(
      orderReportsScreenPageRoute,
      arguments: OrderReportsViewArgs(
        orderStatus: orderStatus,
      ),
    );
  }

  init({required MoreOptionsViewArguments args}) {}
}
