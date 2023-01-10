// To parse this JSON data, do
//
//     final lessonResponse = lessonResponseFromJson(jsonString);

import 'dart:convert';

LessonResponse lessonResponseFromJson(String str) => LessonResponse.fromJson(json.decode(str));

String lessonResponseToJson(LessonResponse data) => json.encode(data.toJson());

class LessonResponse {
  LessonResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  LessonData? data;

  factory LessonResponse.fromJson(Map<String, dynamic> json) => LessonResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: LessonData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class LessonData {
  LessonData({
    this.id,
    this.lessonTitle,
    this.lessonContents,
    this.week,
    this.comments,
    this.assessments,
    this.lessonSlug,
    this.status,
  });

  String? id;
  String? lessonTitle;
  String? lessonContents;
  Week? week;
  List<dynamic>? comments;
  List<dynamic>? assessments;
  String? lessonSlug;
  Status? status;

  factory LessonData.fromJson(Map<String, dynamic> json) {
    return LessonData(
      id: json["_id"],
      lessonTitle: json["lessonTitle"],
      lessonContents: json["lessonContents"],
      week: Week.fromJson(json["week"]),
      comments: json["comments"] ==null ? [] :  List<dynamic>.from(json["comments"].map((x) => x)),
      assessments: json["assessments"] ==null ? [] : List<dynamic>.from(json["assessments"].map((x) => x)),
      lessonSlug: json["lessonSlug"],
      status: json["status"] ==null ? null :  Status.fromJson(json["status"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "lessonTitle": lessonTitle,
    "lessonContents": lessonContents,
    "week": week?.toJson(),
    "comments": comments==null ? [] :  List<dynamic>.from(comments!.map((x) => x)),
    "assessments": assessments==null ? [] : List<dynamic>.from(assessments!.map((x) => x)),
    "lessonSlug": lessonSlug,
    "status": status== null ? null : status!.toJson(),
  };
}


class Status{
  Status({
    this.startDate,
    this.endDate,
    this.isCompleted,
  });

  String? startDate;
  String? endDate;
  bool? isCompleted;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    isCompleted: json["isCompleted"] ?? false,
    startDate: json["startDate"],
    endDate: json["endDate"],
  );

  Map<String, dynamic> toJson() => {
    "isCompleted": isCompleted ?? false,
    "startDate" : startDate,
    "endDate" : endDate
  };
}
class Week {
  Week({
    this.course,
    this.week,
  });

  Course? course;
  int? week;

  factory Week.fromJson(Map<String, dynamic> json) => Week(
    course: Course.fromJson(json["course"]),
    week: json["week"],
  );

  Map<String, dynamic> toJson() => {
    "course": course?.toJson(),
    "week": week,
  };
}

class Course {
  Course({
    this.courseTitle,
  });

  String? courseTitle;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    courseTitle: json["courseTitle"],
  );

  Map<String, dynamic> toJson() => {
    "courseTitle": courseTitle,
  };
}
