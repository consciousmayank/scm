// To parse this JSON data, do
//
//     final otpVerficationRequest = otpVerficationRequestFromMap(jsonString);

import 'dart:convert';

class OtpVerificationRequest {
  OtpVerificationRequest({
    this.username,
    this.otp,
  });

  factory OtpVerificationRequest.fromJson(String str) => OtpVerificationRequest.fromMap(json.decode(str));

  factory OtpVerificationRequest.fromMap(Map<String, dynamic> json) => OtpVerificationRequest(
    username: json["username"],
    otp: json["otp"],
  );

  String ?username;
  String? otp;

  OtpVerificationRequest copyWith({
    String? username,
    String? otp,
  }) =>
      OtpVerificationRequest(
        username: username ?? this.username,
        otp: otp ?? this.otp,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "username": username,
    "otp": otp,
  };
}
