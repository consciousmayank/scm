import 'dart:convert';

import 'package:scm/model_classes/address.dart';

class PostOrderRequest {
  PostOrderRequest({
    required this.billingAddress,
    required this.shippingAddress,
  });

  factory PostOrderRequest.fromJson(String str) =>
      PostOrderRequest.fromMap(json.decode(str));

  factory PostOrderRequest.fromMap(Map<String, dynamic> json) =>
      PostOrderRequest(
        billingAddress: Address.fromMap(json["billingAddress"]),
        shippingAddress: Address.fromMap(json["shippingAddress"]),
      );

  final Address billingAddress;
  final Address shippingAddress;

  PostOrderRequest copyWith({
    Address? billingAddress,
    Address? shippingAddress,
  }) =>
      PostOrderRequest(
        billingAddress: billingAddress ?? this.billingAddress,
        shippingAddress: shippingAddress ?? this.shippingAddress,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "billingAddress": billingAddress.toMap(),
        "shippingAddress": shippingAddress.toMap(),
      };
}
