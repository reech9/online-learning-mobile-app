// To parse this JSON data, do
//
//     final signupRequest = signupRequestFromJson(jsonString);

import 'dart:convert';

SignupRequest signupRequestFromJson(String str) => SignupRequest.fromJson(json.decode(str));

String signupRequestToJson(SignupRequest data) => json.encode(data.toJson());

class SignupRequest {
  SignupRequest({
    this.email,
    this.password,
    this.firstname,
    this.lastname,
  });

  String ? email;
  String ? password;
  String ? firstname;
  String ? lastname;

  factory SignupRequest.fromJson(Map<String, dynamic> json) => SignupRequest(
    email: json["email"],
    password: json["password"],
    firstname: json["firstname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "firstname": firstname,
    "lastname": lastname,
  };
}
