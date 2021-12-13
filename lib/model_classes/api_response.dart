import 'dart:convert';

class ApiResponse {
  ApiResponse({
    this.status = '',
    this.message = '',
    this.statusCode = 400,
  });

  factory ApiResponse.fromJson(String str) =>
      ApiResponse.fromMap(json.decode(str));

  factory ApiResponse.fromMap(Map<String, dynamic> json) => ApiResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  final String message;
  final String status;
  final int statusCode;

  ApiResponse copyWith({
    String? status,
    String? message,
    int? statusCode,
  }) =>
      ApiResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
      );

  bool isSuccessful() {
    if (statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
      };
}
