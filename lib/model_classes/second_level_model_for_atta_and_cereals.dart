// To parse this JSON data, do
//
//     final secondLevelModelForAttaAndCereals = secondLevelModelForAttaAndCerealsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class SecondLevelModelForCategories {
  SecondLevelModelForCategories({
    @required this.levelTwoGrid,
    // @required this.productTypeList,
    @required this.brandListKeys,
  });

  factory SecondLevelModelForCategories.fromJson(String str) => SecondLevelModelForCategories.fromMap(json.decode(str));

  factory SecondLevelModelForCategories.fromMap(Map<String, dynamic> json) => SecondLevelModelForCategories(
    levelTwoGrid: LevelTwoGrid.fromMap(json["levelTwoGrid"]),
    // productTypeList: List<String>.from(json["productTypeList"].map((x) => x)),
    brandListKeys: List<String>.from(json["brandListKeys"].map((x) => x)),
  );

  // List<String> ?productTypeList;
  List<String> ?brandListKeys;

  LevelTwoGrid? levelTwoGrid;

  SecondLevelModelForCategories copyWith({
    LevelTwoGrid? levelTwoGrid,
    // List<String>? productTypeList,
    List<String>? brandListKeys,
  }) =>
      SecondLevelModelForCategories(
        levelTwoGrid: levelTwoGrid ?? this.levelTwoGrid,
        // productTypeList: productTypeList ?? this.productTypeList,
        brandListKeys: brandListKeys ?? this.brandListKeys,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "levelTwoGrid": levelTwoGrid!.toMap(),
    // "productTypeList": List<dynamic>.from(productTypeList!.map((x) => x)),
    "brandListKeys": List<dynamic>.from(brandListKeys!.map((x) => x)),
  };
}

class LevelTwoGrid {
  LevelTwoGrid({
    @required this.productTypeKey,
    @required this.gridView,
  });

  factory LevelTwoGrid.fromJson(String str) => LevelTwoGrid.fromMap(json.decode(str));

  factory LevelTwoGrid.fromMap(Map<String, dynamic> json) => LevelTwoGrid(
    productTypeKey: json["productTypeKey"],
    gridView: List<GridView>.from(json["gridView"].map((x) => GridView.fromMap(x))),
  );

  String ?productTypeKey;
  List<GridView>? gridView;

  LevelTwoGrid copyWith({
    String ?productTypeKey,
    List<GridView> ?gridView,
  }) =>
      LevelTwoGrid(
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

  String ?itemImage;
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
