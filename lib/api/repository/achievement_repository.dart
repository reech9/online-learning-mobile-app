import 'dart:convert';

import 'package:digi_school/api/endpoints.dart';

import '../api.dart';
import '../response/achievement_response.dart';
import '../response/certificate_generate_response.dart';
import '../response/course_completed_response.dart';

class AchievementRepository {
  API api = API();

  Future<CertificateGenerate> getCertificate() async {
    dynamic response;
    CertificateGenerate res;
    try {
      response = await api.getWithToken(CustomerEndpoints.myAchievement);
      print("RAW RESPONSE:: " + response.toString());
      res = CertificateGenerate.fromJson(response);
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = CertificateGenerate.fromJson(response);
    }
    return res;
  }

  Future<AchievementCourseResponse> checkCertificate(String value) async {
    dynamic response;
    AchievementCourseResponse res;
    try {
      response =
      await api.getWithToken(CustomerEndpoints.certificateAchievement + value);
      print("RAW RESPONSE:: " + response.toString());
      res = AchievementCourseResponse.fromJson(response);
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = AchievementCourseResponse.fromJson(response);
    }
    return res;
  }

  Future<CourseCompletedResponse> postCertificate(data) async {
    print("COURSE MUST COMPLETE :: "+ data.toString());
    final datas = {
      "courseSlug":data
    };
    dynamic response = await api.postDataWithToken(datas, CustomerEndpoints.postAchievement);
    print(response.toString());
    CourseCompletedResponse res = CourseCompletedResponse.fromJson(response);
    return res;
  }

}