import 'dart:convert';

class Address {
  Address({
    this.id,
    this.type,
    this.addressLine1,
    this.addressLine2,
    this.locality,
    this.nearby,
    this.city,
    this.state,
    this.country,
    this.pincode,
  });

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        id: json["id"],
        type: json["type"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        locality: json["locality"],
        nearby: json["nearby"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
      );

  String? addressLine1;
  String? addressLine2;
  String? city;
  String? country;
  int? id;
  String? locality;
  String? nearby;
  String? pincode;
  String? state;
  String? type;

  @override
  String toString() {
    return '$addressLine1, $addressLine2, $locality, $nearby, $city, $pincode, $state, $country';
  }

  Address copyWith({
    int? id,
    String? type,
    String? addressLine1,
    String? addressLine2,
    String? locality,
    String? nearby,
    String? city,
    String? state,
    String? country,
    String? pincode,
  }) =>
      Address(
        id: id,
        type: type ?? this.type,
        addressLine1: addressLine1 ?? this.addressLine1,
        addressLine2: addressLine2 ?? this.addressLine2,
        locality: locality ?? this.locality,
        nearby: nearby ?? this.nearby,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        pincode: pincode ?? this.pincode,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "locality": locality,
        "nearby": nearby,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
      };

  empty() {
    return Address(
      id: null,
      type: '',
      addressLine1: '',
      addressLine2: '',
      locality: '',
      nearby: '',
      city: '',
      state: '',
      country: '',
      pincode: '',
    );
  }
}
