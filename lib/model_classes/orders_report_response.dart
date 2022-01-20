// To parse this JSON data, do
//
//     final ordersReportResponse = ordersReportResponseFromMap(jsonString);

import 'dart:convert';

class OrdersReportResponse {
  OrdersReportResponse({
    this.filters,
    this.reportResultSet,
  });

  final Filters? filters;
  final List<ReportResultSet>? reportResultSet;

  OrdersReportResponse empty() {
    return OrdersReportResponse(
      filters: Filters().empty(),
      reportResultSet: [],
    );
  }

  OrdersReportResponse copyWith({
    Filters? filters,
    List<ReportResultSet>? reportResultSet,
  }) =>
      OrdersReportResponse(
        filters: filters ?? this.filters,
        reportResultSet: reportResultSet ?? this.reportResultSet,
      );

  factory OrdersReportResponse.fromJson(String str) =>
      OrdersReportResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrdersReportResponse.fromMap(Map<String, dynamic> json) =>
      OrdersReportResponse(
        filters: Filters.fromMap(json["filters"]),
        reportResultSet: List<ReportResultSet>.from(
            json["reportResultSet"].map((x) => ReportResultSet.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "filters": filters!.toMap(),
        "reportResultSet":
            List<dynamic>.from(reportResultSet!.map((x) => x.toMap())),
      };
}

class Filters {
  Filters({
    this.dateTo,
    this.orderStatus,
    this.dateFrom,
  });

  final String? dateTo;
  final String? orderStatus;
  final String? dateFrom;

  Filters copyWith({
    String? dateTo,
    String? orderStatus,
    String? dateFrom,
  }) =>
      Filters(
        dateTo: dateTo ?? this.dateTo,
        orderStatus: orderStatus ?? this.orderStatus,
        dateFrom: dateFrom ?? this.dateFrom,
      );

  factory Filters.fromJson(String str) => Filters.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Filters.fromMap(Map<String, dynamic> json) => Filters(
        dateTo: json["dateTo"],
        orderStatus: json["orderStatus"],
        dateFrom: json["dateFrom"],
      );

  Map<String, dynamic> toMap() => {
        "dateTo": dateTo,
        "orderStatus": orderStatus,
        "dateFrom": dateFrom,
      };

  empty() {
    return Filters(
      dateTo: '',
      orderStatus: '',
      dateFrom: '',
    );
  }
}

class ReportResultSet {
  ReportResultSet({
    this.itemCode,
    this.itemTitle,
    this.itemQuantity,
    this.itemAmount,
    this.itemBrand,
    this.itemSubType,
    this.itemType,
  });

  final int? itemCode;
  final String? itemTitle, itemType, itemBrand, itemSubType;
  final int? itemQuantity;
  final int? itemAmount;

  ReportResultSet copyWith({
    int? itemCode,
    String? itemTitle,
    String? itemType,
    String? itemBrand,
    String? itemSubType,
    int? itemQuantity,
    int? itemAmount,
  }) =>
      ReportResultSet(
        itemCode: itemCode ?? this.itemCode,
        itemTitle: itemTitle ?? this.itemTitle,
        itemSubType: itemTitle ?? this.itemSubType,
        itemBrand: itemTitle ?? this.itemBrand,
        itemType: itemTitle ?? this.itemType,
        itemQuantity: itemQuantity ?? this.itemQuantity,
        itemAmount: itemAmount ?? this.itemAmount,
      );

  factory ReportResultSet.fromJson(String str) =>
      ReportResultSet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReportResultSet.fromMap(Map<String, dynamic> json) => ReportResultSet(
        itemCode: json["itemCode"],
        itemTitle: json["itemTitle"],
        itemQuantity: json["itemQuantity"],
        itemAmount: json["itemAmount"],
        itemType: json["itemType"],
        itemBrand: json["itemBrand"],
        itemSubType: json["itemSubType"],
      );

  Map<String, dynamic> toMap() => {
        "itemCode": itemCode,
        "itemTitle": itemTitle,
        "itemQuantity": itemQuantity,
        "itemAmount": itemAmount,
        "itemType": itemType,
        "itemBrand": itemBrand,
        "itemSubType": itemSubType,
      };
}
