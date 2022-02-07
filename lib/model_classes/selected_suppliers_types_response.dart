// To parse this JSON data, do
//
//     final suppliersTypesListResponse = suppliersTypesListResponseFromMap(jsonString);

import 'dart:convert';

class SuppliersTypesListResponse {
  SuppliersTypesListResponse({
    this.types,
    this.totalItems,
    this.totalPages,
    // this.filters,
    this.currentPage,
  });

  factory SuppliersTypesListResponse.fromJson(String str) =>
      SuppliersTypesListResponse.fromMap(json.decode(str));

  factory SuppliersTypesListResponse.fromMap(Map<String, dynamic> json) =>
      SuppliersTypesListResponse(
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        // filters: Filters.fromMap(json["filters"]),
        currentPage: json["currentPage"],
      );

  final int? currentPage;
  // final Filters? filters;
  final int? totalItems;
  final int? totalPages;
  final List<Type>? types;

  SuppliersTypesListResponse copyWith({
    List<Type>? types,
    int? totalItems,
    int? totalPages,
    Filters? filters,
    int? currentPage,
  }) =>
      SuppliersTypesListResponse(
        types: types ?? this.types,
        totalItems: totalItems ?? this.totalItems,
        totalPages: totalPages ?? this.totalPages,
        // filters: filters ?? this.filters,
        currentPage: currentPage ?? this.currentPage,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "types": List<dynamic>.from(types!.map((x) => x.toMap())),
        "totalItems": totalItems,
        "totalPages": totalPages,
        // "filters": filters!.toMap(),
        "currentPage": currentPage,
      };

  SuppliersTypesListResponse empty() {
    return SuppliersTypesListResponse(
      types: [],
      totalItems: 0,
      totalPages: 0,
      // filters: Filters().empty(),
      currentPage: 0,
    );
  }
}

class Filters {
  Filters({
    this.pTitle,
    this.subType,
    this.title,
    this.brand,
  });

  factory Filters.fromJson(String str) => Filters.fromMap(json.decode(str));

  factory Filters.fromMap(Map<String, dynamic> json) => Filters(
        pTitle: json["pTitle"],
        subType: json["subType"],
        title: json["title"],
        brand: json["brand"],
      );

  final dynamic brand;
  final dynamic pTitle;
  final dynamic subType;
  final dynamic title;

  Filters copyWith({
    dynamic pTitle,
    dynamic subType,
    dynamic title,
    dynamic brand,
  }) =>
      Filters(
        pTitle: pTitle ?? this.pTitle,
        subType: subType ?? this.subType,
        title: title ?? this.title,
        brand: brand ?? this.brand,
      );

  Filters empty() {
    return Filters(
      pTitle: '',
      subType: '',
      title: '',
      brand: '',
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "pTitle": pTitle,
        "subType": subType,
        "title": title,
        "brand": brand,
      };
}

class Type {
  Type({
    this.type,
    this.count,
  });

  factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        type: json["type"],
        count: json["count"],
      );

  final String? type;
  final int? count;

  Type empty() {
    return Type(
      type: '',
      count: 0,
    );
  }

  Type copyWith({
    String? type,
    int? count,
  }) =>
      Type(
        type: type ?? this.type,
        count: count ?? this.count,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "type": type,
      };
}
