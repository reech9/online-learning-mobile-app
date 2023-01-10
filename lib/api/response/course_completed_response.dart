// To parse this JSON data, do
//
//     final courseCompletedResponse = courseCompletedResponseFromJson(jsonString);

import 'dart:convert';

CourseCompletedResponse courseCompletedResponseFromJson(String str) => CourseCompletedResponse.fromJson(json.decode(str));

String courseCompletedResponseToJson(CourseCompletedResponse data) => json.encode(data.toJson());

class CourseCompletedResponse {
  CourseCompletedResponse({
    this.status,
    this.success,
    this.msg,
  });

  int ?status;
  bool ?success;
  String ?msg;

  factory CourseCompletedResponse.fromJson(Map<String, dynamic> json) => CourseCompletedResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
  };
}
