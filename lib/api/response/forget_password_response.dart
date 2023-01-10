import 'dart:convert';

ForgetPasswordResponse ForgetPasswordResponseFromJson(String str) => ForgetPasswordResponse.fromJson(json.decode(str));

String ForgetPasswordResponseToJson(ForgetPasswordResponse data) => json.encode(data.toJson());

class ForgetPasswordResponse {
  ForgetPasswordResponse({
    this.status,
    this.success,
    this.msg,
  });

  int ? status;
  bool ? success;
  String ? msg;

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => ForgetPasswordResponse(
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
