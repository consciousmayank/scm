// To parse this JSON data, do
//
//     final suppliersBrandsListResponse = suppliersBrandsListResponseFromMap(jsonString);

import 'dart:convert';

class SuppliersBrandsListResponse {
  SuppliersBrandsListResponse({
    this.totalItems,
    this.brands,
    this.totalPages,
    this.filters,
    this.currentPage,
  });

  final int? totalItems;
  final List<Brand>? brands;
  final int? totalPages;
  final Filters? filters;
  final int? currentPage;

  SuppliersBrandsListResponse copyWith({
    int? totalItems,
    List<Brand>? brands,
    int? totalPages,
    Filters? filters,
    int? currentPage,
  }) =>
      SuppliersBrandsListResponse(
        totalItems: totalItems ?? this.totalItems,
        brands: brands ?? this.brands,
        totalPages: totalPages ?? this.totalPages,
        filters: filters ?? this.filters,
        currentPage: currentPage ?? this.currentPage,
      );

  factory SuppliersBrandsListResponse.fromJson(String str) =>
      SuppliersBrandsListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuppliersBrandsListResponse.fromMap(Map<String, dynamic> json) =>
      SuppliersBrandsListResponse(
        totalItems: json["totalItems"],
        brands: List<Brand>.from(json["brands"].map((x) => Brand.fromMap(x))),
        totalPages: json["totalPages"],
        filters: Filters.fromMap(json["filters"]),
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toMap() => {
        "totalItems": totalItems,
        "brands": List<dynamic>.from(brands!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "filters": filters!.toMap(),
        "currentPage": currentPage,
      };

  SuppliersBrandsListResponse empty() {
    return SuppliersBrandsListResponse(
      totalItems: 0,
      brands: [],
      totalPages: 0,
      filters: Filters().empty(),
      currentPage: 0,
    );
  }
}

class Brand {
  Brand({
    this.brand,
  });

  final String? brand;

  Brand copyWith({
    String? brand,
  }) =>
      Brand(
        brand: brand ?? this.brand,
      );

  factory Brand.fromJson(String str) => Brand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
        brand: json["brand"],
      );

  Map<String, dynamic> toMap() => {
        "brand": brand,
      };
}

class Filters {
  Filters({
    this.pTitle,
    this.subType,
    this.type,
    this.title,
  });

  final String? pTitle;
  final String? subType;
  final String? type;
  final String? title;

  Filters copyWith({
    String? pTitle,
    String? subType,
    String? type,
    String? title,
  }) =>
      Filters(
        pTitle: pTitle ?? this.pTitle,
        subType: subType ?? this.subType,
        type: type ?? this.type,
        title: title ?? this.title,
      );

  factory Filters.fromJson(String str) => Filters.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Filters.fromMap(Map<String, dynamic> json) => Filters(
        pTitle: json["pTitle"],
        subType: json["subType"],
        type: json["type"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "pTitle": pTitle,
        "subType": subType,
        "type": type,
        "title": title,
      };

  Filters empty() {
    return Filters(
      pTitle: "",
      subType: "",
      type: "",
      title: "",
    );
  }
}
