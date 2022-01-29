import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/common_dashboard_order_info.dart';
import 'package:scm/model_classes/common_dashboard_ordered_brands.dart';
import 'package:scm/model_classes/common_dashboard_ordered_types.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/services/app_api_service_classes/common_dashboard_apis.dart';
import 'package:scm/services/app_api_service_classes/reports_apis.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/widgets/common_dashboard/dashboard_view.dart';

class CommonDashboardViewModel extends GeneralisedBaseViewModel {
  int trendingBrandsIndex = 0;
  late final CommonDashboardViewArguments arguments;
  late final Color barChartsBarColor;
  //for order reports
  OrdersReportResponse? consolidatedOrdersReportResponse;

  late DateTimeRange dateTimeRange;
  ApiStatus getConsolidatedOrderReportsApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupByBrandApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupBySubTypeApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupByTypeApiStatus = ApiStatus.LOADING;
  CommonDashboardOrderInfo orderInfo = CommonDashboardOrderInfo().empty();
  ApiStatus orderInfoApi = ApiStatus.LOADING,
      orderedBrandsApi = ApiStatus.LOADING,
      orderedTypesApi = ApiStatus.LOADING,
      orderListApi = ApiStatus.LOADING;

  OrderListResponse orderList = OrderListResponse().empty();
  List<CommonDashboardOrderedBrands> orderedBrands = [];
  List<charts.Series<CommonDashboardOrderedBrands, String>>
      orderedBrandsBarData = [];

  List<CommonDashboardOrderedTypes> orderedTypes = [];
  List<charts.Series<CommonDashboardOrderedTypes, String>> orderedTypesBarData =
      [];

  OrdersReportResponse? ordersReportGroupByBrandResponse;
  OrdersReportResponse? ordersReportGroupBySubTypeResponse;
  OrdersReportResponse? ordersReportGroupByTypeResponse;
  int pageNumber = 0;
  int pageSize = 5;
  late String selectedOrderStatus;

  final CommonDashBoardApis _commonDashBoardApis =
      locator<CommonDashBoardApis>();

  final ReportsApi _reportsApi = locator<ReportsApi>();

  init({
    required CommonDashboardViewArguments args,
    required Color barColor,
  }) {
    arguments = args;
    barChartsBarColor = barColor;
    getOrderInfo();
    getOrderedBrands();
    getOrderedTypes();
    getOrdereList();

    //for order reports

    if (isSupplier()) {
      DateTime currentDate = DateTime.now();

      if (currentDate.day == 1) {
        //today is first of the month. so we need to get last month's first day as start date and last month's last day as end date
        dateTimeRange = DateTimeRange(
          start: DateTime(currentDate.year, currentDate.month - 1, 1),
          end: DateTime(currentDate.year, currentDate.month, 0),
        );
      } else {
        //today is not first of the month. so we need to get this month's first day as start date and today's date as end date
        dateTimeRange = DateTimeRange(
          start: DateTime(currentDate.year, currentDate.month, 1),
          end: DateTime(currentDate.year, currentDate.month, currentDate.day),
        );
      }

      selectedOrderStatus = OrderStatusTypes.DELIVERED.apiToAppTitles;
      getOrderReports();
    }
  }

  getOrderInfo() async {
    orderInfo = await _commonDashBoardApis.getOrderInfo();
    orderInfoApi = ApiStatus.FETCHED;
    notifyListeners();
  }

