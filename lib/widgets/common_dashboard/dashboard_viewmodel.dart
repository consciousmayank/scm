import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:scm/app/app.logger.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/common_dashboard_order_info.dart';
import 'package:scm/model_classes/common_dashboard_ordered_brands.dart';
import 'package:scm/model_classes/common_dashboard_ordered_sub_types.dart';
import 'package:scm/model_classes/common_dashboard_ordered_types.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/reports/orders_report/order_report_view.dart';
import 'package:scm/services/app_api_service_classes/common_dashboard_apis.dart';
import 'package:scm/services/app_api_service_classes/reports_apis.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/widgets/common_dashboard/dashboard_view.dart';

const String getOrderReportsGroupByBrandApiStatus =
    'getOrderReportsGroupByBrandApiStatus';
const String getOrderReportsGroupBySubTypeApiStatus =
    'getOrderReportsGroupBySubTypeApiStatus';
const String getOrderReportsGroupByTypeApiStatus =
    'getOrderReportsGroupByTypeApiStatus';
const String orderInfoApi = 'orderInfoApi';
const String orderedBrandsApi = 'orderedBrandsApi';
const String orderedSubTypeApi = 'orderedSubTypeApi';
const String orderedTypesApi = 'orderedTypesApi';
const String orderListApi = 'orderListApi';

class CommonDashboardViewModel extends GeneralisedBaseViewModel {
  late final CommonDashboardViewArguments arguments;
  late final Color barChartsBarColor;
  //for order reports
  late DateTimeRange dateTimeRange;

  // ApiStatus getConsolidatedOrderReportsApiStatus = ApiStatus.LOADING;
  final log = getLogger('CommonDashboardViewModel');
  CommonDashboardOrderInfo orderInfo = CommonDashboardOrderInfo().empty();

  OrderListResponse orderList = OrderListResponse().empty();
  List<CommonDashboardOrderedBrands> orderedBrands = [];
  List<charts.Series<CommonDashboardOrderedBrands, String>>
      orderedBrandsBarData = [];

  List<CommonDashboardOrderedSubTypes> orderedSubTypes = [];
  List<charts.Series<CommonDashboardOrderedSubTypes, String>>
      orderedSubTypesBarData = [];

  List<CommonDashboardOrderedTypes> orderedTypes = [];
  List<charts.Series<CommonDashboardOrderedTypes, String>> orderedTypesBarData =
      [];

  List<charts.Series<ReportResultSet, String>> ordersReportGroupByBrandBarData =
      [];

  OrdersReportResponse? ordersReportGroupByBrandResponse =
      OrdersReportResponse().empty();
  List<charts.Series<ReportResultSet, String>>
      ordersReportGroupBySubTypeBarData = [];

  OrdersReportResponse? ordersReportGroupBySubTypeResponse =
      OrdersReportResponse().empty();
  List<charts.Series<ReportResultSet, String>> ordersReportGroupByTypeBarData =
      [];

  OrdersReportResponse? ordersReportGroupByTypeResponse =
      OrdersReportResponse().empty();
  // List<charts.Series<ReportResultSet, String>> consolidatedBarData = [];
  int pageNumber = 0;

  int pageSize = 10;
  int reportsByBrandsIndex = 0;
  int reportsByCategoryIndex = 0;
  int reportsBySubCategoryIndex = 0;
  late String selectedOrderStatus;
  int trendingBrandsIndex = 0;
  // int trendingBrandsIndex = 0;
  int trendingCategoriesIndex = 0;

  int trendingSubCategoriesIndex = 0;

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
    getOrderedSubType();
    getOrdereList();

    //for order reports

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

  getOrderInfo() async {
    orderInfo = await runBusyFuture(
      _commonDashBoardApis.getOrderInfo(),
      busyObject: orderInfo,
    );
  }

