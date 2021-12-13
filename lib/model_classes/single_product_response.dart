import 'dart:convert';

import 'package:scm/model_classes/product_list_response.dart';

class Product {
  Product({
    this.id,
    this.hsn,
    this.brand,
    this.type,
    this.subType,
    this.title,
    this.price,
    this.summary,
    this.measurement,
    this.measurementUnit,
    this.images,
    this.tags,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        hsn: json["hsn"],
        brand: json["brand"],
        type: json["type"],
        subType: json["subType"],
        title: json["title"],
        price: json["price"].toDouble(),
        summary: json["summary"],
        measurement: json["measurement"].toDouble(),
        measurementUnit: json["measurementUnit"],
        images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
        tags: json["tags"],
      );

  String? brand;
  int? hsn;
  int? id;
  List<Image>? images;
  double? measurement;
  String? measurementUnit;
  double? price;
  String? subType;
  String? summary;
  String? tags;
  String? title;
  String? type;

  Product copyWith({
    int? id,
    int? hsn,
    String? brand,
    String? type,
    String? subType,
    String? title,
    double? price,
    String? summary,
    double? measurement,
    String? measurementUnit,
    List<Image>? images,
    String? tags,
  }) =>
      Product(
        id: id ?? this.id,
        hsn: hsn ?? this.hsn,
        brand: brand ?? this.brand,
        type: type ?? this.type,
        subType: subType ?? this.subType,
        title: title ?? this.title,
        price: price ?? this.price,
        summary: summary ?? this.summary,
        measurement: measurement ?? this.measurement,
        measurementUnit: measurementUnit ?? this.measurementUnit,
        images: images ?? this.images,
        tags: tags ?? this.tags,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "hsn": hsn,
        "brand": brand,
        "type": type,
        "subType": subType,
        "title": title,
        "price": price,
        "summary": summary,
        "measurement": measurement,
        "measurementUnit": measurementUnit,
        "images": List<dynamic>.from(images!.map((x) => x.toMap())),
        "tags": tags,
      };
}
