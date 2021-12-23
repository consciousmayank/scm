// To parse this JSON data, do
//
//     final commonDashboardOrderedTypes = commonDashboardOrderedTypesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CommonDashboardOrderedTypes {
  CommonDashboardOrderedTypes({
    this.count,
    this.type,
  });

  final int? count;
  final String? type;

  CommonDashboardOrderedTypes copyWith({
    int? count,
    String? type,
  }) =>
      CommonDashboardOrderedTypes(
        count: count ?? this.count,
        type: type ?? this.type,
      );

  factory CommonDashboardOrderedTypes.fromJson(String str) =>
      CommonDashboardOrderedTypes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommonDashboardOrderedTypes.fromMap(Map<String, dynamic> json) =>
      CommonDashboardOrderedTypes(
        count: json["count"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "type": type,
      };

  CommonDashboardOrderedTypes empty() {
    return CommonDashboardOrderedTypes(
      count: 0,
      type: '',
    );
  }
}