  getOrderedBrands() async {
    orderedBrands = await runBusyFuture(
      _commonDashBoardApis.getOrderedBrands(
        pageSize: pageSize,
      ),
      busyObject: orderedBrandsApi,
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
    // notifyListeners();
  }

  getOrderedSubType() async {
    orderedSubTypes = await runBusyFuture(
      _commonDashBoardApis.getOrderedSubTypes(
        pageSize: pageSize,
      ),
      busyObject: orderedSubTypeApi,
    );

    orderedSubTypesBarData = [
      charts.Series(
        id: 'Ordered SubTypes',
        data: orderedSubTypes,
        insideLabelStyleAccessorFn: (CommonDashboardOrderedSubTypes series,
                _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (CommonDashboardOrderedSubTypes series,
                _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (CommonDashboardOrderedSubTypes series, _) => series.subType!,
        measureFn: (CommonDashboardOrderedSubTypes series, _) => series.count,
        colorFn: (CommonDashboardOrderedSubTypes series, _) =>
            charts.ColorUtil.fromDartColor(barChartsBarColor),
        labelAccessorFn: (CommonDashboardOrderedSubTypes series, _) =>
            series.count.toString(),
      ),
    ];
    // notifyListeners();
  }

  getOrderedTypes() async {
    orderedTypes = await runBusyFuture(
      _commonDashBoardApis.getOrderedTypes(
        pageSize: pageSize,
      ),
      busyObject: orderedTypesApi,
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
    // notifyListeners();
  }

  getOrdereList() async {
    orderList = await runBusyFuture(
      _commonDashBoardApis.getOrdersList(
        pageSize: pageSize + 5,
        pageNumber: 0,
        status: 'DELIVERED',
      ),
      busyObject: orderListApi,
    );
    // notifyListeners();
  }

  void getOrderReports() async {
    ordersReportGroupByBrandResponse = await runBusyFuture(
      _reportsApi.getOrdersReportGroupByBrands(
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
      ),
      busyObject: getOrderReportsGroupByBrandApiStatus,
    );

    ordersReportGroupByBrandBarData = [
      charts.Series(
        id: 'Quantity',
        data: ordersReportGroupByBrandResponse!.reportResultSet!,
        insideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (ReportResultSet series, _) => series.itemBrand!,
        measureFn: (ReportResultSet series, _) => series.itemQuantity,
        colorFn: (ReportResultSet series, _) =>
            charts.ColorUtil.fromDartColor(barChartsBarColor),
        labelAccessorFn: (ReportResultSet series, _) =>
            series.itemQuantity.toString(),
      ),
      charts.Series(
        id: 'Amount',
        data: ordersReportGroupByBrandResponse!.reportResultSet!,
        insideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (ReportResultSet series, _) => series.itemBrand!,
        measureFn: (ReportResultSet series, _) => series.itemAmount,
        colorFn: (ReportResultSet series, _) =>
            charts.ColorUtil.fromDartColor(AppColors().loginPageButtonBg),
        labelAccessorFn: (ReportResultSet series, _) =>
            series.itemAmount.toString(),
      ),
    ];

    ordersReportGroupByTypeResponse = await runBusyFuture(
      _reportsApi.getOrdersReportGroupByTypes(
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
      ),
      busyObject: getOrderReportsGroupByTypeApiStatus,
    );

    ordersReportGroupByTypeBarData = [
      charts.Series(
        id: 'Quantity',
        data: ordersReportGroupByTypeResponse!.reportResultSet!,
        insideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (ReportResultSet series, _) => series.itemType!,
        measureFn: (ReportResultSet series, _) => series.itemQuantity,
        colorFn: (ReportResultSet series, _) =>
            charts.ColorUtil.fromDartColor(barChartsBarColor),
        labelAccessorFn: (ReportResultSet series, _) =>
            series.itemQuantity.toString(),
      ),
      charts.Series(
        id: 'Amount',
        data: ordersReportGroupByTypeResponse!.reportResultSet!,
        insideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (ReportResultSet series, _) => series.itemType!,
        measureFn: (ReportResultSet series, _) => series.itemAmount,
        colorFn: (ReportResultSet series, _) =>
            charts.ColorUtil.fromDartColor(AppColors().loginPageButtonBg),
        labelAccessorFn: (ReportResultSet series, _) =>
            series.itemAmount.toString(),
      ),
    ];

    ordersReportGroupBySubTypeResponse = await runBusyFuture(
      _reportsApi.getOrdersReportGroupBySubTypes(
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
      ),
      busyObject: getOrderReportsGroupBySubTypeApiStatus,
    );

    ordersReportGroupBySubTypeBarData = [
      charts.Series(
        id: 'Quantity',
        data: ordersReportGroupBySubTypeResponse!.reportResultSet!,
        insideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (ReportResultSet series, _) => series.itemSubType!,
        measureFn: (ReportResultSet series, _) => series.itemQuantity,
        colorFn: (ReportResultSet series, _) =>
            charts.ColorUtil.fromDartColor(barChartsBarColor),
        labelAccessorFn: (ReportResultSet series, _) =>
            series.itemQuantity.toString(),
      ),
      charts.Series(
        id: 'Amount',
        data: ordersReportGroupBySubTypeResponse!.reportResultSet!,
        insideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (ReportResultSet series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (ReportResultSet series, _) => series.itemSubType!,
        measureFn: (ReportResultSet series, _) => series.itemAmount,
        colorFn: (ReportResultSet series, _) =>
            charts.ColorUtil.fromDartColor(AppColors().loginPageButtonBg),
        labelAccessorFn: (ReportResultSet series, _) =>
            series.itemAmount.toString(),
      ),
    ];
  }

  String getDateTimeText() {
    return "${DateTimeToStringConverter.MMddyyyy(date: dateTimeRange.start).convert()} - ${DateTimeToStringConverter.MMddyyyy(date: dateTimeRange.end).convert()}";
  }

  void takeToOrderReportsPage() {
    navigationService.navigateTo(
      orderReportsScreenPageRoute,
      arguments: OrderReportsViewArgs(
        orderStatus: OrderStatusTypes.DELIVERED,
      ),
    );
  }

  getFromDateText() {
    return DateTimeToStringConverter.MMddyyyy(date: dateTimeRange.start)
        .convert();
  }

  getToDateText() {
    return DateTimeToStringConverter.MMddyyyy(date: dateTimeRange.end)
        .convert();
  }

  void updateStartDateInDateRange(DateTime date) {
    dateTimeRange = DateTimeRange(
      start: date,
      end: dateTimeRange.end,
    );
    getOrderReports();
  }

  void updateEndDateInDateRange(DateTime date) {
    dateTimeRange = DateTimeRange(
      start: dateTimeRange.start,
      end: date,
    );
    getOrderReports();
  }
}
