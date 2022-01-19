// To parse this JSON data, do
//
//     final typesCategoryStringListResponse = typesCategoryStringListResponseFromMap(jsonString);

import 'dart:convert';

class TypesCategoryStringListResponse {
  TypesCategoryStringListResponse({
    this.types,
    this.totalItems,
    this.totalPages,
    this.currentPage,
  });

  factory TypesCategoryStringListResponse.fromJson(String str) =>
      TypesCategoryStringListResponse.fromMap(json.decode(str));

  factory TypesCategoryStringListResponse.fromMap(Map<String, dynamic> json) =>
      TypesCategoryStringListResponse(
        types: List<String>.from(json["types"].map((x) => x)),
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  final int? currentPage;
  final int? totalItems;
  final int? totalPages;
  final List<String>? types;

  TypesCategoryStringListResponse copyWith({
    List<String>? types,
    int? totalItems,
    int? totalPages,
    int? currentPage,
  }) =>
      TypesCategoryStringListResponse(
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
}
