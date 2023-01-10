
import 'dart:convert';

MyLearningResponse myLearningResponseFromJson(String str) => MyLearningResponse.fromJson(json.decode(str));

String myLearningResponseToJson(MyLearningResponse data) => json.encode(data.toJson());

class MyLearningResponse {
  MyLearningResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  List<MyLearningData>? data;

  factory MyLearningResponse.fromJson(Map<String, dynamic> json) => MyLearningResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: json["data"] ==null ? [] :  List<MyLearningData>.from(json["data"].map((x) => MyLearningData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data == null ? [] :  List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MyLearningData {
  MyLearningData({
    this.id,
    this.courseTitle,
    this.category,
    this.lecturers,
    this.courseSlug,
    this.progress,
    this.image,
  });

  String? id;
  String? courseTitle;
  String? image;
  Category? category;
  List<Lecturer>? lecturers;
  String? courseSlug;
  num? progress;

  factory MyLearningData.fromJson(Map<String, dynamic> json) => MyLearningData(
    id: json["_id"],
    courseTitle: json["courseTitle"],
    image: json["image"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    lecturers: json["lecturers"] ==null ? [] :  List<Lecturer>.from(json["lecturers"].map((x) => Lecturer.fromJson(x))),
    courseSlug: json["courseSlug"],
    progress: json["progress"] == null ? null : json["progress"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "courseTitle": courseTitle,
    "image": image,
    "category": category == null ? null : category!.toJson(),
    "lecturers": lecturers == null ? [] :  List<dynamic>.from(lecturers!.map((x) => x.toJson())),
    "courseSlug": courseSlug,
    "progress": progress == null ? null : progress,
  };
}

class Category {
  Category({
    this.categoryName,
    this.categorySlug,
  });

  String? categoryName;
  String? categorySlug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryName: json["categoryName"],
    categorySlug: json["categorySlug"],
  );

  Map<String, dynamic> toJson() => {
    "categoryName": categoryName,
    "categorySlug": categorySlug,
  };
}

class Lecturer {
  Lecturer({
    this.user,
    this.joinDate,
  });

  User? user;
  DateTime? joinDate;

  factory Lecturer.fromJson(Map<String, dynamic> json) => Lecturer(
    user: json["user"] ==null ? null :  User.fromJson(json["user"]),
    joinDate: json["joinDate"] == null ? null :  DateTime.parse(json["joinDate"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "joinDate": joinDate==null ? null :  joinDate!.toIso8601String(),
  };
}

class User {
  User({
    this.firstname,
    this.lastname,
    this.email,
    this.userImage,
  });

  String? firstname;
  String? lastname;
  String? email;
  String? userImage;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    userImage: json["userImage"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "userImage": userImage,
  };
}
