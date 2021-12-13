// To parse this JSON data, do
//
//     final remoteNotificationParams = remoteNotificationParamsFromMap(jsonString);

import 'dart:convert';

class RemoteNotificationParams {
  RemoteNotificationParams({
    required this.screen,
    required this.type,
    required this.title,
    required this.body,
  });

  factory RemoteNotificationParams.empty() => RemoteNotificationParams(
        screen: '',
        type: '',
        title: '',
        body: '',
      );

  factory RemoteNotificationParams.fromJson(String str) =>
      RemoteNotificationParams.fromMap(json.decode(str));

  factory RemoteNotificationParams.fromMap(Map<String, dynamic> json) =>
      RemoteNotificationParams(
        screen: json["screen"],
        type: json["type"],
        title: json["title"],
        body: json["body"],
      );

  final String? body;
  final String? screen;
  final String? title;
  final String? type;

  RemoteNotificationParams copyWith({
    String? screen,
    String? type,
    bool? isFromBackground,
    String? title,
    String? body,
  }) =>
      RemoteNotificationParams(
        screen: screen ?? this.screen,
        type: type ?? this.type,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "screen": screen,
        "type": type,
        "title": title,
        "body": body,
      };
}
