// To parse this JSON data, do
//
//     final appVersioningResponse = appVersioningResponseFromMap(jsonString);

import 'dart:convert';

class AppVersioningResponse {
  AppVersioningResponse({
    required this.appName,
    required this.title,
    required this.major,
    required this.minor,
    required this.build,
    required this.revision,
  });

  factory AppVersioningResponse.fromJson(String str) =>
      AppVersioningResponse.fromMap(json.decode(str));

  factory AppVersioningResponse.fromMap(Map<String, dynamic> json) =>
      AppVersioningResponse(
        appName: json["appName"],
        title: json["title"],
        major: json["major"],
        minor: json["minor"],
        build: json["build"],
        revision: json["revision"],
      );

  final String appName;
  final int build;
  final int major;
  final int minor;
  final int revision;
  final String title;

  AppVersioningResponse copyWith({
    String? appName,
    String? title,
    int? major,
    int? minor,
    int? build,
    int? revision,
  }) =>
      AppVersioningResponse(
        appName: appName ?? this.appName,
        title: title ?? this.title,
        major: major ?? this.major,
        minor: minor ?? this.minor,
        build: build ?? this.build,
        revision: revision ?? this.revision,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "appName": appName,
        "title": title,
        "major": major,
        "minor": minor,
        "build": build,
        "revision": revision,
      };
}
