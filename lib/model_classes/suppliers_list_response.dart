// To parse this JSON data, do
//
//     final suppliersListResponse = suppliersListResponseFromMap(jsonString);

import 'dart:convert';

class SuppliersListResponse {
  SuppliersListResponse({
    this.totalItems,
    this.suppliers,
    this.totalPages,
    this.filters,
    this.currentPage,
  });

  factory SuppliersListResponse.fromJson(String str) =>
      SuppliersListResponse.fromMap(json.decode(str));

  factory SuppliersListResponse.fromMap(Map<String, dynamic> json) =>
      SuppliersListResponse(
        totalItems: json["totalItems"],
        suppliers: List<Supplier>.from(
            json["suppliers"].map((x) => Supplier.fromMap(x))),
        totalPages: json["totalPages"],
        filters: Filters.fromMap(json["filters"]),
        currentPage: json["currentPage"],
      );

  final int? currentPage;
  final Filters? filters;
  final List<Supplier>? suppliers;
  final int? totalItems;
  final int? totalPages;

  SuppliersListResponse copyWith({
    int? totalItems,
    int? totalPages,
    List<Supplier>? suppliers,
    Filters? filters,
    int? currentPage,
  }) =>
      SuppliersListResponse(
        totalItems: totalItems ?? this.totalItems,
        suppliers: suppliers ?? this.suppliers,
        totalPages: totalPages ?? this.totalPages,
        filters: filters ?? this.filters,
        currentPage: currentPage ?? this.currentPage,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "totalItems": totalItems,
        "suppliers": List<dynamic>.from(suppliers!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "filters": filters!.toMap(),
        "currentPage": currentPage,
      };

  empty() {
    return SuppliersListResponse(
      totalItems: 0,
      suppliers: [],
      totalPages: 0,
      filters: Filters().empty(),
      currentPage: 0,
    );
  }
}

class Filters {
  Filters({
    this.type,
    this.title,
  });

  factory Filters.fromJson(String str) => Filters.fromMap(json.decode(str));

  factory Filters.fromMap(Map<String, dynamic> json) => Filters(
        type: json["type"],
        title: json["title"],
      );

  final String? title;
  final String? type;

  Filters copyWith({
    dynamic type,
    dynamic title,
  }) =>
      Filters(
        type: type ?? this.type,
        title: title ?? this.title,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "type": type,
        "title": title,
      };

  empty() {
    return Filters(
      type: "",
      title: "",
    );
  }
}

class Supplier {
  Supplier({
    this.businessName,
    this.contactPerson,
    this.mobile,
    this.image,
    this.phone,
    this.email,
    this.fcmId,
    this.imageType,
    this.address,
    this.id,
  });

  factory Supplier.fromJson(String str) => Supplier.fromMap(json.decode(str));

  factory Supplier.fromMap(Map<String, dynamic> json) => Supplier(
        businessName: json["businessName"],
        contactPerson: json["contactPerson"],
        mobile: json["mobile"],
        image: json["image"],
        phone: json["phone"],
        email: json["email"],
        fcmId: json["fcmId"],
        imageType: json["imageType"],
        address: json["address"] == null
            ? []
            : List<Address>.from(
                json["address"].map((x) => Address.fromMap(x))),
        id: json["id"],
      );

  final List<Address>? address;
  final String? businessName;
  final String? contactPerson;
  final String? email;
  final String? fcmId;
  final int? id;
  final String? image;
  final String? imageType;
  final String? mobile;
  final String? phone;

  Supplier empty() {
    return Supplier(
      businessName: "",
      contactPerson: "",
      email: "",
      fcmId: "",
      id: 0,
      image: "",
      imageType: "",
      mobile: "",
      phone: "",
      address: [],
    );
  }

  Supplier copyWith({
    String? businessName,
    String? contactPerson,
    String? mobile,
    String? image,
    String? phone,
    String? email,
    String? fcmId,
    String? imageType,
    List<Address>? address,
    int? id,
  }) =>
      Supplier(
        businessName: businessName ?? this.businessName,
        contactPerson: contactPerson ?? this.contactPerson,
        mobile: mobile ?? this.mobile,
        image: image ?? this.image,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        fcmId: fcmId ?? this.fcmId,
        imageType: imageType ?? this.imageType,
        address: address ?? this.address,
        id: id ?? this.id,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "businessName": businessName,
        "contactPerson": contactPerson,
        "mobile": mobile,
        "image": image,
        "phone": phone,
        "email": email,
        "fcmId": fcmId,
        "imageType": imageType,
        "address": List<dynamic>.from(address!.map((x) => x.toMap())),
        "id": id,
      };

  String contactNumber() {
    if (mobile == null && phone == null) {
      return '--';
    } else if (mobile != null && phone == null) {
      return mobile!;
    } else if (mobile == null && phone != null) {
      return phone!;
    } else {
      return mobile! + ', ' + phone!;
    }
  }
}

class Address {
  Address({
    this.locality,
    this.city,
    this.pincode,
    this.state,
    this.country,
  });

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        locality: json["locality"],
        city: json["city"],
        pincode: json["pincode"],
        state: json["state"],
        country: json["country"],
      );

  final String? city;
  final String? country;
  final String? locality;
  final String? pincode;
  final String? state;

  @override
  String toString() {
    return '$locality, $city, $pincode, $state, $country';
  }

  Address copyWith({
    String? locality,
    String? city,
    String? pincode,
    String? state,
    String? country,
  }) =>
      Address(
        locality: locality ?? this.locality,
        city: city ?? this.city,
        pincode: pincode ?? this.pincode,
        state: state ?? this.state,
        country: country ?? this.country,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "locality": locality,
        "city": city,
        "pincode": pincode,
        "state": state,
        "country": country,
      };

  Address empty() {
    return Address(
      locality: "",
      city: "",
      pincode: "",
      state: "",
      country: "",
    );
  }
}
