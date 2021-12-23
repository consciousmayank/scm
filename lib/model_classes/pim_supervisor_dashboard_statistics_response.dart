// To parse this JSON data, do
//
//     final pimSupervisorDashboardStatisticsResponse = pimSupervisorDashboardStatisticsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class PimSupervisorDashboardStatisticsResponse {
  PimSupervisorDashboardStatisticsResponse({
    this.created,
    this.published,
    this.processed,
  });

  factory PimSupervisorDashboardStatisticsResponse.fromJson(String str) =>
      PimSupervisorDashboardStatisticsResponse.fromMap(json.decode(str));

  factory PimSupervisorDashboardStatisticsResponse.fromMap(
          Map<String, dynamic> json) =>
      PimSupervisorDashboardStatisticsResponse(
        created: Created.fromMap(json["CREATED"]),
        published: Created.fromMap(json["PUBLISHED"]),
        processed: Created.fromMap(json["PROCESSED"]),
      );

  final Created? created;
  final Created? processed;
  final Created? published;

  PimSupervisorDashboardStatisticsResponse copyWith({
    Created? created,
    Created? published,
    Created? processed,
  }) =>
      PimSupervisorDashboardStatisticsResponse(
        created: created ?? this.created,
        published: published ?? this.published,
        processed: processed ?? this.processed,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "CREATED": created != null ? created!.toMap() : null,
        "PUBLISHED": created != null ? published!.toMap() : null,
        "PROCESSED": created != null ? processed!.toMap() : null,
      };

  static PimSupervisorDashboardStatisticsResponse empty() {
    return PimSupervisorDashboardStatisticsResponse(
      created: Created.empty(),
      published: Created.empty(),
      processed: Created.empty(),
    );
  }
}

class Created {
  Created({
    this.types,
    this.brands,
    this.products,
  });

  factory Created.fromJson(String str) => Created.fromMap(json.decode(str));

  factory Created.fromMap(Map<String, dynamic> json) => Created(
        types: json["types"],
        brands: json["brands"],
        products: json["products"],
      );

  final int? brands;
  final int? products;
  final int? types;

  Created copyWith({
    int? types,
    int? brands,
    int? products,
  }) =>
      Created(
        types: types ?? this.types,
        brands: brands ?? this.brands,
        products: products ?? this.products,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "types": types,
        "brands": brands,
        "products": products,
      };

  static empty() {
    return Created(
      types: 0,
      brands: 0,
      products: 0,
    );
  }
}
