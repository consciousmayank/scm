// To parse this JSON data, do
//
//     final CommonDashboardOrderedSubTypes = CommonDashboardOrderedSubTypesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CommonDashboardOrderedSubTypes {
  CommonDashboardOrderedSubTypes({
    this.count,
    this.subType,
  });

  factory CommonDashboardOrderedSubTypes.fromJson(String str) =>
      CommonDashboardOrderedSubTypes.fromMap(json.decode(str));

  factory CommonDashboardOrderedSubTypes.fromMap(Map<String, dynamic> json) =>
      CommonDashboardOrderedSubTypes(
        count: json["count"],
        subType: json["subType"],
      );

  final int? count;
  final String? subType;

  CommonDashboardOrderedSubTypes copyWith({
    int? count,
    String? subType,
  }) =>
      CommonDashboardOrderedSubTypes(
        count: count ?? this.count,
        subType: subType ?? this.subType,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "count": count,
        "subType": subType,
      };

  CommonDashboardOrderedSubTypes empty() {
    return CommonDashboardOrderedSubTypes(
      count: 0,
      subType: '',
    );
  }
}
