// To parse this JSON data, do
//
//     final instructorResponse = instructorResponseFromJson(jsonString);

import 'dart:convert';

import '../models/course.dart';
import 'course_detail_response.dart';

InstructorResponse instructorResponseFromJson(String str) => InstructorResponse.fromJson(json.decode(str));

String instructorResponseToJson(InstructorResponse data) => json.encode(data.toJson());

class InstructorResponse {
  InstructorResponse({
    this.status,
    this.success,
    this.data,
  });

  int? status;
  bool? success;
  InstructorData? data;

  factory InstructorResponse.fromJson(Map<String, dynamic> json) => InstructorResponse(
    status: json["status"],
    success: json["success"],
    data: InstructorData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data?.toJson(),
  };
}

class InstructorData {
  InstructorData({
    this.id,
    this.user,
    this.joinDate,
    this.isActive,
    this.isDeleted,
    this.description,
    this.courses,
    this.summary,
  });

  String? id;
  User? user;
  DateTime? joinDate;
  bool? isActive;
  bool? isDeleted;
  String? description;
  List<Course>? courses;
  Summary? summary;

  factory InstructorData.fromJson(Map<String, dynamic> json) => InstructorData(
    id: json["_id"],
    user: json["user"] == null ? null :  User.fromJson(json["user"]),
    joinDate: json["joinDate"] == null ? DateTime.now() :  DateTime.parse(json["joinDate"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    description: json["description"],
    courses: json["courses"] == null ? [] :  List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    summary: Summary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "joinDate": joinDate!.toIso8601String(),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "description": description,
    "courses": courses == null ? [] :  List<dynamic>.from(courses!.map((x) => x.toJson())),
    "summary": summary?.toJson(),
  };
}

class Summary {
  Summary({
    this.courseCount,
    this.lessonCount,
    this.learnerCount,
  });

  int? courseCount;
  int? lessonCount;
  int? learnerCount;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    courseCount: json["courseCount"],
    lessonCount: json["lessonCount"],
    learnerCount: json["learnerCount"],
  );

  Map<String, dynamic> toJson() => {
    "courseCount": courseCount,
    "lessonCount": lessonCount,
    "learnerCount": learnerCount,
  };
}

