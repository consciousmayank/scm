import 'dart:io';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:scm/app/app.logger.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/screens/reports/orders_report/order_report_view.dart';
import 'package:scm/services/app_api_service_classes/reports_apis.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/utils/order_reports_pdf_generator.dart';
import 'package:scm/utils/strings.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OrderReportsViewModel extends GeneralisedBaseViewModel {
  List<String> brandsList = [];
  OrdersReportResponse consolidatedOrdersReportResponse =
      OrdersReportResponse().empty();

  late DateTimeRange dateTimeRange;
  ApiStatus getConsolidatedOrderReportsApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupByBrandApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupBySubTypeApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupByTypeApiStatus = ApiStatus.LOADING;
  final log = getLogger('OrderReportsViewModel');
  OrdersReportResponse ordersReportGroupByBrandResponse =
      OrdersReportResponse().empty();

  OrdersReportResponse ordersReportGroupBySubTypeResponse =
      OrdersReportResponse().empty();

  OrdersReportResponse ordersReportGroupByTypeResponse =
      OrdersReportResponse().empty();

  int pageNumber = 0;
  int pageSize = 15;
  late String selectedOrderStatus;
  String? selectedBrand, selectedType;
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

    selectedOrderStatus = args.orderStatus.apiToAppTitles;
    selectedBrand = labelALL;
    selectedType = labelALL;
    getOrderReports();
  }

  void getOrderReports() async {
    getConsolidatedOrderReportsApiStatus = ApiStatus.LOADING;
    getOrderReportsGroupByBrandApiStatus = ApiStatus.LOADING;
    getOrderReportsGroupByTypeApiStatus = ApiStatus.LOADING;
    getOrderReportsGroupBySubTypeApiStatus = ApiStatus.LOADING;
    notifyListeners();

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
      selectedOrderStatus: selectedOrderStatus,
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
      selectedOrderStatus: selectedOrderStatus,
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
      selectedOrderStatus: selectedOrderStatus,
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
    if (ordersReportGroupByBrandResponse.reportResultSet!.isEmpty) {
      return [];
    } else {
      List<String> brandList = [];
      brandList = ordersReportGroupByBrandResponse.reportResultSet!
          .map((e) => e.itemBrand ?? '-')
          .toList();
      brandList.insert(0, labelALL);
      return brandList;
    }
  }

  List<String> populateTypeList() {
    if (ordersReportGroupByTypeResponse.reportResultSet!.isEmpty) {
      return [];
    } else {
      List<String> typeList = [];
      typeList = ordersReportGroupByTypeResponse.reportResultSet!
          .map((e) => e.itemType ?? '-')
          .toList();
      typeList.insert(0, labelALL);
      return typeList;
    }
  }

  int getGrandTotalOfConsolidatedOrdersQty() {
    if (consolidatedOrdersReportResponse.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return consolidatedOrdersReportResponse.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemQuantity!,
      );
    }
  }

  double getGrandTotalOfConsolidatedOrdersAmount() {
    if (consolidatedOrdersReportResponse.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return consolidatedOrdersReportResponse.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemAmount!,
      );
    }
  }

  int getGrandTotalOfOrdersQtyGroupByBrand() {
    if (ordersReportGroupByBrandResponse.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupByBrandResponse.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemQuantity!,
      );
    }
  }

  double getGrandTotalOfOrdersAmountGroupByBrand() {
    if (ordersReportGroupByBrandResponse.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupByBrandResponse.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemAmount!,
      );
    }
  }

  int getGrandTotalOfOrdersQtyGroupByType() {
    if (ordersReportGroupByTypeResponse.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupByTypeResponse.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemQuantity!,
      );
    }
  }

  double getGrandTotalOfOrdersAmountGroupByType() {
    if (ordersReportGroupByTypeResponse.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupByTypeResponse.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemAmount!,
      );
    }
  }

  int getGrandTotalOfOrdersQtyGroupBySubType() {
    if (ordersReportGroupBySubTypeResponse.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupBySubTypeResponse.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemQuantity!,
      );
    }
  }

  double getGrandTotalOfOrdersAmountGroupBySubType() {
    if (ordersReportGroupBySubTypeResponse.reportResultSet!.isEmpty) {
      return 0;
    } else {
      return ordersReportGroupBySubTypeResponse.reportResultSet!.fold(
        0,
        (previousValue, element) => previousValue + element.itemAmount!,
      );
    }
  }

  void writeOnPdf() async {
    OrderReportsPdfGenerator orderReportPdfGenerator = OrderReportsPdfGenerator(
      appName: appName,
      selectedOrderStatus: selectedOrderStatus,
      selectedBrand: selectedBrand ?? '',
      selectedType: selectedType ?? '',
      dateTimeRange: dateTimeRange,
      consolidatedOrdersReportResponse: consolidatedOrdersReportResponse,
      ordersReportGroupByTypeResponse: ordersReportGroupByTypeResponse,
      ordersReportGroupBySubTypeResponse: ordersReportGroupBySubTypeResponse,
      ordersReportGroupByBrandResponse: ordersReportGroupByBrandResponse,
      totalOfOrdersQtyGroupBySubType: getGrandTotalOfOrdersQtyGroupBySubType(),
      totalOfOrdersQtyGroupByType: getGrandTotalOfOrdersQtyGroupByType(),
      totalOfOrdersQtyGroupByBrand: getGrandTotalOfOrdersQtyGroupByBrand(),
      totalOfConsolidatedOrdersQty: getGrandTotalOfConsolidatedOrdersQty(),
      totalOfOrdersAmountGroupBySubType:
          getGrandTotalOfOrdersAmountGroupBySubType(),
      totalOfOrdersAmountGroupByType: getGrandTotalOfOrdersAmountGroupByType(),
      totalOfOrdersAmountGroupByBrand:
          getGrandTotalOfOrdersAmountGroupByBrand(),
      totalOfConsolidatedOrdersAmount:
          getGrandTotalOfConsolidatedOrdersAmount(),
    );

    orderReportPdfGenerator.writeOnPdf();
  }
}
