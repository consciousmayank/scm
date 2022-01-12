// To parse this JSON data, do
//
//     final loginReasons = loginReasonsFromMap(jsonString);

import 'dart:convert';

class LoginReasons {
  LoginReasons({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  LoginReasons copyWith({
    String? title,
    String? description,
  }) =>
      LoginReasons(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory LoginReasons.fromJson(String str) =>
      LoginReasons.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginReasons.fromMap(Map<String, dynamic> json) => LoginReasons(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
      };
}
