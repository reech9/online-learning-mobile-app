import 'dart:convert';

NotificationUpdateRequest notificationUpdateRequestFromJson(String str) => NotificationUpdateRequest.fromJson(json.decode(str));
String notificationUpdateRequestToJson(NotificationUpdateRequest data) => json.encode(data.toJson());

class NotificationUpdateRequest {
  NotificationUpdateRequest({
    this.id,
  });

  String? id;

  factory NotificationUpdateRequest.fromJson(Map<String, dynamic> json) => NotificationUpdateRequest(
    id: json["notification_id"],
  );

  Map<String, dynamic> toJson() => {
    "notification_id": id,
  };
}