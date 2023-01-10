// To parse this JSON data, do
//
//     final updateProfileRequest = updateProfileRequestFromJson(jsonString);

import 'dart:convert';

UpdateProfileRequest updateProfileRequestFromJson(String str) =>
    UpdateProfileRequest.fromJson(json.decode(str));

String updateProfileRequestToJson(UpdateProfileRequest data) =>
    json.encode(data.toJson());

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.firstname,
    this.lastname,
    this.panNumber,
  });

  String? firstname;
  String? lastname;
  String? panNumber;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        firstname: json["firstname"],
        lastname: json["lastname"],
        panNumber: json["pan_number"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "pan_number": panNumber,
      };
}
