// To parse this JSON data, do
//
//     final appVersioningRequest = appVersioningRequestFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class AppVersioningRequest {
  AppVersioningRequest({
    required this.appName,
  });

  factory AppVersioningRequest.fromJson(String str) =>
      AppVersioningRequest.fromMap(json.decode(str));

  factory AppVersioningRequest.fromMap(Map<String, dynamic> json) =>
      AppVersioningRequest(
        appName: json["appName"],
      );

  final String appName;

  AppVersioningRequest copyWith({
    String? appName,
  }) =>
      AppVersioningRequest(
        appName: appName ?? this.appName,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "appName": appName,
      };
}
