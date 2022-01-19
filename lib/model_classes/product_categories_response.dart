// To parse this JSON data, do
//
//     final productCategoriesResponse = productCategoriesResponseFromMap(jsonString);

import 'dart:convert';

class ProductCategoriesResponse {
  ProductCategoriesResponse({
    this.types,
    this.totalItems,
    this.totalPages,
    this.currentPage,
  });

  factory ProductCategoriesResponse.fromJson(String str) =>
      ProductCategoriesResponse.fromMap(json.decode(str));

  factory ProductCategoriesResponse.fromMap(Map<String, dynamic> json) =>
      ProductCategoriesResponse(
        types: List<String>.from(json["types"].map((x) => x)),
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  int? totalItems;
  int? currentPage;
  int? totalPages;
  List<String>? types;

  ProductCategoriesResponse copyWith({
    List<String>? types,
    int? totalItems,
    int? totalPages,
    int? currentPage,
  }) =>
      ProductCategoriesResponse(
        types: types ?? this.types,
        totalItems: totalItems ?? this.totalItems,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "types": List<dynamic>.from(types!.map((x) => x)),
        "totalItems": totalItems,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };

  ProductCategoriesResponse? empty() {
    return ProductCategoriesResponse(
      types: [],
      totalItems: 0,
      totalPages: 0,
      currentPage: 0,
    );
  }
}
