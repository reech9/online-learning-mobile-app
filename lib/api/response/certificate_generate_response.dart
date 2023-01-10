// To parse this JSON data, do
//
//     final certificateGenerate = certificateGenerateFromJson(jsonString);

import 'dart:convert';

CertificateGenerate certificateGenerateFromJson(String str) => CertificateGenerate.fromJson(json.decode(str));

String certificateGenerateToJson(CertificateGenerate data) => json.encode(data.toJson());

class CertificateGenerate {
  CertificateGenerate({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int ?status;
  bool ?success;
  String ?msg;
  List<Datum> ?data;

  factory CertificateGenerate.fromJson(Map<String, dynamic> json) => CertificateGenerate(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.user,
    this.course,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.achievementTemplate,
  });

  String ?id;
  List<User> ?user;
  List<Course> ?course;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;
  List<dynamic> ?achievementTemplate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
    course: List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    achievementTemplate: List<dynamic>.from(json["achievementTemplate"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": List<dynamic>.from(user!.map((x) => x.toJson())),
    "course": List<dynamic>.from(course!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "achievementTemplate": List<dynamic>.from(achievementTemplate!.map((x) => x)),
  };
}

class Course {
  Course({
    this.id,
    this.courseTitle,
    this.courseSlug,
  });

  String ?id;
  String ?courseTitle;
  String ?courseSlug;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["_id"],
    courseTitle: json["courseTitle"],
    courseSlug: json["courseSlug"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "courseTitle": courseTitle,
    "courseSlug": courseSlug,
  };
}

class User {
  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
  });

  String ?id;
  String ?firstname;
  String ?lastname;
  String ?email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
  };
}
