// // To parse this JSON data, do
// //
// //     final updateProfileResponse = updateProfileResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// UpdateProfileResponse updateProfileResponseFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));
//
// String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());
//
// class UpdateProfileResponse {
//   UpdateProfileResponse({
//     this.status,
//     this.success,
//     this.msg,
//     this.data,
//   });
//
//   int status;
//   bool success;
//   String msg;
//   Data data;
//
//   factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
//     status: json["status"],
//     success: json["success"],
//     msg: json["msg"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "success": success,
//     "msg": msg,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.firstname,
//     this.lastname,
//     this.email,
//     this.roles,
//     this.panNumber,
//     this.documents,
//     this.createdAt,
//     this.userImage,
//     this.province,
//     this.gender,
//   });
//
//   String firstname;
//   String lastname;
//   String email;
//   List<String> roles;
//   String panNumber;
//   List<dynamic> documents;
//   DateTime createdAt;
//   String userImage;
//   String province;
//   String gender;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     firstname: json["firstname"],
//     lastname: json["lastname"],
//     email: json["email"],
//     roles: List<String>.from(json["roles"].map((x) => x)),
//     panNumber: json["pan_number"],
//     documents: List<dynamic>.from(json["documents"].map((x) => x)),
//     createdAt: DateTime.parse(json["createdAt"]),
//     userImage: json["userImage"],
//     province: json["province"],
//     gender: json["gender"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "firstname": firstname,
//     "lastname": lastname,
//     "email": email,
//     "roles": List<dynamic>.from(roles.map((x) => x)),
//     "pan_number": panNumber,
//     "documents": List<dynamic>.from(documents.map((x) => x)),
//     "createdAt": createdAt.toIso8601String(),
//     "userImage": userImage,
//     "province": province,
//     "gender": gender,
//   };
// }
