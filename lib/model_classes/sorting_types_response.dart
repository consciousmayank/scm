import 'dart:convert';

class SortingTypesResponse {
  SortingTypesResponse({
    this.type,
    this.id,
    this.isSelected = false,
  });

  factory SortingTypesResponse.fromJson(String source) =>
      SortingTypesResponse.fromMap(json.decode(source));

  factory SortingTypesResponse.fromMap(Map<String, dynamic> json) =>
      SortingTypesResponse(
        type: json["type"],
        id: json["id"],
      );

  int? id;
  bool? isSelected;
  String? type;

  SortingTypesResponse copyWith({
    String? type,
    int? id,
  }) =>
      SortingTypesResponse(
        type: type ?? this.type,
        id: id ?? this.id,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "type": type,
        "id": id,
      };

  static empty() {
    return SortingTypesResponse(id: 0, type: '');
  }

  static all() {
    return SortingTypesResponse(id: -1, type: 'All');
  }
}
