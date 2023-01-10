// To parse this JSON data, do
//
//     final submitAnswerResponse = submitAnswerResponseFromJson(jsonString);

import 'dart:convert';

SubmitAnswerResponse submitAnswerResponseFromJson(String str) => SubmitAnswerResponse.fromJson(json.decode(str));

String submitAnswerResponseToJson(SubmitAnswerResponse data) => json.encode(data.toJson());

class SubmitAnswerResponse {
  SubmitAnswerResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int ? status;
  bool ? success;
  String ? msg;
  List<dynamic> ? data;

  factory SubmitAnswerResponse.fromJson(Map<String, dynamic> json) => SubmitAnswerResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x)),
  };
}
