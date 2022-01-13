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

  final String expireOn;
  final String type;
  final String username;
  final String token;

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

  factory RefreshTokenResponse.fromJson(String str) =>
      RefreshTokenResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RefreshTokenResponse.fromMap(Map<String, dynamic> json) =>
      RefreshTokenResponse(
        expireOn: json["expireOn"],
        type: json["type"],
        username: json["username"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "expireOn": expireOn,
        "type": type,
        "username": username,
        "token": token,
      };
}
