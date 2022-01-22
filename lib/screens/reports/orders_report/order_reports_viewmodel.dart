import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/screens/reports/orders_report/order_report_view.dart';
import 'package:scm/services/app_api_service_classes/reports_apis.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/utils/strings.dart';

class OrderReportsViewModel extends GeneralisedBaseViewModel {
  List<String> brandsList = [];
  OrdersReportResponse? consolidatedOrdersReportResponse;
  late DateTimeRange dateTimeRange;
  ApiStatus getConsolidatedOrderReportsApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupByBrandApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupBySubTypeApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupByTypeApiStatus = ApiStatus.LOADING;
  List<String> orderStatuses = [
    OrderStatusTypes.DELIVERED.apiToAppTitles,
    OrderStatusTypes.INTRANSIT.apiToAppTitles,
    OrderStatusTypes.CREATED.apiToAppTitles,
  ];

  OrdersReportResponse? ordersReportGroupByBrandResponse;
  OrdersReportResponse? ordersReportGroupBySubTypeResponse;
  OrdersReportResponse? ordersReportGroupByTypeResponse;
  int pageNumber = 0;
  int pageSize = 15;
  String? selectedOrderStatus, selectedBrand, selectedType;
  List<String> typesList = [];

  final ReportsApi _reportsApi = locator<ReportsApi>();

  init({required OrderReportsViewArgs args}) {
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

    selectedOrderStatus = orderStatuses.first;
    selectedBrand = labelALL;
    selectedType = labelALL;
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
      selectedBrand: selectedBrand == labelALL ? null : selectedBrand,
      selectedType: selectedType == labelALL ? null : selectedType,
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
      selectedBrand: selectedBrand == labelALL ? null : selectedBrand,
      selectedType: selectedType == labelALL ? null : selectedType,
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
      selectedBrand: selectedBrand == labelALL ? null : selectedBrand,
      selectedType: selectedType == labelALL ? null : selectedType,
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
      selectedBrand: selectedBrand == labelALL ? null : selectedBrand,
      selectedType: selectedType == labelALL ? null : selectedType,
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

  void updateStartDateInDateRange(DateTime newDateTime) {
    dateTimeRange = DateTimeRange(
      end: dateTimeRange.end,
      start: newDateTime,
    );
    notifyListeners();
    getOrderReports();
  }

  void updateEndDateInDateRange(DateTime newDateTime) {
    dateTimeRange = DateTimeRange(
      end: newDateTime,
      start: dateTimeRange.start,
    );
    notifyListeners();
    getOrderReports();
  }

  String getToDateText() {
    return DateTimeToStringConverter.ddMMMMyyyy(
      date: dateTimeRange.end,
    ).convert();
  }

  String getFromDateText() {
    return DateTimeToStringConverter.ddMMMMyyyy(
      date: dateTimeRange.start,
    ).convert();
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
      List<String> brandList = [];
      brandList = ordersReportGroupByBrandResponse!.reportResultSet!
          .map((e) => e.itemBrand ?? '-')
          .toList();
      brandList.insert(0, labelALL);
      return brandList;
    }
  }

  List<String> populateTypeList() {
    if (ordersReportGroupByTypeResponse == null ||
        ordersReportGroupByTypeResponse?.reportResultSet == null) {
      return [];
    } else if (ordersReportGroupByTypeResponse!.reportResultSet!.isEmpty) {
      return [];
    } else {
      List<String> typeList = [];
      typeList = ordersReportGroupByTypeResponse!.reportResultSet!
          .map((e) => e.itemType ?? '-')
          .toList();
      typeList.insert(0, labelALL);
      return typeList;
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
