// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

import 'package:digi_school/api/models/course.dart';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  SearchResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  List<Course>? data;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        status: json["status"],
        success: json["success"],
        msg: json["msg"],
        data: List<Course>.from(json["data"].map((x) => Course.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
