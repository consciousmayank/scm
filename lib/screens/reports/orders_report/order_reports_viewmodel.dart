import 'dart:io';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
import 'package:scm/utils/strings.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OrderReportsViewModel extends GeneralisedBaseViewModel {
  List<String> brandsList = [];
  OrdersReportResponse? consolidatedOrdersReportResponse;
  late DateTimeRange dateTimeRange;
  ApiStatus getConsolidatedOrderReportsApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupByBrandApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupBySubTypeApiStatus = ApiStatus.LOADING;
  ApiStatus getOrderReportsGroupByTypeApiStatus = ApiStatus.LOADING;
  final log = getLogger('OrderReportsViewModel');
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
  final pdf = pw.Document();
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

  void writeOnPdf() async {
    pdf.addPage(
      pw.MultiPage(
        footer: (context) => pw.Container(
          alignment: pw.Alignment.center,
          width: double.infinity,
          margin: const pw.EdgeInsets.only(
            top: 2,
            bottom: 16,
          ),
          padding: const pw.EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: const pw.BoxDecoration(
            color: PdfColors.grey400,
            border: pw.Border(
              bottom: pw.BorderSide(width: 0.1),
              top: pw.BorderSide(width: 0.1),
            ),
          ),
          child: pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Product Of Geek Technotonic @2021',
                    style: const pw.TextStyle(
                        fontSize: 10, color: PdfColors.white),
                  ),
                  pw.Text(
                    'Page ${context.pageNumber}/${context.pagesCount}',
                    style:
                        const pw.TextStyle(fontSize: 8, color: PdfColors.white),
                  )
                ],
              )),
        ),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return <pw.Widget>[
            pw.Header(
              level: 0,
              child: pw.Row(
                children: <pw.Widget>[
                  pw.Text(
                    appName,
                    style: const pw.TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            pw.Column(
              children: <pw.Widget>[
                pw.Text(
                  'Order Report of ${preferences.getSupplierDemandProfile()?.businessName!}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.normal,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Row(children: [
                  pw.Expanded(
                      child: pw.Text(
                          'From: ${DateTimeToStringConverter.ddmmyy(date: dateTimeRange.start).convert()}'),
                      flex: 1),
                  pw.SizedBox(
                    width: 8,
                  ),
                  pw.Expanded(
                      child: pw.Text(
                          'To: ${DateTimeToStringConverter.ddmmyy(date: dateTimeRange.end).convert()}'),
                      flex: 1),
                ]),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Row(children: [
                  pw.Expanded(child: pw.Text('Selected Order Status'), flex: 1),
                  pw.SizedBox(
                    width: 8,
                  ),
                  pw.Expanded(child: pw.Text('$selectedOrderStatus'), flex: 1),
                ]),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Row(children: [
                  pw.Expanded(child: pw.Text('Selected Brand'), flex: 1),
                  pw.SizedBox(
                    width: 8,
                  ),
                  pw.Expanded(child: pw.Text('$selectedBrand'), flex: 1),
                ]),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Row(children: [
                  pw.Expanded(child: pw.Text('Selected Category'), flex: 1),
                  pw.SizedBox(
                    width: 8,
                  ),
                  pw.Expanded(child: pw.Text('$selectedType'), flex: 1),
                ]),
              ],
            ),
            pw.SizedBox(
              height: 16,
            ),
            pw.Header(level: 1, text: 'Order Items'),
            getConsolidatedOrdersTable(),
            pw.SizedBox(height: 32),
            pw.Header(level: 1, text: 'Order Brands'),
            getOrdersByBrandsTable(),
            pw.SizedBox(height: 32),
            pw.Header(level: 1, text: 'Order Category'),
            getOrdersByCategoryTable(),
            pw.SizedBox(height: 32),
            pw.Header(level: 1, text: 'Order SubCategory'),
            getOrdersBySubCategoryTable(),
          ];
        },
      ),
    );

    Uint8List pdfInBytes = await pdf.save();

    FileSaver.instance
        .saveFile(
      'Order Report',
      pdfInBytes,
      '.pdf',
      mimeType: MimeType.PDF,
    )
        .then((value) {
      setBusy(false);
      showInfoSnackBar(
        message: reportDownloadedSuccessMessage(
          storedDirectory: value,
        ),
      );
    });
  }

  pw.TableBorder getTableBorder() {
    return const pw.TableBorder(
      bottom: pw.BorderSide(
        width: 0.5,
        color: PdfColors.black,
      ),
      left: pw.BorderSide(
        width: 0.5,
        color: PdfColors.black,
      ),
      right: pw.BorderSide(
        width: 0.5,
        color: PdfColors.black,
      ),
      top: pw.BorderSide(
        width: 0.5,
        color: PdfColors.black,
      ),
      horizontalInside: pw.BorderSide(
        width: 0.5,
        color: PdfColors.black,
      ),
      verticalInside: pw.BorderSide(
        width: 0.5,
        color: PdfColors.black,
      ),
    );
  }

  pw.Table getConsolidatedOrdersTable() {
    return pw.Table(
      border: getTableBorder(),
      children: getTableRows(
          reportResponse: consolidatedOrdersReportResponse!,
          qtyTotal: getGrandTotalOfConsolidatedOrdersQty(),
          amountTotal: getGrandTotalOfConsolidatedOrdersAmount()),
    );
  }

  pw.Table getOrdersByBrandsTable() {
    return pw.Table(
      border: getTableBorder(),
      children: getTableRows(
          reportResponse: ordersReportGroupByBrandResponse!,
          qtyTotal: getGrandTotalOfOrdersQtyGroupByBrand(),
          amountTotal: getGrandTotalOfOrdersAmountGroupByBrand()),
    );
  }

  pw.Table getOrdersByCategoryTable() {
    return pw.Table(
      border: getTableBorder(),
      children: getTableRows(
          reportResponse: ordersReportGroupByTypeResponse!,
          qtyTotal: getGrandTotalOfOrdersQtyGroupByType(),
          amountTotal: getGrandTotalOfOrdersAmountGroupByType()),
    );
  }

  pw.Table getOrdersBySubCategoryTable() {
    return pw.Table(
      border: getTableBorder(),
      children: getTableRows(
          reportResponse: ordersReportGroupBySubTypeResponse!,
          qtyTotal: getGrandTotalOfOrdersQtyGroupBySubType(),
          amountTotal: getGrandTotalOfOrdersAmountGroupBySubType()),
    );
  }

  List<pw.TableRow> getTableRows(
      {required OrdersReportResponse reportResponse,
      required int qtyTotal,
      required double amountTotal}) {
    List<pw.TableRow> tableRows = [];

    tableRows.add(
      pw.TableRow(
        decoration: pw.BoxDecoration(
          color: PdfColors.lightBlue,
          border: pw.Border.all(
            color: PdfColors.black,
            width: 0.5,
          ),
        ),
        children: [
          headerColumn(
            value: 'S.No',
          ),
          headerColumn(
            value: 'Name',
          ),
          headerColumn(
            value: 'Quantity',
            textAlign: pw.TextAlign.right,
          ),
          headerColumn(
            value: 'Amount',
            textAlign: pw.TextAlign.right,
          ),
        ],
      ),
    );

    consolidatedOrdersReportResponse?.reportResultSet?.forEach((element) {
      tableRows.add(
        pw.TableRow(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.black,
              width: 0.5,
            ),
          ),
          children: [
            normalColumn(
              value:
                  '${(consolidatedOrdersReportResponse?.reportResultSet?.indexOf(element))! + 1}',
              textAlign: pw.TextAlign.center,
            ),
            normalColumn(
              value: element.itemTitle ?? '-',
              textAlign: pw.TextAlign.left,
            ),
            normalColumn(
              value: '${element.itemQuantity ?? '-'}',
              textAlign: pw.TextAlign.right,
            ),
            normalColumn(
              value: '${element.itemAmount ?? '-'}',
              textAlign: pw.TextAlign.right,
            ),
          ],
        ),
      );
    });

    tableRows.add(pw.TableRow(children: [
      normalColumn(
        value: '',
        textAlign: pw.TextAlign.right,
      ),
      normalColumn(
        value: 'Grand Total',
        textAlign: pw.TextAlign.center,
        textStyle: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
      ),
      normalColumn(
        value: qtyTotal.toStringAsFixed(2),
        textAlign: pw.TextAlign.right,
        textStyle: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
      ),
      normalColumn(
        value: amountTotal.toStringAsFixed(2),
        textAlign: pw.TextAlign.right,
        textStyle: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ]));

    return tableRows;
  }

  pw.Padding headerColumn({
    required String value,
    pw.TextAlign? textAlign,
  }) {
    textAlign = textAlign ?? pw.TextAlign.center;
    return pw.Padding(
        padding: const pw.EdgeInsets.all(
          8,
        ),
        child: pw.Text(
          value,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 12,
          ),
        ));
  }

  pw.Padding normalColumn({
    required String value,
    required pw.TextAlign textAlign,
    pw.TextStyle? textStyle,
  }) {
    textStyle ??= pw.TextStyle(
      fontWeight: pw.FontWeight.normal,
      fontSize: 10,
    );

    return pw.Padding(
      padding: const pw.EdgeInsets.all(
        8,
      ),
      child: pw.Text(value, style: textStyle, textAlign: textAlign),
    );
  }
}
