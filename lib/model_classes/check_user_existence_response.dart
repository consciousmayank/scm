// To parse this JSON data, do
//
//     final checkUserExistenceResponse = checkUserExistenceResponseFromMap(jsonString);

import 'dart:convert';

class CheckUserExistenceResponse {
  CheckUserExistenceResponse({
    this.verified,
  });

  factory CheckUserExistenceResponse.fromJson(String str) => CheckUserExistenceResponse.fromMap(json.decode(str));

  factory CheckUserExistenceResponse.fromMap(Map<String, dynamic> json) => CheckUserExistenceResponse(
    verified: json["verified"],
  );

  bool? verified;

  CheckUserExistenceResponse copyWith({
    bool ?verified,
  }) =>
      CheckUserExistenceResponse(
        verified: verified ?? this.verified,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "verified": verified,
  };
}
