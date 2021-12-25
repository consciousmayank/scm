// To parse this JSON data, do
//
//     final orderSummaryResponse = orderSummaryResponseFromMap(jsonString);

// import 'package:scms_demand/classmodels/supplier_list_response.dart';

// To parse this JSON data, do
//
//     final orderSummaryResponse = orderSummaryResponseFromMap(jsonString);

import 'dart:convert';

import 'package:scm/model_classes/address.dart';
import 'package:scm/model_classes/order_list_response.dart';

class OrderSummaryResponse {
  OrderSummaryResponse({
    this.id,
    this.status,
    this.totalItems,
    this.billingAddress,
    this.shippingAddress,
    this.totalAmount,
    this.orderItems,
    this.demandId,
    this.supplyId,
    this.demandBusinessName,
    this.supplyBusinessName,
    this.createDateTime,
    this.orderTracking,
  });

  factory OrderSummaryResponse.fromJson(String str) =>
      OrderSummaryResponse.fromMap(json.decode(str));

  factory OrderSummaryResponse.fromMap(Map<String, dynamic> json) =>
      OrderSummaryResponse(
        id: json["id"],
        status: json["status"],
        totalItems: json["totalItems"],
        billingAddress: json["billingAddress"] != null
            ? Address.fromMap(json["billingAddress"])
            : null,
        shippingAddress: json["shippingAddress"] != null
            ? Address.fromMap(json["shippingAddress"])
            : null,
        totalAmount: json["totalAmount"].toDouble(),
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromMap(x))),
        demandId: json["demandId"],
        supplyId: json["supplyId"],
        demandBusinessName: json["demandBusinessName"],
        supplyBusinessName: json["supplyBusinessName"],
        createDateTime: json["createDateTime"],
        orderTracking: List<OrderTracking>.from(
            json["orderTracking"].map((x) => OrderTracking.fromMap(x))),
      );

  Address? billingAddress;
  String? createDateTime;
  String? demandBusinessName;
  String? supplyBusinessName;
  int? demandId;
  int? supplyId;
  int? id;
  List<OrderItem>? orderItems;
  List<OrderTracking>? orderTracking;
  Address? shippingAddress;
  String? status;
  double? totalAmount;
  int? totalItems;

  OrderSummaryResponse copyWith({
    int? id,
    String? status,
    int? totalItems,
    Address? billingAddress,
    Address? shippingAddress,
    double? totalAmount,
    List<OrderItem>? orderItems,
    int? demandId,
    int? supplyId,
    String? demandBusinessName,
    String? supplyBusinessName,
    String? createDateTime,
    List<OrderTracking>? orderTracking,
  }) =>
      OrderSummaryResponse(
        id: id ?? this.id,
        status: status ?? this.status,
        totalItems: totalItems ?? this.totalItems,
        billingAddress: billingAddress ?? this.billingAddress,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        totalAmount: totalAmount ?? this.totalAmount,
        orderItems: orderItems ?? this.orderItems,
        demandId: demandId ?? this.demandId,
        supplyId: supplyId ?? this.supplyId,
        demandBusinessName: demandBusinessName ?? this.demandBusinessName,
        supplyBusinessName: supplyBusinessName ?? this.supplyBusinessName,
        createDateTime: createDateTime ?? this.createDateTime,
        orderTracking: orderTracking ?? this.orderTracking,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        // "status": status,
        // "totalItems": totalItems,
        // "billingAddress": billingAddress.toMap(),
        // "shippingAddress": shippingAddress.toMap(),
        // "totalAmount": totalAmount,
        "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toMap())),
        // "demandId": demandId,
        // "demandBusinessName": demandBusinessName,
        // "createDateTime": createDateTime,
        // "orderTracking": List<dynamic>.from(orderTracking.map((x) => x.toMap())),
      };

  OrderSummaryResponse empty() {
    return OrderSummaryResponse(
      id: -1,
      status: '',
      totalItems: 0,
      billingAddress: Address().empty(),
      shippingAddress: Address().empty(),
      totalAmount: 0,
      orderItems: [],
      demandId: -1,
      supplyId: -1,
      demandBusinessName: '',
      supplyBusinessName: '',
      createDateTime: '',
      orderTracking: [],
    );
  }
}

