// To parse this JSON data, do
//
//     final quizResponse = quizResponseFromJson(jsonString);

import 'dart:convert';

QuizResponse quizResponseFromJson(String str) => QuizResponse.fromJson(json.decode(str));

String quizResponseToJson(QuizResponse data) => json.encode(data.toJson());

class QuizResponse {
  QuizResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int ?status;
  bool ?success;
  String ?msg;
  Data ?data;

  factory QuizResponse.fromJson(Map<String, dynamic> json) => QuizResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.quiz,
    this.logs,
  });

  Quiz ?quiz;
  List<dynamic> ?logs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    quiz: Quiz.fromJson(json["quiz"]),
    logs: List<dynamic>.from(json["logs"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "quiz": quiz?.toJson(),
    "logs": List<dynamic>.from(logs!.map((x) => x)),
  };
}

class Quiz {
  Quiz({
    this.id,
    this.questions,
    this.course,
    this.week,
    this.startDate,
    this.endDate,
    this.postedBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String ?id;
  List<Question> ?questions;
  List<Course> ?course;
  List<Week> ?week;
  DateTime ?startDate;
  DateTime ?endDate;
  String ?postedBy;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    id: json["_id"],
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    course: List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
    week: List<Week>.from(json["week"].map((x) => Week.fromJson(x))),
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    postedBy: json["postedBy"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
    "course": List<dynamic>.from(course!.map((x) => x.toJson())),
    "week": List<dynamic>.from(week!.map((x) => x.toJson())),
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "postedBy": postedBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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

class Question {
  Question({
    this.id,
    this.question,
    this.options,
  });

  String ?id;
  String ?question;
  List<String> ?options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["_id"],
    question: json["question"],
    options: List<String>.from(json["options"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "options": List<dynamic>.from(options!.map((x) => x)),
  };
}

class Week {
  Week({
    this.id,
    this.title,
    this.week,
  });

  String ?id;
  String ?title;
  int ?week;

  factory Week.fromJson(Map<String, dynamic> json) => Week(
    id: json["_id"],
    title: json["title"],
    week: json["week"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "week": week,
  };
}
