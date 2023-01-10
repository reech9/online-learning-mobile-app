// To parse this JSON data, do
//
//     final courseResponse = courseResponseFromJson(jsonString);

import 'dart:convert';

import '../models/course.dart';

CourseResponse courseResponseFromJson(String str) =>
    CourseResponse.fromJson(json.decode(str));

String courseResponseToJson(CourseResponse data) => json.encode(data.toJson());

class CourseResponse {
  CourseResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
    this.totalData,
    this.totalPage,
  });

  int? status;
  bool? success;
  String? msg;
  List<Course>? data;
  int? totalData;
  int? totalPage;

  factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
        status: json["status"],
        success: json["success"],
        msg: json["msg"],
        data: List<Course>.from(json["data"].map((x) => Course.fromJson(x))),
        totalData: json["totalData"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalData": totalData,
        "totalPage": totalPage,
      };
}
