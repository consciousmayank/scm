// To parse this JSON data, do
//
//     final brandsStringListResponse = brandsStringListResponseFromMap(jsonString);

import 'dart:convert';

class BrandsStringListResponse {
  BrandsStringListResponse({
    this.totalItems,
    this.brands,
    this.totalPages,
    this.currentPage,
  });

  factory BrandsStringListResponse.fromJson(String str) =>
      BrandsStringListResponse.fromMap(json.decode(str));

  factory BrandsStringListResponse.fromMap(Map<String, dynamic> json) =>
      BrandsStringListResponse(
        totalItems: json["totalItems"],
        brands: List<String>.from(json["brands"].map((x) => x)),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  final List<String>? brands;
  final int? currentPage;
  final int? totalItems;
  final int? totalPages;

  BrandsStringListResponse copyWith({
    int? totalItems,
    List<String>? brands,
    int? totalPages,
    int? currentPage,
  }) =>
      BrandsStringListResponse(
        totalItems: totalItems ?? this.totalItems,
        brands: brands ?? this.brands,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "totalItems": totalItems,
        "brands": List<dynamic>.from(brands!.map((x) => x)),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}
