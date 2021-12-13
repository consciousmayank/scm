// To parse this JSON data, do
//
//     final imageResponse = imageResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ImageResponse {
  ImageResponse({
    this.title,
    this.type,
    this.image,
  });

  factory ImageResponse.fromJson(String str) =>
      ImageResponse.fromMap(json.decode(str));

  factory ImageResponse.fromMap(Map<String, dynamic> json) => ImageResponse(
        title: json["title"],
        type: json["type"],
        image: json["image"],
      );

  String ?image;
  String ?title;
  String? type;

  ImageResponse copyWith({
    String ?title,
    String? type,
    String? image,
  }) =>
      ImageResponse(
        title: title ?? this.title,
        type: type ?? this.type,
        image: image ?? this.image,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "title": title,
        "type": type,
        "image": image,
      };
}