  getOrderedBrands() async {
    orderedBrands = await _commonDashBoardApis.getOrderedBrands(
      pageSize: pageSize,
    );

    orderedBrandsBarData = [
      charts.Series(
        id: 'Ordered Brands',
        data: orderedBrands,
        insideLabelStyleAccessorFn: (CommonDashboardOrderedBrands series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (CommonDashboardOrderedBrands series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (CommonDashboardOrderedBrands series, _) => series.brand!,
        measureFn: (CommonDashboardOrderedBrands series, _) => series.count,
        colorFn: (CommonDashboardOrderedBrands series, _) =>
            charts.ColorUtil.fromDartColor(barChartsBarColor),
        labelAccessorFn: (CommonDashboardOrderedBrands series, _) =>
            series.count.toString(),
      ),
    ];
    orderedBrandsApi = ApiStatus.FETCHED;
    notifyListeners();
  }

  getOrderedTypes() async {
    orderedTypes = await _commonDashBoardApis.getOrderedTypes(
      pageSize: pageSize,
    );
    orderedTypesBarData = [
      charts.Series(
        id: 'Ordered Brands',
        data: orderedTypes,
        insideLabelStyleAccessorFn: (CommonDashboardOrderedTypes series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (CommonDashboardOrderedTypes series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (CommonDashboardOrderedTypes series, _) => series.type!,
        measureFn: (CommonDashboardOrderedTypes series, _) => series.count,
        colorFn: (CommonDashboardOrderedTypes series, _) =>
            charts.ColorUtil.fromDartColor(barChartsBarColor),
        labelAccessorFn: (CommonDashboardOrderedTypes series, _) =>
            series.count.toString(),
      ),
    ];
    orderedTypesApi = ApiStatus.FETCHED;
    notifyListeners();
  }

  getOrdereList() async {
    orderList = await _commonDashBoardApis.getOrdersList(
      pageSize: pageSize + 5,
      pageNumber: 0,
      status: 'DELIVERED',
    );
    orderListApi = ApiStatus.FETCHED;
    notifyListeners();
  }

  void getOrderReports() async {
    consolidatedOrdersReportResponse =
        await _reportsApi.getConsolidatedOrdersReport(
      pageNumber: pageNumber,
      pageSize: pageSize,
      dateFrom: DateTimeToStringConverter.yyyymmdd(
        date: dateTimeRange.start,
      ).convert(),
      dateTo: DateTimeToStringConverter.yyyymmdd(
        date: dateTimeRange.end,
      ).convert(),
      selectedOrderStatus: selectedOrderStatus,
      selectedBrand: null,
      selectedType: null,
    );

    getConsolidatedOrderReportsApiStatus = ApiStatus.FETCHED;

    ordersReportGroupByBrandResponse =
        await _reportsApi.getOrdersReportGroupByBrands(
      pageNumber: pageNumber,
      pageSize: pageSize,
      dateFrom: DateTimeToStringConverter.yyyymmdd(
        date: dateTimeRange.start,
      ).convert(),
      dateTo: DateTimeToStringConverter.yyyymmdd(
        date: dateTimeRange.end,
      ).convert(),
      selectedOrderStatus: selectedOrderStatus,
      selectedBrand: null,
      selectedType: null,
    );
    ordersReportGroupByTypeResponse =
        await _reportsApi.getOrdersReportGroupByTypes(
      pageNumber: pageNumber,
      pageSize: pageSize,
      dateFrom: DateTimeToStringConverter.yyyymmdd(
        date: dateTimeRange.start,
      ).convert(),
      dateTo: DateTimeToStringConverter.yyyymmdd(
        date: dateTimeRange.end,
      ).convert(),
      selectedOrderStatus: selectedOrderStatus,
      selectedBrand: null,
      selectedType: null,
    );
    ordersReportGroupBySubTypeResponse =
        await _reportsApi.getOrdersReportGroupBySubTypes(
      pageNumber: pageNumber,
      pageSize: pageSize,
      dateFrom: DateTimeToStringConverter.yyyymmdd(
        date: dateTimeRange.start,
      ).convert(),
      dateTo: DateTimeToStringConverter.yyyymmdd(
        date: dateTimeRange.end,
      ).convert(),
      selectedOrderStatus: selectedOrderStatus,
      selectedBrand: null,
      selectedType: null,
    );

    getConsolidatedOrderReportsApiStatus = ApiStatus.FETCHED;
    getOrderReportsGroupByBrandApiStatus = ApiStatus.FETCHED;
    getOrderReportsGroupByTypeApiStatus = ApiStatus.FETCHED;
    getOrderReportsGroupBySubTypeApiStatus = ApiStatus.FETCHED;

    notifyListeners();
  }
}
