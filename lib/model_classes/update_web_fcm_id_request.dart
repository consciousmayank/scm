// To parse this JSON data, do
//
//     final updateWebFcmIdRequest = updateWebFcmIdRequestFromMap(jsonString);

import 'dart:convert';

class UpdateWebFcmIdRequest {
  UpdateWebFcmIdRequest({
    required this.fcmIdW,
  });

  factory UpdateWebFcmIdRequest.fromJson(String str) =>
      UpdateWebFcmIdRequest.fromMap(json.decode(str));

  factory UpdateWebFcmIdRequest.fromMap(Map<String, dynamic> json) =>
      UpdateWebFcmIdRequest(
        fcmIdW: json["fcmIdW"],
      );

  final String fcmIdW;

  UpdateWebFcmIdRequest copyWith({
    String? fcmIdW,
  }) =>
      UpdateWebFcmIdRequest(
        fcmIdW: fcmIdW ?? this.fcmIdW,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "fcmIdW": fcmIdW,
      };
}
