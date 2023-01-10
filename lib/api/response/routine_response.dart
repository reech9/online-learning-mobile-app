
import 'dart:convert';

RoutineResponse routineResponseFromJson(String str) => RoutineResponse.fromJson(json.decode(str));

String routineResponseToJson(RoutineResponse data) => json.encode(data.toJson());

class RoutineResponse {
  RoutineResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  List<RoutineData>? data;

  factory RoutineResponse.fromJson(Map<String, dynamic> json) => RoutineResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: json["data"] ==null ? [] :   List<RoutineData>.from(json["data"].map((x) => RoutineData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RoutineData {
  RoutineData({
    this.id,
    this.title,
    this.content,
    this.course,
    this.classLink,
    this.start,
    this.end,
    this.isActive,
    this.isDeleted,
    this.isWeekly,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? title;
  String? content;
  Course? course;
  String? classLink;
  DateTime? start;
  DateTime? end;
  bool? isActive;
  bool? isDeleted;
  bool? isWeekly;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory RoutineData.fromJson(Map<String, dynamic> json) => RoutineData(
    id: json["_id"],
    title: json["title"],
    content: json["content"],
    course: Course.fromJson(json["course"]),
    classLink: json["classLink"],
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    isWeekly: json["isWeekly"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "content": content,
    "course": course?.toJson(),
    "classLink": classLink,
    "start": start!.toIso8601String(),
    "end": end!.toIso8601String(),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "isWeekly": isWeekly,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class Course {
  Course({
    this.id,
    this.courseTitle,
    this.courseDesc,
    this.duration,
    this.courseSlug,
  });

  String? id;
  String? courseTitle;
  String? courseDesc;
  int? duration;
  String? courseSlug;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["_id"],
    courseTitle: json["courseTitle"],
    courseDesc: json["courseDesc"],
    duration: json["duration"],
    courseSlug: json["courseSlug"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "courseTitle": courseTitle,
    "courseDesc": courseDesc,
    "duration": duration,
    "courseSlug": courseSlug,
  };
}
