import 'dart:convert';

import 'package:digi_school/api/api.dart';
import 'package:digi_school/api/endpoints.dart';
import 'package:digi_school/api/request/answer_request.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/postquiz_response.dart';
import 'package:digi_school/api/response/quiz_response.dart';

class QuizRepository {
  API api = API();

  Future<QuizResponse> getQuiz(String id) async {
    dynamic response;
    QuizResponse res;
    try {
      response = await api.getWithToken("/quiz/${id}");
      print("RAW  RESPONSE " + response.toString());
      res = QuizResponse.fromJson(response);
      print(res.toJson());
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = QuizResponse.fromJson(response);
    }
    return res;
  }

  Future<CommonResponse> getScores(String slug) async {
    dynamic response;
    CommonResponse res;
    try {
      response = await api.getWithToken(CustomerEndpoints.getScores + slug);
      print("RAW  RESPONSE " + response.toString());
      res = CommonResponse.fromJson(response);
      print("RESPONSE " + res.toString());
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = CommonResponse.fromJson(response);
    }
    return res;
  }

  Future<CommonResponse> postQuiz(data) async {
    dynamic response;
    CommonResponse res;
    try {
      response = await api.postDataWithToken(
          jsonEncode(data), CustomerEndpoints.postAnswers);
      print("RAW  RESPONSE " + response.toString());
      res = CommonResponse.fromJson(response);
      print("RESPONSE " + res.toString());
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = CommonResponse.fromJson(response);
    }
    return res;
  }
}

// (AnswerRequest data, String slug)
