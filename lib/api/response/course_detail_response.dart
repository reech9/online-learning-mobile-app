

import 'dart:convert';

CourseDetailResponse courseDetailResponseFromJson(String str) => CourseDetailResponse.fromJson(json.decode(str));

String courseDetailResponseToJson(CourseDetailResponse data) => json.encode(data.toJson());

class CourseDetailResponse {
  CourseDetailResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  CourseData? data;

  factory CourseDetailResponse.fromJson(Map<String, dynamic> json) => CourseDetailResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: CourseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class CourseData {
  CourseData({
    this.details,
    this.weeks,
    this.progress
  });

  Details? details;
  List<Week>? weeks;
  dynamic progress;
  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
      details: Details.fromJson(json["details"]),
      weeks: json["weeks"] ==null ? [] :  List<Week>.from(json["weeks"].map((x) => Week.fromJson(x))),
      progress: json["progress"] == null ? null : json["progress"]
  );

  Map<String, dynamic> toJson() => {
    "details": details?.toJson(),
    "weeks": weeks==null ? [] : List<dynamic>.from(weeks!.map((x) => x.toJson())),
    "progress" : progress == null ? null : progress,
  };
}

class Details {
  Details({
    this.id,
    this.courseTitle,
    this.courseDesc,
    this.duration,
    this.weeklyStudy,
    this.learnType,
    this.category,
    this.lecturers,
    this.tags,
    this.learners,
    this.courseSlug,
    this.image,
    this.rating,
  });

  String? id;
  String? courseTitle;
  String? courseDesc;
  int? duration;
  List<String>? tags;
  int? weeklyStudy;
  String? learnType;
  String? category;
  List<Lecturer>? lecturers;
  List<User>? learners;
  String? courseSlug;
  String? image;
  double? rating;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["_id"],
    courseTitle: json["courseTitle"],
    courseDesc: json["courseDesc"],
    duration: json["duration"],
    weeklyStudy: json["weekly_study"],
    learnType: json["learn_type"],
    category: json["category"],
    lecturers: json["lecturers"] ==null ? []:  List<Lecturer>.from(json["lecturers"].map((x) => Lecturer.fromJson(x))),
    learners: json["learners"] ==null ? [] : List<User>.from(json["learners"].map((x) => User.fromJson(x))),
    courseSlug: json["courseSlug"],
    image: json["image"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"].map((x) => x)),
    rating: json["rating"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "courseTitle": courseTitle,
    "courseDesc": courseDesc,
    "duration": duration,
    "weekly_study": weeklyStudy,
    "learn_type": learnType,
    "image": image,
    "category": category,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "lecturers": lecturers==null ? [] :  List<dynamic>.from(lecturers!.map((x) => x.toJson())),
    "learners": learners == null ? []  : List<dynamic>.from(learners!.map((x) => x.toJson())),
    "courseSlug": courseSlug,
    "rating": rating,
  };
}



class Lecturer {
  Lecturer({
    this.id,
    this.user,
    this.joinDate,
  });

  String? id;
  User? user;
  DateTime? joinDate;

  factory Lecturer.fromJson(Map<String, dynamic> json) => Lecturer(
    id: json["_id"],
    user: User.fromJson(json["user"]),
    joinDate: DateTime.parse(json["joinDate"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "joinDate": joinDate?.toIso8601String(),
  };
}

class User {
  User({
    this.firstname,
    this.id,
    this.lastname,
    this.email,
    this.userImage,
  });

  String? firstname;
  String? id;
  String? lastname;
  String? email;
  String? userImage;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    userImage: json["userImage"] == null ? null :  json["userImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "userImage": userImage,
  };
}

class Week {
  Week({
    this.id,
    this.title,
    this.week,
    this.lessons,
  });

  String? id;
  String? title;
  int? week;
  List<Lesson>? lessons;

  factory Week.fromJson(Map<String, dynamic> json) => Week(
    id: json["_id"],
    title: json["title"],
    week: json["week"],
    lessons: json["lessons"] ==null ? [] : List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "week": week,
    "lessons":  lessons==null ? [] : List<dynamic>.from(lessons!.map((x) => x.toJson())),
  };
}

class Lesson {
  Lesson({
    this.lessonTitle,
    this.lessonSlug,
    this.status
  });

  String? lessonTitle;
  String? lessonSlug;
  bool? status;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    lessonTitle: json["lessonTitle"],
    lessonSlug: json["lessonSlug"],
    status: json["status"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "lessonTitle": lessonTitle,
    "lessonSlug": lessonSlug,
    "status": status ?? false,
  };
}