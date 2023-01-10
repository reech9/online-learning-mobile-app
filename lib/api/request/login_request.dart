import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));
String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  LoginRequest({
    this.email,
    this.password,
    this.fcm_token,
  });

  String? email;
  String? password;
  String? fcm_token;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    email: json["email"],
    password: json["password"],
    fcm_token: json["fcm_token"],
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _returnThis = {
      "email": email,
      "password": password,
    };
    if(fcm_token!="" && fcm_token!=null){
      _returnThis["fcm_token"] = fcm_token;
    }
    return _returnThis;
  }
}