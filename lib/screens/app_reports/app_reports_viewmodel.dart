import 'package:flutter/material.dart';
import 'package:scm/app/app.router.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/common_dashboard_order_info.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/screens/app_reports/app_reports_view.dart';
import 'package:scm/screens/reports/orders_report/order_report_view.dart';
import 'package:scm/services/app_api_service_classes/common_dashboard_apis.dart';
import 'package:scm/utils/strings.dart';

class AppReportsViewModel extends GeneralisedBaseViewModel {
  final List<String> orderIcons = [
    newOrdersIcon,
    inProcessOrdersIcon,
    shippedOrdersIcon,
    deliveredOrdersIcon,
    cancelledOrdersIcon,
  ];

  CommonDashboardOrderInfo orderInfo = CommonDashboardOrderInfo().empty();
  ApiStatus orderInfoApi = ApiStatus.LOADING;
  List<ReportTiles> orderStatuses = [];

  final CommonDashBoardApis _commonDashBoardApis =
      locator<CommonDashBoardApis>();

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

  init({required AppReportsViewArguments args}) {
    getOrderInfo();
  }

  getOrderInfo() async {
    orderInfo = await _commonDashBoardApis.getOrderInfo();
    orderInfoApi = ApiStatus.FETCHED;

    orderStatuses.add(
      ReportTiles(
        title: 'New Order',
        count: orderInfo.created ?? 0,
        icon: newOrdersIcon,
        orderStatus: OrderStatusTypes.CREATED,
      ),
    );
    orderStatuses.add(
      ReportTiles(
        title: 'IN PROCESS ORDER REPORT',
        count: orderInfo.processing ?? 0,
        icon: inProcessOrdersIcon,
        orderStatus: OrderStatusTypes.PROCESSING,
      ),
    );
    orderStatuses.add(
      ReportTiles(
        title: 'SHIPPED ORDER REPORT',
        count: orderInfo.intransit ?? 0,
        icon: shippedOrdersIcon,
        orderStatus: OrderStatusTypes.INTRANSIT,
      ),
    );
    orderStatuses.add(
      ReportTiles(
        title: 'DELIVERED ORDER REPORT',
        count: orderInfo.delivered ?? 0,
        icon: deliveredOrdersIcon,
        orderStatus: OrderStatusTypes.DELIVERED,
      ),
    );
    orderStatuses.add(
      ReportTiles(
        title: 'CANCELLED ORDER REPORT',
        count: orderInfo.cancelled ?? 0,
        icon: cancelledOrdersIcon,
        orderStatus: OrderStatusTypes.CANCELLED,
      ),
    );

    notifyListeners();
  }
}

class ReportTiles {
  ReportTiles({
    required this.title,
    required this.count,
    required this.icon,
    required this.orderStatus,
  });

  final int count;
  final String icon;
  final OrderStatusTypes orderStatus;
  final String title;
}
