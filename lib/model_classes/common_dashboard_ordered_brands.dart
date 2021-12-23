// To parse this JSON data, do
//
//     final commonDashboardOrderedBrands = commonDashboardOrderedBrandsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CommonDashboardOrderedBrands {
  CommonDashboardOrderedBrands({
    this.count,
    this.brand,
  });

  final int? count;
  final String? brand;

  CommonDashboardOrderedBrands copyWith({
    int? count,
    String? brand,
  }) =>
      CommonDashboardOrderedBrands(
        count: count ?? this.count,
        brand: brand ?? this.brand,
      );

  factory CommonDashboardOrderedBrands.fromJson(String str) =>
      CommonDashboardOrderedBrands.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommonDashboardOrderedBrands.fromMap(Map<String, dynamic> json) =>
      CommonDashboardOrderedBrands(
        count: json["count"],
        brand: json["brand"],
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "brand": brand,
      };

  CommonDashboardOrderedBrands empty() {
    return CommonDashboardOrderedBrands(
      count: 0,
      brand: '',
    );
  }
}
