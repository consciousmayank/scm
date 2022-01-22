// To parse this JSON data, do
//
//     final refreshTokenResponse = refreshTokenResponseFromMap(jsonString);

import 'dart:convert';

class RefreshTokenResponse {
  RefreshTokenResponse({
    required this.expireOn,
    required this.type,
    required this.username,
    required this.token,
  });

  factory RefreshTokenResponse.fromJson(String str) =>
      RefreshTokenResponse.fromMap(json.decode(str));

  factory RefreshTokenResponse.fromMap(Map<String, dynamic> json) =>
      RefreshTokenResponse(
        expireOn: json["expireOn"],
        type: json["type"],
        username: json["username"],
        token: json["token"],
      );

  final String expireOn;
  final String token;
  final String type;
  final String username;

  RefreshTokenResponse copyWith({
    String? expireOn,
    String? type,
    String? username,
    String? token,
  }) =>
      RefreshTokenResponse(
        expireOn: expireOn ?? this.expireOn,
        type: type ?? this.type,
        username: username ?? this.username,
        token: token ?? this.token,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "expireOn": expireOn,
        "type": type,
        "username": username,
        "token": token,
      };
}
