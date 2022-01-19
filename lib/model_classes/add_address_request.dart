// To parse this JSON data, do
//
//     final addNewAddressRequest = addNewAddressRequestFromMap(jsonString);

import 'dart:convert';

import 'package:scm/model_classes/address.dart';

class AddNewAddressRequest {
  AddNewAddressRequest({
    this.address,
  });

  factory AddNewAddressRequest.fromJson(String str) =>
      AddNewAddressRequest.fromMap(json.decode(str));

  factory AddNewAddressRequest.fromMap(Map<String, dynamic> json) =>
      AddNewAddressRequest(
        address:
            List<Address>.from(json["address"].map((x) => Address.fromMap(x))),
      );

  List<Address>? address;

  AddNewAddressRequest copyWith({
    List<Address>? address,
  }) =>
      AddNewAddressRequest(
        address: address ?? this.address,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "address": address != null
            ? List<dynamic>.from(address!.map((x) => x.toMap()))
            : [],
      };
}
