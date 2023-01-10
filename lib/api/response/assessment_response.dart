// To parse this JSON data, do
//
//     final assessmentResponse = assessmentResponseFromJson(jsonString);

import 'dart:convert';

AssessmentResponse assessmentResponseFromJson(String str) => AssessmentResponse.fromJson(json.decode(str));

String assessmentResponseToJson(AssessmentResponse data) => json.encode(data.toJson());

class AssessmentResponse {
  AssessmentResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  List<AssessmentData>? data;

  factory AssessmentResponse.fromJson(Map<String, dynamic> json) => AssessmentResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null :  List<AssessmentData>.from(json["data"].map((x) => AssessmentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data ==null ? [] :  List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AssessmentData {
  AssessmentData({
    this.id,
    this.contents,
    this.submission,
    this.dueDate,
    this.lesson,
    this.createdAt,
  });

  String? id;
  String? contents;
  List<Submission>? submission;
  DateTime? dueDate;
  Lesson? lesson;
  DateTime? createdAt;

  factory AssessmentData.fromJson(Map<String, dynamic> json) => AssessmentData(
    id: json["_id"],
    contents: json["contents"],
    submission: json["submission"] ==null ? [] :  List<Submission>.from(json["submission"].map((x) => Submission.fromJson(x))),
    dueDate: json["dueDate"] == null ? null :  DateTime.parse(json["dueDate"]),
    lesson: json["lesson"] ==null ? null :  Lesson.fromJson(json["lesson"]),
    createdAt: json["createdAt"] ==null ? null :  DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "contents": contents,
    "submission": submission == null ? null :  List<dynamic>.from(submission!.map((x) => x.toJson())),
    "dueDate": dueDate  == null ? null :  dueDate!.toIso8601String(),
    "lesson": lesson == null ? null :  lesson!.toJson(),
    "createdAt": createdAt == null ? null:  createdAt!.toIso8601String(),
  };
}

class Lesson {
  Lesson({
    this.id,
    this.lessonTitle,
    this.lessonSlug,
  });

  String? id;
  String? lessonTitle;
  String? lessonSlug;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    id: json["_id"],
    lessonTitle: json["lessonTitle"],
    lessonSlug: json["lessonSlug"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "lessonTitle": lessonTitle,
    "lessonSlug": lessonSlug,
  };
}

class Submission {
  Submission({
    this.id,
    this.submittedBy,
    this.contents,
  });

  String? id;
  SubmittedBy? submittedBy;
  String? contents;

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
    id: json["_id"],
    submittedBy: json["submittedBy"] ==  null ? null :  SubmittedBy.fromJson(json["submittedBy"]),
    contents: json["contents"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "submittedBy": submittedBy == null ? null :  submittedBy!.toJson(),
    "contents": contents,
  };
}

class SubmittedBy {
  SubmittedBy({
    this.id,
    this.userImage,
  });

  String? id;
  String? userImage;

  factory SubmittedBy.fromJson(Map<String, dynamic> json) => SubmittedBy(
    id: json["_id"],
    userImage: json["userImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userImage": userImage,
  };
}



AssessmentResponse singleAssessmentResponseFromJson(String str) => AssessmentResponse.fromJson(json.decode(str));

String singleAssessmentResponseToJson(AssessmentResponse data) => json.encode(data.toJson());

class SingleAssessmentResponse {
  SingleAssessmentResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  AssessmentData? data;

  factory SingleAssessmentResponse.fromJson(Map<String, dynamic> json) => SingleAssessmentResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null :  AssessmentData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data ==null ? [] :  data!.toJson(),
  };
}
