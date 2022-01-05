// To parse this JSON data, do
//
//     final cart = cartFromMap(jsonString);

import 'dart:convert';

class Cart {
  Cart({
    this.id,
    this.supplyId,
    this.totalItems,
    this.totalAmount,
    this.cartItems,
  });

  factory Cart.fromJson(String str) => Cart.fromMap(json.decode(str));

  factory Cart.fromMap(Map<String, dynamic> json) => Cart(
        id: json["id"],
        supplyId: json["supplyId"],
        totalItems: json["totalItems"],
        totalAmount: json["totalAmount"],
        cartItems: List<CartItem>.from(
            json["cartItems"].map((x) => CartItem.fromMap(x))),
      );

  final List<CartItem>? cartItems;
  final int? id;
  final int? supplyId;
  final int? totalAmount;
  final int? totalItems;

  Cart empty() {
    return Cart(
      id: null,
      supplyId: null,
      totalItems: 0,
      totalAmount: 0,
      cartItems: [],
    );
  }

  Cart copyWith({
    int? id,
    int? supplyId,
    int? totalItems,
    int? totalAmount,
    List<CartItem>? cartItems,
  }) =>
      Cart(
        id: id ?? this.id,
        supplyId: supplyId ?? this.supplyId,
        totalItems: totalItems ?? this.totalItems,
        totalAmount: totalAmount ?? this.totalAmount,
        cartItems: cartItems ?? this.cartItems,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "supplyId": supplyId,
        "totalItems": totalItems,
        "totalAmount": totalAmount,
        "cartItems": List<dynamic>.from(cartItems!.map((x) => x.toMap())),
      };
}

class CartItem {
  CartItem({
    this.id,
    this.itemId,
    this.itemTitle,
    this.itemPrice,
    this.itemQuantity,
    this.itemTotalPrice,
  });

  factory CartItem.fromJson(String str) => CartItem.fromMap(json.decode(str));

  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        itemId: json["itemId"],
        itemTitle: json["itemTitle"],
        itemPrice: json["itemPrice"],
        itemQuantity: json["itemQuantity"],
        itemTotalPrice: json["itemTotalPrice"],
      );

  final int? id;
  final int? itemId;
  final int? itemPrice;
  final int? itemQuantity;
  final String? itemTitle;
  final int? itemTotalPrice;

  CartItem copyWith({
    int? id,
    int? itemId,
    String? itemTitle,
    int? itemPrice,
    int? itemQuantity,
    int? itemTotalPrice,
  }) =>
      CartItem(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        itemTitle: itemTitle ?? this.itemTitle,
        itemPrice: itemPrice ?? this.itemPrice,
        itemQuantity: itemQuantity ?? this.itemQuantity,
        itemTotalPrice: itemTotalPrice ?? this.itemTotalPrice,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "itemId": itemId,
        "itemTitle": itemTitle,
        "itemPrice": itemPrice,
        "itemQuantity": itemQuantity,
        "itemTotalPrice": itemTotalPrice,
      };
}
