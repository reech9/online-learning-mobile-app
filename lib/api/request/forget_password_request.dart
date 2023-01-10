// To parse this JSON data, do
//
//     final forgetPasswordRequest = forgetPasswordRequestFromJson(jsonString);

import 'dart:convert';

ForgetPasswordRequest forgetPasswordRequestFromJson(String str) => ForgetPasswordRequest.fromJson(json.decode(str));

String forgetPasswordRequestToJson(ForgetPasswordRequest data) => json.encode(data.toJson());

class ForgetPasswordRequest {
  ForgetPasswordRequest({
    this.email,
  });

  String ? email;

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) => ForgetPasswordRequest(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
