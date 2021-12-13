// To parse this JSON data, do
//
//     final firstLevelDashboardSchema = firstLevelDashboardSchemaFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class FirstLevelDashboardSchema {
  FirstLevelDashboardSchema({
    @required this.levelOne,
    @required this.categoriesList,
    @required this.brandListKeys,
  });

  factory FirstLevelDashboardSchema.fromJson(String str) =>
      FirstLevelDashboardSchema.fromMap(json.decode(str));

  factory FirstLevelDashboardSchema.fromMap(Map<String, dynamic> json) =>
      FirstLevelDashboardSchema(
        levelOne: List<LevelOne>.from(
            json["levelOne"].map((x) => LevelOne.fromMap(x))),
        categoriesList: List<String>.from(json["categoriesList"].map((x) => x)),
        brandListKeys: List<String>.from(json["brandListKeys"].map((x) => x)),
      );

  List<String>? brandListKeys;
  List<String>? categoriesList;
  List<LevelOne>? levelOne;

  FirstLevelDashboardSchema copyWith({
    List<LevelOne>? levelOne,
    List<String>? categoriesList,
    List<String>? brandListKeys,
  }) =>
      FirstLevelDashboardSchema(
        levelOne: levelOne ?? this.levelOne,
        categoriesList: categoriesList ?? this.categoriesList,
        brandListKeys: brandListKeys ?? this.brandListKeys,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "levelOne": List<dynamic>.from(levelOne!.map((x) => x.toMap())),
        "categoriesList": List<dynamic>.from(categoriesList!.map((x) => x)),
        "brandListKeys": List<dynamic>.from(brandListKeys!.map((x) => x)),
      };
}

class LevelOne {
  LevelOne({
    @required this.productTypeKey,
    @required this.gridView,
  });

  factory LevelOne.fromJson(String str) => LevelOne.fromMap(json.decode(str));

  factory LevelOne.fromMap(Map<String, dynamic> json) => LevelOne(
        productTypeKey: json["productTypeKey"],
        gridView: List<GridView>.from(
            json["gridView"].map((x) => GridView.fromMap(x))),
      );

  List<GridView>? gridView;
  String? productTypeKey;

  LevelOne copyWith({
    String? productTypeKey,
    List<GridView>? gridView,
  }) =>
      LevelOne(
        productTypeKey: productTypeKey ?? this.productTypeKey,
        gridView: gridView ?? this.gridView,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "productTypeKey": productTypeKey,
        "gridView": List<dynamic>.from(gridView!.map((x) => x.toMap())),
      };
}

class GridView {
  GridView({
    @required this.itemTitle,
    @required this.itemImage,
    @required this.itemKey,
  });

  factory GridView.fromJson(String str) => GridView.fromMap(json.decode(str));

  factory GridView.fromMap(Map<String, dynamic> json) => GridView(
        itemTitle: json["itemTitle"],
        itemImage: json["itemImage"],
        itemKey: json["itemKey"],
      );

  String? itemImage;
  String? itemKey;
  String? itemTitle;

  GridView copyWith({
    String? itemTitle,
    String? itemImage,
    String? itemKey,
  }) =>
      GridView(
        itemTitle: itemTitle ?? this.itemTitle,
        itemImage: itemImage ?? this.itemImage,
        itemKey: itemKey ?? this.itemKey,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "itemTitle": itemTitle,
        "itemImage": itemImage,
        "itemKey": itemKey,
      };
}
