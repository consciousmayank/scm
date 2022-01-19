import 'dart:convert';

class RemoteNotificationParams {
  RemoteNotificationParams({
    required this.screen,
    required this.type,
    required this.id,
    required this.title,
    required this.body,
  });

  factory RemoteNotificationParams.fromJson(String str) =>
      RemoteNotificationParams.fromMap(json.decode(str));

  factory RemoteNotificationParams.fromMap(Map<String, dynamic> json) =>
      RemoteNotificationParams(
        screen: json["screen"],
        type: json["type"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  final String body;
  final String id;
  final String screen;
  final String title;
  final String type;

  RemoteNotificationParams copyWith({
    String? screen,
    String? type,
    bool? isFromBackground,
    String? title,
    String? body,
    String? id,
  }) =>
      RemoteNotificationParams(
        screen: screen ?? this.screen,
        type: type ?? this.type,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "screen": screen,
        "type": type,
        "id": id,
        "title": title,
        "body": body,
      };

  static RemoteNotificationParams empty() {
    return RemoteNotificationParams(
      screen: '',
      type: '',
      id: '',
      title: '',
      body: '',
    );
  }
}
