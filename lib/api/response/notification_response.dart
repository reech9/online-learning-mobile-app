// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:http/http.dart';

NotificationResponse notificationResponseFromJson(String str) => NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());

class NotificationResponse {
  NotificationResponse({
    this.status,
    this.success,
    this.data,
  });

  int? status;
  bool? success;
  NotificationMap? data;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    status: json["status"],
    success: json["success"],
    data: json["data"] == null ? null :  NotificationMap.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data== null ? null : data!.toJson(),
  };
}


class NotificationMap {
  NotificationMap({
    this.notification,
    this.unRead,
  });

  List<NotificationData>? notification;
  int? unRead;

  factory NotificationMap.fromJson(Map<String, dynamic> json) => NotificationMap(
    notification: json["notification"] == null || json["notification"] == [] ? [] :   List<NotificationData>.from(json["notification"].map((x) => NotificationData.fromJson(x))),
    unRead: json["unRead"] == null ? 0 : json["unRead"],
  );

  Map<String, dynamic> toJson() => {
    "notification": notification== null ? [] :  List<dynamic>.from(notification!.map((x) => x.toJson())),
    "unRead": unRead,
  };
}


class NotificationData {
  NotificationData({
    // this.receivers,
    this.id,
    this.notificationTitle,
    this.notificationContent,
    this.is_read,
    this.url,
    this.clickAction,
    this.imageUrl,
    this.createdAt,
    this.isExternal,
    this.link,
  });
  //
  // List<UserId>? receivers;
  String? id;
  String? notificationTitle;
  String? notificationContent;
  String? url;
  int? is_read;
  bool? isExternal;
  String? link;
  String? clickAction;
  String? imageUrl;
  DateTime? createdAt;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["_id"],
    imageUrl: json["imageUrl"],
    url: json["url"],
    notificationTitle: json["notificationTitle"],
    notificationContent: json["notificationContent"],
    is_read: json["is_read"] == null ? 0 : json["is_read"],
    clickAction: json["click_action"] == null ? null : json["click_action"],
    isExternal: json["isExternal"] == null ? false : json["isExternal"],
    link: json["link"],
    createdAt: json["createdAt"] ==null ? DateTime.now() : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    // "receivers": receivers == null ? [] :  List<dynamic>.from(receivers!.map((x) => x.toJson())),
    "_id": id,
    "url": url,
    "notificationTitle": notificationTitle,
    "notificationContent": notificationContent,
    "is_read": is_read == null ? 0 :  is_read,
    "click_action": clickAction == null ? null : clickAction,
    "createdAt": createdAt == null ? DateTime.now().toIso8601String() : createdAt!.toIso8601String(),
  };
}

class UserId {
  UserId({
    this.id,
  });

  String? id;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
  };
}
