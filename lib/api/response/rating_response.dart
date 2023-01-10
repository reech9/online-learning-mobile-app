
import 'dart:convert';

RatingResponse ratingResponseFromJson(String str) => RatingResponse.fromJson(json.decode(str));

String ratingResponseToJson(RatingResponse data) => json.encode(data.toJson());

class RatingResponse {
  RatingResponse({
    this.status,
    this.success,
    this.msg,
    this.data,
  });

  int? status;
  bool? success;
  String? msg;
  RatingData? data;

  factory RatingResponse.fromJson(Map<String, dynamic> json) => RatingResponse(
    status: json["status"],
    success: json["success"],
    msg: json["msg"],
    data: json["data"] ==null ? null :  RatingData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "msg": msg,
    "data": data == null ? null :  data!.toJson(),
  };
}

class RatingData {
  RatingData({
    this.id,
    this.rating,
  });

  String? id;
  int? rating;

  factory RatingData.fromJson(Map<String, dynamic> json) => RatingData(
    id: json["_id"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "rating": rating,
  };
}
