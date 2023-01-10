// To parse this JSON data, do
//
//     final postQuizResponse = postQuizResponseFromJson(jsonString);

import 'dart:convert';

PostQuizResponse postQuizResponseFromJson(String str) =>
    PostQuizResponse.fromJson(json.decode(str));

String postQuizResponseToJson(PostQuizResponse data) =>
    json.encode(data.toJson());

class PostQuizResponse {
  PostQuizResponse({
    this.status,
    this.success,
    this.msg,
  });

  int? status;
  bool? success;
  String? msg;

  factory PostQuizResponse.fromJson(Map<String, dynamic> json) =>
      PostQuizResponse(
        status: json["status"],
        success: json["success"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "msg": msg,
      };
}
