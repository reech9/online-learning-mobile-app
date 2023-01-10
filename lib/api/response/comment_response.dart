
import 'dart:convert';

CommentResponse commentResponseFromJson(String str) => CommentResponse.fromJson(json.decode(str));

String commentResponseToJson(CommentResponse data) => json.encode(data.toJson());

class CommentResponse {
  CommentResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  List<CommentData>? data;

  factory CommentResponse.fromJson(Map<String, dynamic> json) => CommentResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: json["data"] ==null ? [] :  List<CommentData>.from(json["data"].map((x) => CommentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data == null ? [] :  List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CommentData {
  CommentData({
    this.id,
    this.postedBy,
    this.comment,
    this.reports,
    this.replies,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  PostedBy? postedBy;
  String? comment;
  List<dynamic>? reports;
  List<CommentData>? replies;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
    id: json["_id"],
    postedBy:json["postedBy"] == null ? null :  PostedBy.fromJson(json["postedBy"]),
    comment: json["comment"],
    reports: json["reports"] == null ? [] :  List<dynamic>.from(json["reports"].map((x) => x)),
    replies: json["replies"] ==null ? [] :  List<CommentData>.from(json["replies"].map((x) => CommentData.fromJson(x))),
    createdAt: json["createdAt"]==null ? null :  DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null :  DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postedBy": postedBy==null ? null :  postedBy!.toJson(),
    "comment": comment,
    "reports": reports == null ? [] :  List<dynamic>.from(reports!.map((x) => x)),
    "replies": replies == null ? [] :  List<dynamic>.from(replies!.map((x) => x)),
    "createdAt": createdAt == null ? null :  createdAt!.toIso8601String(),
    "updatedAt":updatedAt == null ? null : updatedAt!.toIso8601String(),
    "__v": v,
  };
}



class PostedBy {
  PostedBy({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.userImage,
  });

  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? userImage;

  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
    id: json["_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    userImage: json["userImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "userImage": userImage,
  };
}



CommentAddResponse commentAddResponseFromJson(String str) => CommentAddResponse.fromJson(json.decode(str));

String commentAddResponseToJson(CommentResponse data) => json.encode(data.toJson());

class CommentAddResponse {
  CommentAddResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  CommentData? data;

  factory CommentAddResponse.fromJson(Map<String, dynamic> json) => CommentAddResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null : CommentData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data == null ? null : data!.toJson(),
  };
}