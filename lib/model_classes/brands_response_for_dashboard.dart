// To parse this JSON data, do
//
//     final AllBrandsResponse = AllBrandsResponseFromMap(jsonString);

import 'dart:convert';

class AllBrandsResponse {
  AllBrandsResponse({
    this.totalItems,
    this.brands,
    this.totalPages,
    this.currentPage,
  });

  factory AllBrandsResponse.fromJson(String str) =>
      AllBrandsResponse.fromMap(json.decode(str));

  factory AllBrandsResponse.fromMap(Map<String, dynamic> json) =>
      AllBrandsResponse(
        totalItems: json["totalItems"],
        brands: List<Brand>.from(json["brands"].map((x) => Brand.fromMap(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  List<Brand>? brands;
  int? currentPage;
  int? totalItems;
  int? totalPages;

  AllBrandsResponse copyWith({
    int? totalItems,
    List<Brand>? brands,
    int? totalPages,
    int? currentPage,
  }) =>
      AllBrandsResponse(
        totalItems: totalItems ?? this.totalItems,
        brands: brands ?? this.brands,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "totalItems": totalItems,
        "brands": List<dynamic>.from(brands!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };

  AllBrandsResponse empty() {
    return AllBrandsResponse(
      totalItems: 0,
      brands: [],
      totalPages: 0,
      currentPage: 0,
    );
  }
}

class Brand {
  Brand({
    this.id,
    this.title,
    this.image,
  });

  factory Brand.fromJson(String str) => Brand.fromMap(json.decode(str));

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );

  int? id;
  String? image;
  String? title;

  Brand copyWith({
    int? id,
    String? title,
    String? image,
  }) =>
      Brand(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "image": image,
      };
}
