// To parse this JSON data, do
//
//     final SuppliersSubTypesListResponse = SuppliersSubTypesListResponseFromMap(jsonString);

import 'dart:convert';

class SuppliersSubTypesListResponse {
  SuppliersSubTypesListResponse({
    this.subTypes,
    this.totalItems,
    this.totalPages,
    this.filters,
    this.currentPage,
  });

  factory SuppliersSubTypesListResponse.fromJson(String str) =>
      SuppliersSubTypesListResponse.fromMap(json.decode(str));

  factory SuppliersSubTypesListResponse.fromMap(Map<String, dynamic> json) =>
      SuppliersSubTypesListResponse(
        subTypes:
            List<SubType>.from(json["subTypes"].map((x) => SubType.fromMap(x))),
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        filters: Filters.fromMap(json["filters"]),
        currentPage: json["currentPage"],
      );

  final int? currentPage;
  final Filters? filters;
  final List<SubType>? subTypes;
  final int? totalItems;
  final int? totalPages;

  SuppliersSubTypesListResponse copyWith({
    List<SubType>? subTypes,
    int? totalItems,
    int? totalPages,
    Filters? filters,
    int? currentPage,
  }) =>
      SuppliersSubTypesListResponse(
        subTypes: subTypes ?? this.subTypes,
        totalItems: totalItems ?? this.totalItems,
        totalPages: totalPages ?? this.totalPages,
        filters: filters ?? this.filters,
        currentPage: currentPage ?? this.currentPage,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "subTypes": List<dynamic>.from(subTypes!.map((x) => x.toMap())),
        "totalItems": totalItems,
        "totalPages": totalPages,
        "filters": filters!.toMap(),
        "currentPage": currentPage,
      };

  SuppliersSubTypesListResponse empty() {
    return SuppliersSubTypesListResponse(
      subTypes: [],
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

class SubType {
  SubType({
    this.subType,
  });

  factory SubType.fromJson(String str) => SubType.fromMap(json.decode(str));

  factory SubType.fromMap(Map<String, dynamic> json) => SubType(
        subType: json["subType"],
      );

  final String? subType;

  SubType empty() {
    return SubType(
      subType: '',
    );
  }

  SubType copyWith({
    String? subType,
  }) =>
      SubType(
        subType: subType ?? this.subType,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "subType": subType,
      };
}
