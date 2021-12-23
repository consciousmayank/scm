// To parse this JSON data, do
//
//     final productListResponse = productListResponseFromMap(jsonString);

import 'dart:convert';

class ProductListResponse {
  ProductListResponse({
    this.totalItems,
    this.totalPages,
    this.currentPage,
    this.filters,
    this.products,
  });

  factory ProductListResponse.fromJson(String str) =>
      ProductListResponse.fromMap(json.decode(str));

  factory ProductListResponse.fromMap(Map<String, dynamic> json) =>
      ProductListResponse(
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        filters: json["filters"] != null
            ? Filters.fromMap(json["filters"])
            : Filters.empty(),
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  int? currentPage;
  Filters? filters;
  List<Product>? products;
  int? totalItems;
  int? totalPages;

  ProductListResponse copyWith({
    int? totalItems,
    int? totalPages,
    int? currentPage,
    Filters? filters,
    List<Product>? products,
  }) =>
      ProductListResponse(
        totalItems: totalItems ?? this.totalItems,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        filters: filters ?? this.filters,
        products: products ?? this.products,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "totalItems": totalItems,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "filters": filters!.toMap(),
        "products": List<dynamic>.from(products!.map((x) => x.toMap())),
      };

  ProductListResponse empty() {
    return ProductListResponse(
      totalItems: 0,
      totalPages: 0,
      currentPage: 0,
      filters: Filters.empty(),
      products: [],
    );
  }
}

class Filters {
  Filters({
    this.subType,
    this.type,
    this.title,
    this.brand,
  });

  factory Filters.fromJson(String str) => Filters.fromMap(json.decode(str));

  factory Filters.fromMap(Map<String, dynamic> json) => Filters(
        subType: json["subType"] != null
            ? List<String>.from(json["subType"].map((x) => x))
            : [],
        type: json["type"] != null
            ? List<String>.from(json["type"].map((x) => x))
            : [],
        title: json["title"],
        brand: json["brand"] != null
            ? List<String>.from(json["brand"].map((x) => x))
            : [],
      );

  List<String>? brand;
  List<String>? subType;
  String? title;
  List<String>? type;

  Filters copyWith({
    List<String>? subType,
    List<String>? type,
    String? title,
    List<String>? brand,
  }) =>
      Filters(
        subType: subType ?? this.subType,
        type: type ?? this.type,
        title: title ?? this.title,
        brand: brand ?? this.brand,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "subType": List<dynamic>.from(subType!.map((x) => x)),
        "type": List<dynamic>.from(type!.map((x) => x)),
        "title": title,
        "brand": List<dynamic>.from(brand!.map((x) => x)),
      };

  static empty() {
    return Filters(
      subType: [],
      type: [],
      title: "",
      brand: [],
    );
  }
}

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
    this.creationdate,
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
        measurement: json["measurement"]?.toDouble(),
        measurementUnit: json["measurementUnit"],
        creationdate: json["creationdate"],
        images: json["images"] != null
            ? List<Image>.from(json["images"].map((x) => Image.fromMap(x)))
            : [],
        tags: json["tags"],
      );

  String? brand;
  String? creationdate;
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

  Product empty() => Product(
        brand: '',
        hsn: 0,
        id: 0,
        images: [],
        measurement: 0,
        measurementUnit: '',
        price: 0,
        subType: '',
        summary: '',
        tags: '',
        title: '',
        type: '',
      );
}

class Image {
  Image({
    this.id,
    this.productId,
    this.image,
  });

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["productId"],
        image: json["image"],
      );

  int? id;
  String? image;
  int? productId;

  Image copyWith({
    int? id,
    int? productId,
    String? image,
  }) =>
      Image(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        image: image ?? this.image,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "productId": productId,
        "image": image,
      };
}
