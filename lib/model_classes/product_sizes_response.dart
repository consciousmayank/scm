// To parse this JSON data, do
//
//     final productSizesListResponse = productSizesListResponseFromMap(jsonString);

import 'dart:convert';

class ProductSizesListResponse {
  ProductSizesListResponse({
    this.totalItems,
    this.productSize,
    this.totalPages,
    this.currentPage,
  });

  final int? totalItems;
  final List<ProductSize>? productSize;
  final int? totalPages;
  final int? currentPage;

  ProductSizesListResponse copyWith({
    int? totalItems,
    List<ProductSize>? productSize,
    int? totalPages,
    int? currentPage,
  }) =>
      ProductSizesListResponse(
        totalItems: totalItems ?? this.totalItems,
        productSize: productSize ?? this.productSize,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
      );

  factory ProductSizesListResponse.fromJson(String str) =>
      ProductSizesListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductSizesListResponse.fromMap(Map<String, dynamic> json) =>
      ProductSizesListResponse(
        totalItems: json["totalItems"],
        productSize: List<ProductSize>.from(
            json["productSize"].map((x) => ProductSize.fromMap(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toMap() => {
        "totalItems": totalItems,
        "productSize": List<dynamic>.from(productSize!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };

  ProductSizesListResponse empty() {
    return ProductSizesListResponse(
      totalItems: 0,
      productSize: [],
      totalPages: 0,
      currentPage: 0,
    );
  }
}

class ProductSize {
  ProductSize({
    this.measurement,
    this.measurementUnit,
  });

  final double? measurement;
  final String? measurementUnit;

  ProductSize copyWith({
    double? measurement,
    String? measurementUnit,
  }) =>
      ProductSize(
        measurement: measurement ?? this.measurement,
        measurementUnit: measurementUnit ?? this.measurementUnit,
      );

  factory ProductSize.fromJson(String str) =>
      ProductSize.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductSize.fromMap(Map<String, dynamic> json) => ProductSize(
        measurement: json["measurement"].toDouble(),
        measurementUnit: json["measurementUnit"],
      );

  Map<String, dynamic> toMap() => {
        "measurement": measurement,
        "measurementUnit": measurementUnit,
      };
}
