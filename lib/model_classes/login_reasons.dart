// To parse this JSON data, do
//
//     final loginReasons = loginReasonsFromMap(jsonString);

import 'dart:convert';

class LoginReasons {
  LoginReasons({
    required this.title,
    required this.description,
  });

  factory LoginReasons.fromJson(String str) =>
      LoginReasons.fromMap(json.decode(str));

  factory LoginReasons.fromMap(Map<String, dynamic> json) => LoginReasons(
        title: json["title"],
        description: json["description"],
      );

  final String description;
  final String title;

  LoginReasons copyWith({
    String? title,
    String? description,
  }) =>
      LoginReasons(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
      };
}
