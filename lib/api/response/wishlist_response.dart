
import 'dart:convert';

WishlistResponse wishlistResponseFromJson(String str) => WishlistResponse.fromJson(json.decode(str));

String wishlistResponseToJson(WishlistResponse data) => json.encode(data.toJson());

class WishlistResponse {
  WishlistResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  List<WishlistData>? data;

  factory WishlistResponse.fromJson(Map<String, dynamic> json) => WishlistResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: json["data"] ==null ? [] :  List<WishlistData>.from(json["data"].map((x) => WishlistData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data==null ? []: List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WishlistData {
  WishlistData({
    this.id,
    this.user,
    this.course,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? user;
  Course? course;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory WishlistData.fromJson(Map<String, dynamic> json) => WishlistData(
    id: json["_id"],
    user: json["user"],
    course: json["course"] == null ? null :  Course.fromJson(json["course"]),
    isDeleted: json["is_deleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "course": course?.toJson(),
    "is_deleted": isDeleted,
  };
}

class Course {
  Course({
    this.id,
    this.courseTitle,
    this.courseDesc,
    this.duration,
    this.weeklyStudy,
    this.learnType,
    this.category,
    this.courseSlug,
  });

  String? courseTitle;
  String? id;
  String? courseDesc;
  int? duration;
  int? weeklyStudy;
  String? learnType;
  String? courseSlug;
  Category? category;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["_id"],
    courseTitle: json["courseTitle"],
    courseDesc: json["courseDesc"],
    duration: json["duration"],
    weeklyStudy: json["weekly_study"],
    learnType: json["learn_type"],
    courseSlug: json["courseSlug"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "courseTitle": courseTitle,
    "courseDesc": courseDesc,
    "duration": duration,
    "weekly_study": weeklyStudy,
    "learn_type": learnType,
    "courseSlug": courseSlug,
    "category": category == null ? null : category!.toJson(),
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
