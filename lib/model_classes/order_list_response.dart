// To parse this JSON data, do
//
//     final OrderListResponse = OrderListResponseFromMap(jsonString);

import 'dart:convert';

class OrderListResponse {
  OrderListResponse({
    this.totalItems,
    this.totalPages,
    this.orders,
    this.currentPage,
  });

  factory OrderListResponse.fromJson(String str) =>
      OrderListResponse.fromMap(json.decode(str));

  factory OrderListResponse.fromMap(Map<String, dynamic> json) =>
      OrderListResponse(
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
        currentPage: json["currentPage"],
      );

  int? currentPage;
  List<Order>? orders;
  int? totalItems;
  int? totalPages;

  OrderListResponse copyWith({
    int? totalItems,
    int? totalPages,
    List<Order>? orders,
    int? currentPage,
  }) =>
      OrderListResponse(
        totalItems: totalItems ?? this.totalItems,
        totalPages: totalPages ?? this.totalPages,
        orders: orders ?? this.orders,
        currentPage: currentPage ?? this.currentPage,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "totalItems": totalItems,
        "totalPages": totalPages,
        "orders": List<dynamic>.from(orders!.map((x) => x.toMap())),
        "currentPage": currentPage,
      };

  OrderListResponse empty() {
    return OrderListResponse(
      totalItems: 0,
      totalPages: 0,
      orders: [],
      currentPage: 0,
    );
  }
}

class Order {
  Order({
    this.totalItems,
    this.orderItems,
    this.totalAmount,
    this.demandId,
    this.demandBusinessName,
    this.createDateTime,
    this.status,
    this.id,
    this.supplyBusinessName,
    this.supplyId,
  });

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        totalItems: json["totalItems"],
        supplyId: json["supplyId"],
        supplyBusinessName: json["supplyBusinessName"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromMap(x))),
        totalAmount: json["totalAmount"].toDouble(),
        demandId: json["demandId"],
        demandBusinessName: json["demandBusinessName"],
        createDateTime: json["createDateTime"],
        status: json["status"],
        id: json["id"],
      );

  String? createDateTime;
  int? demandId, supplyId;
  int? id;
  List<OrderItem>? orderItems;
  double? totalAmount;
  String? demandBusinessName, supplyBusinessName;
  String? status;
  int? totalItems;

  Order copyWith({
    int? totalItems,
    List<OrderItem>? orderItems,
    double? totalAmount,
    int? demandId,
    int? supplyId,
    String? demandBusinessName,
    String? supplyBusinessName,
    String? createDateTime,
    String? status,
    int? id,
  }) =>
      Order(
        totalItems: totalItems ?? this.totalItems,
        orderItems: orderItems ?? this.orderItems,
        totalAmount: totalAmount ?? this.totalAmount,
        demandId: demandId ?? this.demandId,
        supplyId: supplyId ?? this.supplyId,
        demandBusinessName: demandBusinessName ?? this.demandBusinessName,
        supplyBusinessName: supplyBusinessName ?? this.supplyBusinessName,
        createDateTime: createDateTime ?? this.createDateTime,
        status: status ?? this.status,
        id: id ?? this.id,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "totalItems": totalItems,
        "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toMap())),
        "totalAmount": totalAmount,
        "demandId": demandId,
        "demandBusinessName": demandBusinessName,
        "createDateTime": createDateTime,
        "status": status,
        "id": id,
      };
}

class OrderItem {
  OrderItem({
    this.itemTotalPrice,
    this.itemTitle,
    this.itemId,
    this.itemPrice,
    this.itemQuantity,
    this.edit = false,
  });

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        itemTotalPrice: json["itemTotalPrice"].toDouble(),
        itemTitle: json["itemTitle"],
        itemId: json["itemId"],
        itemPrice: json["itemPrice"].toDouble(),
        itemQuantity: json["itemQuantity"],
      );

  int? itemId;
  double? itemTotalPrice;
  bool? edit;
  double? itemPrice;
  int? itemQuantity;
  String? itemTitle;

  OrderItem copyWith({
    double? itemTotalPrice,
    String? itemTitle,
    int? itemId,
    double? itemPrice,
    int? itemQuantity,
    bool? edit,
  }) =>
      OrderItem(
        itemTotalPrice: itemTotalPrice ?? this.itemTotalPrice,
        itemTitle: itemTitle ?? this.itemTitle,
        itemId: itemId ?? this.itemId,
        itemPrice: itemPrice ?? this.itemPrice,
        itemQuantity: itemQuantity ?? this.itemQuantity,
        edit: edit ?? this.edit,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "itemTotalPrice": itemTotalPrice,
        "itemTitle": itemTitle,
        "itemId": itemId,
        "itemPrice": itemPrice,
        "itemQuantity": itemQuantity,
      };
}
