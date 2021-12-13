// To parse this JSON data, do
//
//     final supplyProfileResponse = supplyProfileResponseFromMap(jsonString);

import 'dart:convert';

import 'package:scm/model_classes/address.dart';

class SupplyProfileResponse {
  SupplyProfileResponse({
    this.address,
    this.id,
    this.image,
    this.businessName,
    this.contactPerson,
    this.mobile,
    this.fcmId,
    this.email,
    this.phone,
  });

  factory SupplyProfileResponse.fromJson(String str) =>
      SupplyProfileResponse.fromMap(json.decode(str));

  factory SupplyProfileResponse.fromMap(Map<String, dynamic> json) =>
      SupplyProfileResponse(
        address:
            List<Address>.from(json["address"].map((x) => Address.fromMap(x))),
        id: json["id"],
        image: json["image"],
        businessName: json["businessName"],
        contactPerson: json["contactPerson"],
        mobile: json["mobile"],
        fcmId: json["fcmId"],
        email: json["email"],
        phone: json["phone"],
      );

  List<Address>? address;
  String? businessName;
  String? contactPerson;
  String? email;
  String? fcmId;
  int? id;
  String? image;
  String? mobile;
  String? phone;

  SupplyProfileResponse copyWith({
    List<Address>? address,
    int? id,
    String? image,
    String? businessName,
    String? contactPerson,
    String? mobile,
    String? fcmId,
    String? email,
    String? phone,
  }) =>
      SupplyProfileResponse(
        address: address ?? this.address,
        id: id ?? this.id,
        image: image ?? this.image,
        businessName: businessName ?? this.businessName,
        contactPerson: contactPerson ?? this.contactPerson,
        mobile: mobile ?? this.mobile,
        fcmId: fcmId ?? this.fcmId,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "address": List<dynamic>.from(address!.map((x) => x.toMap())),
        "id": id,
        "image": image,
        "businessName": businessName,
        "contactPerson": contactPerson,
        "mobile": mobile,
        "fcmId": fcmId,
        "email": email,
        "phone": phone,
      };
}

// class Address {
//   Address({
//     this.id,
//     this.type,
//     this.addressLine1,
//     this.addressLine2,
//     this.locality,
//     this.nearby,
//     this.city,
//     this.state,
//     this.country,
//     this.pincode,
//   });
//
//   int id;
//   String type;
//   String addressLine1;
//   String addressLine2;
//   String locality;
//   String nearby;
//   String city;
//   String state;
//   String country;
//   String pincode;
//
//   Address copyWith({
//     int id,
//     String type,
//     String addressLine1,
//     String addressLine2,
//     String locality,
//     String nearby,
//     String city,
//     String state,
//     String country,
//     String pincode,
//   }) =>
//       Address(
//         id: id ?? this.id,
//         type: type ?? this.type,
//         addressLine1: addressLine1 ?? this.addressLine1,
//         addressLine2: addressLine2 ?? this.addressLine2,
//         locality: locality ?? this.locality,
//         nearby: nearby ?? this.nearby,
//         city: city ?? this.city,
//         state: state ?? this.state,
//         country: country ?? this.country,
//         pincode: pincode ?? this.pincode,
//       );
//
//   factory Address.fromJson(String str) => Address.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Address.fromMap(Map<String, dynamic> json) => Address(
//     id: json["id"],
//     type: json["type"],
//     addressLine1: json["addressLine1"],
//     addressLine2: json["addressLine2"],
//     locality: json["locality"],
//     nearby: json["nearby"],
//     city: json["city"],
//     state: json["state"],
//     country: json["country"],
//     pincode: json["pincode"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "type": type,
//     "addressLine1": addressLine1,
//     "addressLine2": addressLine2,
//     "locality": locality,
//     "nearby": nearby,
//     "city": city,
//     "state": state,
//     "country": country,
//     "pincode": pincode,
//   };
// }
