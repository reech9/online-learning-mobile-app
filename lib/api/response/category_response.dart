// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:digi_school/api/models/category.dart';

CategoryResponse categoryResponseFromJson(String str) => CategoryResponse.fromJson(json.decode(str));

// String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
  CategoryResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int ? status;
  bool ? success;
  String ? msg;
  List<Category> ? data;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  static Map<String, dynamic> toJson(CategoryResponse res) => {
    "status": res.status,
    "success": res.success,
    "msg": res.msg,
    "data": List<dynamic>.from(res.data!.map((x) => CategoryResponse.toJson(res))),
  };
}
