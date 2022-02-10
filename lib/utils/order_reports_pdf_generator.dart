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

  final DateTimeRange dateTimeRange;
  final OrdersReportResponse consolidatedOrdersReportResponse,
      ordersReportGroupByTypeResponse,
      ordersReportGroupBySubTypeResponse,
      ordersReportGroupByBrandResponse;

  final pdf = pw.Document();
  final AppPreferencesService preferences = locator<AppPreferencesService>();
  final String appName, selectedOrderStatus, selectedBrand, selectedType;
  final double totalOfOrdersAmountGroupBySubType,
      totalOfOrdersAmountGroupByType,
      totalOfOrdersAmountGroupByBrand,
      totalOfConsolidatedOrdersAmount;

  final int totalOfOrdersQtyGroupBySubType,
      totalOfOrdersQtyGroupByType,
      totalOfOrdersQtyGroupByBrand,
      totalOfConsolidatedOrdersQty;

  void writeOnPdf() async {
    pdf.addPage(
      pw.MultiPage(
        header: (context) => pw.Container(
          alignment: pw.Alignment.centerLeft,
          width: double.infinity,
          margin: const pw.EdgeInsets.only(
            top: 2,
            bottom: 16,
          ),
          padding: const pw.EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                'Business Name : ${preferences.getSupplierDemandProfile()?.businessName!}',
                // '${context.pageNumber}/${context.pagesCount}',
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.black,
                ),
              ),
              if (preferences.getSupplierDemandProfile()!.address!.isNotEmpty)
                pw.RichText(
                  textAlign: pw.TextAlign.center,
                  text: pw.TextSpan(
                    text: 'Address : ',
                    style: const pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 10,
                    ),
                    children: <pw.TextSpan>[
                      if (preferences
                              .getSupplierDemandProfile()!
                              .address!
                              .first
                              .addressLine1 !=
                          null)
                        pw.TextSpan(
                          text:
                              '${preferences.getSupplierDemandProfile()!.address!.first.addressLine1}, ',
                          style: const pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: 10,
                          ),
                        ),
                      if (preferences
                              .getSupplierDemandProfile()!
                              .address!
                              .first
                              .addressLine2 !=
                          null)
                        pw.TextSpan(
                          text:
                              '${preferences.getSupplierDemandProfile()!.address!.first.addressLine2}, ',
                          style: const pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: 10,
                          ),
                        ),
                      if (preferences
                              .getSupplierDemandProfile()!
                              .address!
                              .first
                              .locality !=
                          null)
                        pw.TextSpan(
                          text:
                              '${preferences.getSupplierDemandProfile()!.address!.first.locality}, ',
                          style: const pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: 10,
                          ),
                        ),
                      if (preferences
                              .getSupplierDemandProfile()!
                              .address!
                              .first
                              .nearby !=
                          null)
                        pw.TextSpan(
                          text:
                              '${preferences.getSupplierDemandProfile()!.address!.first.nearby}, ',
                          style: const pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: 10,
                          ),
                        ),
                      if (preferences
                              .getSupplierDemandProfile()!
                              .address!
                              .first
                              .city !=
                          null)
                        pw.TextSpan(
                          text:
                              '${preferences.getSupplierDemandProfile()!.address!.first.city}, ',
                          style: const pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: 10,
                          ),
                        ),
                      if (preferences
                              .getSupplierDemandProfile()!
                              .address!
                              .first
                              .pincode !=
                          null)
                        pw.TextSpan(
                          text:
                              '${preferences.getSupplierDemandProfile()!.address!.first.pincode}, ',
                          style: const pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: 10,
                          ),
                        ),
                      if (preferences
                              .getSupplierDemandProfile()!
                              .address!
                              .first
                              .state !=
                          null)
                        pw.TextSpan(
                          text:
                              '${preferences.getSupplierDemandProfile()!.address!.first.state}, ',
                          style: const pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: 10,
                          ),
                        ),
                      if (preferences
                              .getSupplierDemandProfile()!
                              .address!
                              .first
                              .country !=
                          null)
                        pw.TextSpan(
                          text:
                              '${preferences.getSupplierDemandProfile()!.address!.first.country},',
                          style: const pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: 10,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
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
            border: pw.Border(
              top: pw.BorderSide(
                width: 0.1,
                color: PdfColors.blue,
              ),
            ),
          ),
          child: pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'Page ${context.pageNumber}/${context.pagesCount}',
                    // '${context.pageNumber}/${context.pagesCount}',
                    style: const pw.TextStyle(
                      fontSize: 15,
                      color: PdfColors.black,
                    ),
                  )
                ]),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.RichText(
                  textAlign: pw.TextAlign.center,
                  text: const pw.TextSpan(
                    text: 'MYSUPPLYMARKET',
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 12,
                    ),
                    children: <pw.TextSpan>[
                      pw.TextSpan(
                        text: ' BY GEEKTECHNOTONIC PVT LTD',
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(
          16,
        ),
        build: (context) {
          return <pw.Widget>[
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              mainAxisSize: pw.MainAxisSize.max,
              children: <pw.Widget>[
                pw.Text(
                  '$selectedOrderStatus Report'.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.normal,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Text(
                  '${DateTimeToStringConverter.ddMMMMyyyy(date: dateTimeRange.start).convert()} to ${DateTimeToStringConverter.ddMMMMyyyy(date: dateTimeRange.end).convert()}',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.normal,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Container(
                  width: double.infinity,
                  child:
                      pw.Text('Total Quantity : $totalOfConsolidatedOrdersQty'),
                ),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Container(
                  width: double.infinity,
                  child: pw.Text(
                      'Total Amount : $totalOfConsolidatedOrdersAmount'),
                ),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Container(
                  width: double.infinity,
                  child: pw.Text('Brand : $selectedBrand'),
                ),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Container(
                  width: double.infinity,
                  child: pw.Text('Category : $selectedType'),
                ),
              ],
            ),
            pw.SizedBox(
              height: 16,
            ),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'Items'.toUpperCase(),
                style: const pw.TextStyle(
                  fontSize: 18,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            getConsolidatedOrdersTable(),
            pw.SizedBox(height: 32),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'Brands'.toUpperCase(),
                style: const pw.TextStyle(
                  fontSize: 18,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            getOrdersByBrandsTable(),
            pw.SizedBox(height: 32),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'Category'.toUpperCase(),
                style: const pw.TextStyle(
                  fontSize: 18,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            getOrdersByCategoryTable(),
            pw.SizedBox(height: 32),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'SubCategory'.toUpperCase(),
                style: const pw.TextStyle(
                  fontSize: 18,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
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
