// To parse this JSON data, do
//
//     final statisticsProductsCreated = statisticsProductsCreatedFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class StatisticsProductsCreated {
  StatisticsProductsCreated({
    this.userId,
    this.productCreated,
    this.typeCount,
    this.user,
    this.authority,
    this.brandCount,
  });

  factory StatisticsProductsCreated.fromJson(String str) =>
      StatisticsProductsCreated.fromMap(json.decode(str));

  factory StatisticsProductsCreated.fromMap(Map<String, dynamic> json) =>
      StatisticsProductsCreated(
        userId: json["userId"],
        productCreated: json["productCreated"],
        typeCount: json["typeCount"],
        user: json["user"],
        authority: json["authority"],
        brandCount: json["brandCount"],
      );

  final String? authority;
  final int? brandCount;
  final int? productCreated;
  final int? typeCount;
  final String? user;
  final int? userId;

  StatisticsProductsCreated copyWith({
    int? userId,
    int? productCreated,
    int? typeCount,
    String? user,
    String? authority,
    int? brandCount,
  }) =>
      StatisticsProductsCreated(
        userId: userId ?? this.userId,
        productCreated: productCreated ?? this.productCreated,
        typeCount: typeCount ?? this.typeCount,
        user: user ?? this.user,
        authority: authority ?? this.authority,
        brandCount: brandCount ?? this.brandCount,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "productCreated": productCreated,
        "typeCount": typeCount,
        "user": user,
        "authority": authority,
        "brandCount": brandCount,
      };
}
