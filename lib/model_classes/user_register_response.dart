// To parse this JSON data, do
//
//     final userRegisterResponse = userRegisterResponseFromMap(jsonString);

import 'dart:convert';

class UserRegisterResponse {
  UserRegisterResponse({
    this.message,
    this.otpResponse,
    this.status,
    this.username,
  });

  factory UserRegisterResponse.fromJson(String str) => UserRegisterResponse.fromMap(json.decode(str));

  factory UserRegisterResponse.fromMap(Map<String, dynamic> json) => UserRegisterResponse(
    message: json["message"],
    otpResponse: json["otpResponse"],
    status: json["status"],
    username: json["username"],
  );

  String ?username;
  String? message;
  String? otpResponse;
  bool? status;

  UserRegisterResponse copyWith({
    String? message,
    String? otpResponse,
    bool? status,
    String? username,
  }) =>
      UserRegisterResponse(
        message: message ?? this.message,
        otpResponse: otpResponse ?? this.otpResponse,
        status: status ?? this.status,
        username: username ?? this.username,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "message": message,
    "otpResponse": otpResponse,
    "status": status,
    "username": username,
  };
}
