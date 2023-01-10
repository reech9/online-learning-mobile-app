// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.success,
    this.token,
    this.user,
    this.msg,
  });

  bool? success;
  String? msg;
  Token? token;
  UserData? user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    msg: json["msg"],
    user: json["data"] ==null ? null : UserData.fromJson(json["data"]),
    token: json["token"] ==null ? null : Token.fromJson(json["token"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "token": token?.toJson(),
    "msg": msg,
    "user": user?.toJson(),
  };
}

class Token {
  Token({
    this.accessToken,
    this.refreshToken,
  });

  String? refreshToken;
  String? accessToken;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}

class UserData {
  UserData({
    this.id,
    this.username,
    this.email,
    this.firstname,
    this.lastname,
    this.roles,
    this.isSuspended,
    this.hash,
    this.salt,
    this.blockedModules,
    this.maritalStatus,
    this.panNumber,
    this.documents,
    this.image,
  });

  String? id;
  String? username;
  String? email;
  String? firstname;
  String? lastname;
  List<dynamic>? roles;
  bool? isSuspended;
  String? hash;
  String? salt;
  List<dynamic>? blockedModules;
  String? maritalStatus;
  String? panNumber;
  String? image;
  List<dynamic>? documents;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    image: json["image"],
    roles: json["roles"]==null ? [] : List<dynamic>.from(json["roles"].map((x) => x)),
    isSuspended: json["isSuspended"],
    hash: json["hash"],
    salt: json["salt"],
    blockedModules: json["blockedModules"] ==null ? []:  List<dynamic>.from(json["blockedModules"].map((x) => x)),
    maritalStatus: json["maritalStatus"],
    panNumber: json["pan_number"],
    documents: json["documents"] == null ? [] :  List<dynamic>.from(json["documents"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "image": image,
    "roles": roles == null ? [] :  List<dynamic>.from(roles!.map((x) => x)),
    "isSuspended": isSuspended,
    "hash": hash,
    "salt": salt,
    "blockedModules": blockedModules==null ? [] :  List<dynamic>.from(blockedModules!.map((x) => x)),
    "maritalStatus": maritalStatus,
    "pan_number": panNumber,
    "documents": documents==null ? [] : List<dynamic>.from(documents!.map((x) => x)),
  };
}
