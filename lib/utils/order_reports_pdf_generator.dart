// ignore_for_file: unnecessary_string_interpolations

import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:scm/app/di.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/services/sharepreferences_service.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderReportsPdfGenerator {
  final String appName, selectedOrderStatus, selectedBrand, selectedType;
  final DateTimeRange dateTimeRange;
  final OrdersReportResponse consolidatedOrdersReportResponse,
      ordersReportGroupByTypeResponse,
      ordersReportGroupBySubTypeResponse,
      ordersReportGroupByBrandResponse;

  final int totalOfOrdersQtyGroupBySubType,
      totalOfOrdersQtyGroupByType,
      totalOfOrdersQtyGroupByBrand,
      totalOfConsolidatedOrdersQty;
  final double totalOfOrdersAmountGroupBySubType,
      totalOfOrdersAmountGroupByType,
      totalOfOrdersAmountGroupByBrand,
      totalOfConsolidatedOrdersAmount;

  final pdf = pw.Document();
  final AppPreferencesService preferences = locator<AppPreferencesService>();

  OrderReportsPdfGenerator({
    required this.appName,
    required this.selectedOrderStatus,
    required this.selectedBrand,
    required this.selectedType,
    required this.dateTimeRange,
    required this.consolidatedOrdersReportResponse,
    required this.ordersReportGroupByTypeResponse,
    required this.ordersReportGroupBySubTypeResponse,
    required this.ordersReportGroupByBrandResponse,
    required this.totalOfOrdersQtyGroupBySubType,
    required this.totalOfOrdersQtyGroupByType,
    required this.totalOfOrdersQtyGroupByBrand,
    required this.totalOfConsolidatedOrdersQty,
    required this.totalOfOrdersAmountGroupBySubType,
    required this.totalOfOrdersAmountGroupByType,
    required this.totalOfOrdersAmountGroupByBrand,
    required this.totalOfConsolidatedOrdersAmount,
  });

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
                  pw.Expanded(child: pw.Text(selectedOrderStatus), flex: 1),
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
                  pw.Expanded(child: pw.Text(selectedType), flex: 1),
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
      locator<SnackbarService>().showCustomSnackBar(
        variant: SnackbarType.NORMAL,
        duration: const Duration(
          seconds: 3,
        ),
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
        reportResponse: consolidatedOrdersReportResponse,
        qtyTotal: totalOfConsolidatedOrdersQty,
        amountTotal: totalOfConsolidatedOrdersAmount,
      ),
    );
  }

  pw.Table getOrdersByBrandsTable() {
    return pw.Table(
      border: getTableBorder(),
      children: getTableRows(
        reportResponse: ordersReportGroupByBrandResponse,
        qtyTotal: totalOfOrdersQtyGroupByBrand,
        amountTotal: totalOfOrdersAmountGroupByBrand,
      ),
    );
  }

  pw.Table getOrdersByCategoryTable() {
    return pw.Table(
      border: getTableBorder(),
      children: getTableRows(
        reportResponse: ordersReportGroupByTypeResponse,
        qtyTotal: totalOfOrdersQtyGroupByType,
        amountTotal: totalOfOrdersAmountGroupByType,
      ),
    );
  }

  pw.Table getOrdersBySubCategoryTable() {
    return pw.Table(
      border: getTableBorder(),
      children: getTableRows(
        reportResponse: ordersReportGroupBySubTypeResponse,
        qtyTotal: totalOfOrdersQtyGroupBySubType,
        amountTotal: totalOfOrdersAmountGroupBySubType,
      ),
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

    consolidatedOrdersReportResponse.reportResultSet?.forEach((element) {
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
                  '${(consolidatedOrdersReportResponse.reportResultSet?.indexOf(element))! + 1}',
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
