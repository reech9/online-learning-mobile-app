// To parse this JSON data, do
//
//     final achievementCourseResponse = achievementCourseResponseFromJson(jsonString);

import 'dart:convert';

AchievementCourseResponse achievementCourseResponseFromJson(String str) =>
    AchievementCourseResponse.fromJson(json.decode(str));

String achievementCourseResponseToJson(AchievementCourseResponse data) =>
    json.encode(data.toJson());

class AchievementCourseResponse {
  AchievementCourseResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  dynamic data;

  factory AchievementCourseResponse.fromJson(Map<String, dynamic> json) =>
      AchievementCourseResponse(
        status: json["status"],
        success: json["success"],
        msg: json["msg"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "msg": msg,
        "data": data == null ? null : data,
      };
}
