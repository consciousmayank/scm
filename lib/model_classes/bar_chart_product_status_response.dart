// To parse this JSON data, do
//
//     final barChartProductsStatus = barChartProductsStatusFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class BarChartProductsStatus {
  BarChartProductsStatus({
    this.date,
    this.count,
  });

  factory BarChartProductsStatus.fromJson(String str) =>
      BarChartProductsStatus.fromMap(json.decode(str));

  factory BarChartProductsStatus.fromMap(Map<String, dynamic> json) =>
      BarChartProductsStatus(
        date: json["date"],
        count: json["count"],
      );

  final int? count;
  final String? date;

  BarChartProductsStatus copyWith({
    String? date,
    int? count,
  }) =>
      BarChartProductsStatus(
        date: date ?? this.date,
        count: count ?? this.count,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "date": date,
        "count": count,
      };
}
