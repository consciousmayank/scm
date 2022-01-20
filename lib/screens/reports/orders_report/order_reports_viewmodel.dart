import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/screens/reports/orders_report/order_report_view.dart';
import 'package:scm/services/app_api_service_classes/reports_apis.dart';
import 'package:scm/utils/date_time_converter.dart';

class OrderReportsViewModel extends GeneralisedBaseViewModel {
  late DateTimeRange dateTimeRange;
  int pageNumber = 0;
  int pageSize = 15;
  String? selectedOrderStatus, selectedBrand, selectedType;
  List<String> orderStatuses = [
    OrderStatusTypes.CREATED.apiToAppTitles,
    OrderStatusTypes.INTRANSIT.apiToAppTitles,
    OrderStatusTypes.DELIVERED.apiToAppTitles,
  ];
  final ReportsApi _reportsApi = locator<ReportsApi>();
  ApiStatus getConsolidatedOrderReportsApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupByBrandApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupByTypeApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupBySubTypeApiStatus = ApiStatus.LOADING;
  OrdersReportResponse? consolidatedOrdersReportResponse;
  OrdersReportResponse? ordersReportGroupByBrandResponse;
  OrdersReportResponse? ordersReportGroupByTypeResponse;
  OrdersReportResponse? ordersReportGroupBySubTypeResponse;
  List<String> brandsList = [];
  List<String> typesList = [];

  init({required OrderReportsViewArgs args}) {
    dateTimeRange = DateTimeRange(
      end: DateTime.now(),
      start: DateTime.now().subtract(
        const Duration(
          days: 30,
        ),
      ),
    );
    selectedOrderStatus = orderStatuses.first;
    getOrderReports();
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
      selectedOrderStatus: selectedOrderStatus ?? orderStatuses.first,
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
      selectedOrderStatus: selectedOrderStatus ?? orderStatuses.first,
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
      selectedOrderStatus: selectedOrderStatus ?? orderStatuses.first,
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
      selectedOrderStatus: selectedOrderStatus ?? orderStatuses.first,
    );

    getConsolidatedOrderReportsApiStatus = ApiStatus.FETCHED;
    getOrderReportsGroupByBrandApiStatus = ApiStatus.FETCHED;
    getOrderReportsGroupByTypeApiStatus = ApiStatus.FETCHED;
    getOrderReportsGroupBySubTypeApiStatus = ApiStatus.FETCHED;

    brandsList = populateBrandList();
    typesList = populateTypeList();

    notifyListeners();
  }

  void updateDateRange(DateTimeRange? newDateTimeRange) {
    if (newDateTimeRange == null) {
      return;
    }

    dateTimeRange = newDateTimeRange;
    notifyListeners();
    getOrderReports();
  }

  String getDateText() {
    if (dateTimeRange.start == dateTimeRange.end) {
      return DateTimeToStringConverter.ddMMMMyy(
        date: dateTimeRange.start,
      ).convert();
    } else {
      return 'From ${DateTimeToStringConverter.ddMMMMyy(
        date: dateTimeRange.start,
      ).convert()} To ${DateTimeToStringConverter.ddMMMMyy(
        date: dateTimeRange.end,
      ).convert()}';
    }
  }

  List<String> populateBrandList() {
    if (ordersReportGroupByBrandResponse == null ||
        ordersReportGroupByBrandResponse?.reportResultSet == null) {
      return [];
    } else if (ordersReportGroupByBrandResponse!.reportResultSet!.isEmpty) {
      return [];
    } else {
      return ordersReportGroupByBrandResponse!.reportResultSet!
          .map((e) => e.itemBrand ?? '-')
          .toList();
    }
  }

  List<String> populateTypeList() {
    if (ordersReportGroupByTypeResponse == null ||
        ordersReportGroupByTypeResponse?.reportResultSet == null) {
      return [];
    } else if (ordersReportGroupByTypeResponse!.reportResultSet!.isEmpty) {
      return [];
    } else {
      return ordersReportGroupByTypeResponse!.reportResultSet!
          .map((e) => e.itemType ?? '-')
          .toList();
    }
  }

  int getGrandTotalOfConsolidatedOrdersQty() {
    if (consolidatedOrdersReportResponse == null ||
        consolidatedOrdersReportResponse?.reportResultSet == null) {
      return 0;
    } else if (consolidatedOrdersReportResponse!.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return consolidatedOrdersReportResponse!.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemQuantity!,
      );
    }
  }

  double getGrandTotalOfConsolidatedOrdersAmount() {
    if (consolidatedOrdersReportResponse == null ||
        consolidatedOrdersReportResponse?.reportResultSet == null) {
      return 0;
    } else if (consolidatedOrdersReportResponse!.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return consolidatedOrdersReportResponse!.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemAmount!,
      );
    }
  }

  int getGrandTotalOfOrdersQtyGroupByBrand() {
    if (ordersReportGroupByBrandResponse == null ||
        ordersReportGroupByBrandResponse?.reportResultSet == null) {
      return 0;
    } else if (ordersReportGroupByBrandResponse!.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupByBrandResponse!.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemQuantity!,
      );
    }
  }

  double getGrandTotalOfOrdersAmountGroupByBrand() {
    if (ordersReportGroupByBrandResponse == null ||
        ordersReportGroupByBrandResponse?.reportResultSet == null) {
      return 0;
    } else if (ordersReportGroupByBrandResponse!.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupByBrandResponse!.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemAmount!,
      );
    }
  }

  int getGrandTotalOfOrdersQtyGroupByType() {
    if (ordersReportGroupByTypeResponse == null ||
        ordersReportGroupByTypeResponse?.reportResultSet == null) {
      return 0;
    } else if (ordersReportGroupByTypeResponse!.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupByTypeResponse!.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemQuantity!,
      );
    }
  }

  double getGrandTotalOfOrdersAmountGroupByType() {
    if (ordersReportGroupByTypeResponse == null ||
        ordersReportGroupByTypeResponse?.reportResultSet == null) {
      return 0;
    } else if (ordersReportGroupByTypeResponse!.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupByTypeResponse!.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemAmount!,
      );
    }
  }

  int getGrandTotalOfOrdersQtyGroupBySubType() {
    if (ordersReportGroupBySubTypeResponse == null ||
        ordersReportGroupBySubTypeResponse?.reportResultSet == null) {
      return 0;
    } else if (ordersReportGroupBySubTypeResponse!.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupBySubTypeResponse!.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemQuantity!,
      );
    }
  }

  double getGrandTotalOfOrdersAmountGroupBySubType() {
    if (ordersReportGroupBySubTypeResponse == null ||
        ordersReportGroupBySubTypeResponse?.reportResultSet == null) {
      return 0;
    } else if (ordersReportGroupBySubTypeResponse!.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupBySubTypeResponse!.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemAmount!,
      );
    }
  }
}
