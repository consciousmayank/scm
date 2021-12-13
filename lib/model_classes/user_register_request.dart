// To parse this JSON data, do
//
//     final userRegisterRequest = userRegisterRequestFromMap(jsonString);

import 'dart:convert';

class UserRegisterRequest {
  UserRegisterRequest({
    this.username,
    this.password,
    this.authorities,
  });

  factory UserRegisterRequest.fromJson(String str) => UserRegisterRequest.fromMap(json.decode(str));

  factory UserRegisterRequest.fromMap(Map<String, dynamic> json) => UserRegisterRequest(
    username: json["username"],
    password: json["password"],
    authorities: List<Authority>.from(json["authorities"].map((x) => Authority.fromMap(x))),
  );

  List<Authority?>? authorities;
  String? password;
  String? username;

  UserRegisterRequest copyWith({
    String? username,
    String? password,
    List<Authority>? authorities,
  }) =>
      UserRegisterRequest(
        username: username ?? this.username,
        password: password ?? this.password,
        authorities: authorities ?? this.authorities,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "username": username,
    "password": password,
    "authorities": List<dynamic>.from(authorities!.map((x) => x!.toMap())),
  };
}

class Authority {
  Authority({
    this.authority,
  });

  factory Authority.fromJson(String str) => Authority.fromMap(json.decode(str));

  factory Authority.fromMap(Map<String, dynamic> json) => Authority(
    authority: json["authority"],
  );

  String ?authority;

  Authority copyWith({
    String? authority,
  }) =>
      Authority(
        authority: authority ?? this.authority,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "authority": authority,
  };
}
