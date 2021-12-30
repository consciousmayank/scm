// To parse this JSON data, do
//
//     final productSubCategoriesResponse = productSubCategoriesResponseFromMap(jsonString);

import 'dart:convert';

class ProductSubCategoriesResponse {
  ProductSubCategoriesResponse({
    this.totalItems,
    this.totalPages,
    this.currentPage,
    this.subtypes,
  });

  factory ProductSubCategoriesResponse.fromJson(String str) =>
      ProductSubCategoriesResponse.fromMap(json.decode(str));

  factory ProductSubCategoriesResponse.fromMap(Map<String, dynamic> json) =>
      ProductSubCategoriesResponse(
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        subtypes: json["subtypes"] != null
            ? List<String>.from(
                json["subtypes"].map(
                  (x) {
                    if (x != null)
                      return x;
                    else
                      return null;
                  },
                ),
              )
            : [],
      );

  int? currentPage;
  List<String>? subtypes;
  int? totalItems;
  int? totalPages;

  ProductSubCategoriesResponse copyWith({
    int? totalItems,
    int? totalPages,
    int? currentPage,
    List<String>? subtypes,
  }) =>
      ProductSubCategoriesResponse(
        totalItems: totalItems ?? this.totalItems,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        subtypes: subtypes ?? this.subtypes,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "totalItems": totalItems,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "subtypes": List<dynamic>.from(subtypes!.map((x) => x)),
      };

  ProductSubCategoriesResponse empty() {
    return ProductSubCategoriesResponse(
      totalItems: 0,
      totalPages: 0,
      currentPage: 0,
      subtypes: [],
    );
  }
}
