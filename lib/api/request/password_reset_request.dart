import 'dart:convert';

PasswordResetRequest passwordResetRequestFromJson(String str) => PasswordResetRequest.fromJson(json.decode(str));
String passwordResetRequestToJson(PasswordResetRequest data) => json.encode(data.toJson());

class PasswordResetRequest {
  PasswordResetRequest({
    this.email,
    this.oldPassword,
    this.password,
  });

  String? email;
  String? oldPassword;
  String? password;

  factory PasswordResetRequest.fromJson(Map<String, dynamic> json) => PasswordResetRequest(
    email: json["email"],
    oldPassword: json["oldPassword"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "oldPassword": oldPassword,
    "password": password,
  };
}