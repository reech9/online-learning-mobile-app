import 'dart:convert';

import 'package:digi_school/api/api_response.dart';
import 'package:digi_school/api/repository/course_repository.dart';
import 'package:digi_school/api/response/assessment_response.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/routine_response.dart';
import 'package:flutter/material.dart';

class AssessmentViewModel with ChangeNotifier{


  ApiResponse _assessmentApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get assessmentApiResponse => _assessmentApiResponse;
  AssessmentData? _assessmentData;
  AssessmentData? get assessmentData => _assessmentData;

  Future<void> getSingleAssessment(String slug) async {
    _assessmentApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      SingleAssessmentResponse res = await CourseRepository().getSingleAssessment(slug);
      if (res.success == true) {
        _assessmentData = res.data!;
        _assessmentApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _assessmentApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      _assessmentApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }



  ApiResponse _assessmentUploadApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get assessmentUploadApiResponse => _assessmentUploadApiResponse;

  Future<void> uploadAssignment(String slug, String content) async {
    _assessmentUploadApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      CommonResponse res = await CourseRepository().submitSubmission(jsonEncode({
        "contents": content,
        "lessonSlug": slug,
      }));
      if (res.success == true) {
        _assessmentData!.submission![0].contents = content;
        _assessmentUploadApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _assessmentUploadApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      _assessmentUploadApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}