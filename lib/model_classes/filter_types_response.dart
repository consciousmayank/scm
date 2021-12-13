// To parse this JSON data, do
//
//     final filterTypesResponse = filterTypesResponseFromMap(jsonString);

import 'dart:convert';

class FilterTypesResponse {
  FilterTypesResponse({
    this.brand,
    this.category,
    this.subCategory,
  });

  factory FilterTypesResponse.fromJson(String str) =>
      FilterTypesResponse.fromMap(json.decode(str));

  factory FilterTypesResponse.fromMap(Map<String, dynamic> json) =>
      FilterTypesResponse(
        brand: json["brand"] == null
            ? null
            : List<String>.from(json["brand"].map((x) => x)),
        category: json["category"] == null
            ? null
            : List<String>.from(json["category"].map((x) => x)),
        subCategory: json["subCategory"] == null
            ? null
            : List<String>.from(json["subCategory"].map((x) => x)),
      );

  List<String>? brand;
  List<String>? category;
  List<String>? subCategory;

  FilterTypesResponse copyWith({
    List<String>? brand,
    List<String>? category,
    List<String>? subCategory,
  }) =>
      FilterTypesResponse(
        brand: brand ?? this.brand,
        category: category ?? this.category,
        subCategory: subCategory ?? this.subCategory,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "brand":
            brand == null ? null : List<dynamic>.from(brand!.map((x) => x)),
        "category": category == null
            ? null
            : List<dynamic>.from(category!.map((x) => x)),
        "subCategory": subCategory == null
            ? null
            : List<dynamic>.from(subCategory!.map((x) => x)),
      };
}
