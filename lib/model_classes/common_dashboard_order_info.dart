// To parse this JSON data, do
//
//     final commonDashboardOrderInfo = commonDashboardOrderInfoFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CommonDashboardOrderInfo {
  CommonDashboardOrderInfo({
    this.cancelled,
    this.all,
    this.created,
    this.delivered,
    this.processing,
    this.intransit,
  });

  factory CommonDashboardOrderInfo.fromJson(String str) =>
      CommonDashboardOrderInfo.fromMap(json.decode(str));

  factory CommonDashboardOrderInfo.fromMap(Map<String, dynamic> json) =>
      CommonDashboardOrderInfo(
        cancelled: json["CANCELLED"],
        all: json["ALL"],
        created: json["CREATED"],
        delivered: json["DELIVERED"],
        processing: json["PROCESSING"],
        intransit: json["INTRANSIT"],
      );

  final int? all;
  final int? cancelled;
  final int? created;
  final int? delivered;
  final int? intransit;
  final int? processing;

  CommonDashboardOrderInfo copyWith({
    int? cancelled,
    int? all,
    int? created,
    int? delivered,
    int? processing,
    int? intransit,
  }) =>
      CommonDashboardOrderInfo(
        cancelled: cancelled ?? this.cancelled,
        all: all ?? this.all,
        created: created ?? this.created,
        delivered: delivered ?? this.delivered,
        processing: processing ?? this.processing,
        intransit: intransit ?? this.intransit,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "CANCELLED": cancelled,
        "ALL": all,
        "CREATED": created,
        "DELIVERED": delivered,
        "PROCESSING": processing,
        "INTRANSIT": intransit,
      };

  CommonDashboardOrderInfo empty() {
    return CommonDashboardOrderInfo(
      cancelled: 0,
      all: 0,
      created: 0,
      delivered: 0,
      processing: 0,
      intransit: 0,
    );
  }
}
