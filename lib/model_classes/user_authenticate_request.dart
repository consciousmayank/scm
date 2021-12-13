// To parse this JSON data, do
//
//     final userAuthenticateRequest = userAuthenticateRequestFromMap(jsonString);

import 'dart:convert';

class UserAuthenticateRequest {
  UserAuthenticateRequest({
    this.username,
    this.password,
  });

  factory UserAuthenticateRequest.fromJson(String str) => UserAuthenticateRequest.fromMap(json.decode(str));

  factory UserAuthenticateRequest.fromMap(Map<String, dynamic> json) => UserAuthenticateRequest(
    username: json["username"],
    password: json["password"],
  );

  String? password;
  String? username;

  UserAuthenticateRequest copyWith({
    String ?username,
    String? password,
  }) =>
      UserAuthenticateRequest(
        username: username ?? this.username,
        password: password ?? this.password,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "username": username,
    "password": password,
  };
}
