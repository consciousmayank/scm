// To parse this JSON data, do
//
//     final productBrandsResponse = productBrandsResponseFromMap(jsonString);

import 'dart:convert';

import 'package:scm/model_classes/selected_suppliers_brands_response.dart';

class ProductBrandsResponse {
  ProductBrandsResponse({
    this.totalItems,
    this.brands,
    this.totalPages,
    this.currentPage,
  });

  List<Brand>? brands;
  int? currentPage;
  int? totalItems;
  int? totalPages;

  ProductBrandsResponse copyWith({
    int? totalItems,
    List<Brand>? brands,
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
