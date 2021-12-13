// To parse this JSON data, do
//
//     final productBrandsResponse = productBrandsResponseFromMap(jsonString);

import 'dart:convert';

class ProductBrandsResponse {
  ProductBrandsResponse({
    this.totalItems,
    this.brands,
    this.totalPages,
    this.currentPage,
  });

  factory ProductBrandsResponse.fromJson(String str) =>
      ProductBrandsResponse.fromMap(json.decode(str));

  factory ProductBrandsResponse.fromMap(Map<String, dynamic> json) =>
      ProductBrandsResponse(
        totalItems: json["totalItems"],
        brands: List<String>.from(json["brands"].map((x) => x)),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  List<String>? brands;
  int? currentPage;
  int? totalItems;
  int? totalPages;

  ProductBrandsResponse copyWith({
    int? totalItems,
    List<String>? brands,
    int? totalPages,
    int? currentPage,
  }) =>
      ProductBrandsResponse(
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