//
// class OrderItem {
//   OrderItem({
//     this.itemTotalPrice,
//     this.itemQuantity,
//     this.itemTitle,
//     this.itemId,
//     this.itemPrice,
//   });
//
//   double itemTotalPrice;
//   int itemQuantity;
//   String itemTitle;
//   int itemId;
//   int itemPrice;
//
//   OrderItem copyWith({
//     double itemTotalPrice,
//     int itemQuantity,
//     String itemTitle,
//     int itemId,
//     int itemPrice,
//   }) =>
//       OrderItem(
//         itemTotalPrice: itemTotalPrice ?? this.itemTotalPrice,
//         itemQuantity: itemQuantity ?? this.itemQuantity,
//         itemTitle: itemTitle ?? this.itemTitle,
//         itemId: itemId ?? this.itemId,
//         itemPrice: itemPrice ?? this.itemPrice,
//       );
//
//   factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
//     itemTotalPrice: json["itemTotalPrice"].toDouble(),
//     itemQuantity: json["itemQuantity"],
//     itemTitle: json["itemTitle"],
//     itemId: json["itemId"],
//     itemPrice: json["itemPrice"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "itemTotalPrice": itemTotalPrice,
//     "itemQuantity": itemQuantity,
//     "itemTitle": itemTitle,
//     "itemId": itemId,
//     "itemPrice": itemPrice,
//   };
// }

class OrderTracking {
  OrderTracking({
    this.id,
    this.status,
    this.message,
    this.creationdate,
  });

  factory OrderTracking.fromJson(String str) =>
      OrderTracking.fromMap(json.decode(str));

  factory OrderTracking.fromMap(Map<String, dynamic> json) => OrderTracking(
        id: json["id"],
        status: json["status"],
        message: json["message"],
        creationdate: json["creationdate"],
      );

  String? creationdate;
  int? id;
  String? message;
  String? status;

  OrderTracking copyWith({
    int? id,
    String? status,
    String? message,
    String? creationdate,
  }) =>
      OrderTracking(
        id: id ?? this.id,
        status: status ?? this.status,
        message: message ?? this.message,
        creationdate: creationdate ?? this.creationdate,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "message": message,
        "creationdate": creationdate,
      };
}


// import 'dart:convert';
//
// import 'package:supply/classmodels/address.dart';
// import 'package:supply/classmodels/order_list_response.dart';
//
// class OrderSummaryResponse {
//   OrderSummaryResponse({
//     this.id,
//     this.status,
//     this.demandBusinessName,
//     this.createDateTime,
//     this.billingAddress,
//     this.shippingAddress,
//     this.orderItems,
//     this.totalItems,
//     this.demandId,
//     this.totalAmount,
//   });
//
//   int? id;
//   String? status;
//   String? demandBusinessName;
//   String? createDateTime;
//   Address? billingAddress;
//   Address? shippingAddress;
//   List<OrderItem>? orderItems;
//   int? totalItems;
//   int? demandId;
//   double? totalAmount;
//
//   OrderSummaryResponse copyWith({
//     int? id,
//     String? status,
//     String? demandBusinessName,
//     String? createDateTime,
//     Address? billingAddress,
//     Address? shippingAddress,
//     List<OrderItem>? orderItems,
//     int? totalItems,
//     int? demandId,
//     double? totalAmount,
//   }) =>
//       OrderSummaryResponse(
//         id: id ?? this.id,
//         status: status ?? this.status,
//         demandBusinessName: demandBusinessName ?? this.demandBusinessName,
//         createDateTime: createDateTime ?? this.createDateTime,
//         billingAddress: billingAddress ?? this.billingAddress,
//         shippingAddress: shippingAddress ?? this.shippingAddress,
//         orderItems: orderItems ?? this.orderItems,
//         totalItems: totalItems ?? this.totalItems,
//         demandId: demandId ?? this.demandId,
//         totalAmount: totalAmount ?? this.totalAmount,
//       );
//
//   factory OrderSummaryResponse.fromJson(String str) =>
//       OrderSummaryResponse.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory OrderSummaryResponse.fromMap(Map<String, dynamic> json) =>
//       OrderSummaryResponse(
//         id: json["id"],
//         status: json["status"],
//         demandBusinessName: json["demandBusinessName"],
//         createDateTime: json["createDateTime"],
//         billingAddress: json["billingAddress"] != null
//             ? Address.fromMap(json["billingAddress"])
//             : null,
//         shippingAddress: json["shippingAddress"] != null
//             ? Address.fromMap(json["shippingAddress"])
//             : null,
//         orderItems: List<OrderItem>.from(
//             json["orderItems"].map((x) => OrderItem.fromMap(x))),
//         totalItems: json["totalItems"],
//         demandId: json["demandId"],
//         totalAmount: json["totalAmount"].toDouble(),
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         // "status": status,
//         // "demandBusinessName": demandBusinessName,
//         // "createDateTime": createDateTime,
//         // "billingAddress": billingAddress!.toMap(),
//         // "shippingAddress": shippingAddress!.toMap(),
//         "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toMap())),
//         // "totalItems": totalItems,
//         // "demandId": demandId,
//         // "totalAmount": totalAmount,
//       };
// }
