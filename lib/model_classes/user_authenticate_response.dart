// To parse this JSON data, do
//
//     final userAuthenticateResponse = userAuthenticateResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserAuthenticateResponse {
  UserAuthenticateResponse({
    this.expireOn,
    this.type,
    this.authorities,
    this.token,
  });

  factory UserAuthenticateResponse.fromJson(String str) =>
      UserAuthenticateResponse.fromMap(json.decode(str));

  factory UserAuthenticateResponse.fromMap(Map<String, dynamic> json) =>
      UserAuthenticateResponse(
        expireOn: json["expireOn"],
        type: json["type"],
        authorities: List<String>.from(json["authorities"].map((x) => x)),
        token: json["token"],
      );

  final List<String>? authorities;
  final String? expireOn;
  final String? token;
  final String? type;

  UserAuthenticateResponse copyWith({
    String? expireOn,
    String? type,
    List<String>? authorities,
    String? token,
  }) =>
      UserAuthenticateResponse(
        expireOn: expireOn ?? this.expireOn,
        type: type ?? this.type,
        authorities: authorities ?? this.authorities,
        token: token ?? this.token,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "expireOn": expireOn,
        "type": type,
        "authorities": authorities != null
            ? List<dynamic>.from(authorities!.map((x) => x))
            : null,
        "token": token,
      };

  UserAuthenticateResponse empty() {
    return UserAuthenticateResponse(
      expireOn: null,
      type: null,
      authorities: null,
      token: null,
    );
  }
}
