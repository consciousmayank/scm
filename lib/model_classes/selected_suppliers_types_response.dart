// To parse this JSON data, do
//
//     final suppliersTypesListResponse = suppliersTypesListResponseFromMap(jsonString);

import 'dart:convert';

class SuppliersTypesListResponse {
  SuppliersTypesListResponse({
    this.types,
    this.totalItems,
    this.totalPages,
    this.filters,
    this.currentPage,
  });

  final List<Type>? types;
  final int? totalItems;
  final int? totalPages;
  final Filters? filters;
  final int? currentPage;

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
        filters: filters ?? this.filters,
        currentPage: currentPage ?? this.currentPage,
      );

  factory SuppliersTypesListResponse.fromJson(String str) =>
      SuppliersTypesListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuppliersTypesListResponse.fromMap(Map<String, dynamic> json) =>
      SuppliersTypesListResponse(
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        filters: Filters.fromMap(json["filters"]),
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toMap() => {
        "types": List<dynamic>.from(types!.map((x) => x.toMap())),
        "totalItems": totalItems,
        "totalPages": totalPages,
        "filters": filters!.toMap(),
        "currentPage": currentPage,
      };

  SuppliersTypesListResponse empty() {
    return SuppliersTypesListResponse(
      types: [],
      totalItems: 0,
      totalPages: 0,
      filters: Filters().empty(),
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

  final dynamic pTitle;
  final dynamic subType;
  final dynamic title;
  final dynamic brand;

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

  factory Filters.fromJson(String str) => Filters.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Filters.fromMap(Map<String, dynamic> json) => Filters(
        pTitle: json["pTitle"],
        subType: json["subType"],
        title: json["title"],
        brand: json["brand"],
      );

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
  });

  final String? type;

  Type empty() {
    return Type(
      type: '',
    );
  }

  Type copyWith({
    String? type,
  }) =>
      Type(
        type: type ?? this.type,
      );

  factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
      };
}
