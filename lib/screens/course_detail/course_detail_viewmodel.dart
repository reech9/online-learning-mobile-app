import 'dart:convert';

import 'package:digi_school/api/api_response.dart';
import 'package:digi_school/api/repository/course_repository.dart';
import 'package:digi_school/api/response/assessment_response.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/course_detail_response.dart';
import 'package:digi_school/api/response/instructor_response.dart';
import 'package:digi_school/api/response/lesson_response.dart';
import 'package:digi_school/api/response/login_response.dart';
import 'package:digi_school/api/response/routine_response.dart';
import 'package:flutter/material.dart';

class CourseDetailViewModel with ChangeNotifier {
  ApiResponse _courseDetailApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get courseDetailApiResponse => _courseDetailApiResponse;

  CourseData? _course;
  CourseData? get course => _course;

  Future<void> getCourse(String slug, {String email=""}) async {
    _courseDetailApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    _course = null;
    _isFav = false;
    _hasAccess = false;
    try {
      CourseDetailResponse res = await CourseRepository().getCourseDetail(slug);
      if (res.success == true) {
        _course = res.data!;
        checkAccess(email);
        _courseDetailApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        print("ELSE :: " + res.msg.toString());
        _courseDetailApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _courseDetailApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  ApiResponse _courseEnrollApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get courseEnrollApiResponse => _courseEnrollApiResponse;

  Future<void> enrollCourse(UserData userId, String slug) async {
    _courseEnrollApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      CommonResponse res = await CourseRepository().addLearner(
          jsonEncode({
            "learners": [userId.id.toString()],
          }),
          slug);
      if (res.success == true) {
        _course!.details!.learners!.add(User(
          email: userId.email.toString(),
          firstname: userId.firstname.toString(),
          lastname: userId.lastname.toString(),
          userImage: userId.image.toString(),
        ));
        //
        checkAccess(userId.email.toString());
        _courseEnrollApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        print("ELSE :: " + res.msg.toString());
        _courseEnrollApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _courseEnrollApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  ApiResponse _courseAssessmentApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get courseAssessmentApiResponse => _courseAssessmentApiResponse;

  List<AssessmentData> _assessmentData = [];
  List<AssessmentData> get assessmentData => _assessmentData;
  Future<void> getAssessment(String slug) async {
    _courseAssessmentApiResponse = ApiResponse.loading("Loading");
    _assessmentData = [];
    notifyListeners();
    try {
      AssessmentResponse res = await CourseRepository().getAssessment(slug);
      if (res.success == true) {
        _assessmentData = res.data!;
        _courseAssessmentApiResponse =
            ApiResponse.completed(res.msg.toString());
      } else {
        print("ELSE :: " + res.msg.toString());
        _courseAssessmentApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _courseAssessmentApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  bool _isFav = false;
  bool get isFav => _isFav;

  setFav(bool state) {
    _isFav = state;
    notifyListeners();
  }

  int _activeWeekIndex = -1;
  int get activeWeekIndex => _activeWeekIndex;

  LessonData? _prevLesson;
  LessonData? get prevLesson => _prevLesson;

  LessonData? _nextLesson;
  LessonData? get nextLesson => _nextLesson;

  void findWeek(String? lessonSlug) {
    print("LESSON SLUG " + lessonSlug.toString());
    int idx = -1;
    _activeWeekIndex = -1;
    try {
      for (var i = 0; i < course!.weeks!.length; i++) {
        if (_activeWeekIndex == -1) {
          idx = course!.weeks![i].lessons!
              .indexWhere((element) => element.lessonSlug == lessonSlug);
          print("I, IDX :: " + i.toString() + " " + idx.toString());
        }
        if (idx != -1) {
          _activeWeekIndex = i;
          break;
        }
      }
    } catch (e) {
      print("ERROR ::" + e.toString());
      _activeWeekIndex = -1;
    }
    print("ACTIVE INDEX :: " + _activeWeekIndex.toString());
    notifyListeners();
  }


  ApiResponse _routineApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get routineApiResponse => _routineApiResponse;
  List<RoutineData> _routine =[];
  List<RoutineData>  get routine =>_routine;
  Future<void> getRoutine(String slug, ) async {
    _routineApiResponse = ApiResponse.loading("Loading");
    _routine = [];
    notifyListeners();
    try {
      RoutineResponse res = await CourseRepository().getRoutine( slug,);
      if (res.success == true) {
        _routine = res.data!;
        _routineApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _routineApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      _routineApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }


  bool _hasAccess = false;
  bool get hasAccess => _hasAccess;

  void checkAccess(String email) {
    if (course != null && course!.details != null) {
      for (var element in course!.details!.learners!) {
        if (element.email == email) {
          _hasAccess = true;
          break;
        }
      }
    } else {
      _hasAccess = false;
    }
    notifyListeners();
  }

  // lesson slug
  void setStatus(String slug) {
    try {
      for (var element in course!.weeks!) {
        int idx = element.lessons!
            .indexWhere((element) => element.lessonSlug == slug);
        if (idx != -1) {
          element.lessons![idx].status = true;
          break;
        }
      }
    } catch (e) {}
    notifyListeners();
  }




  ApiResponse _instructorDetailApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get instructorDetailApiResponse => _instructorDetailApiResponse;

  InstructorData? _instructor;
  InstructorData? get instructor => _instructor;

  Future<void> getInstructor(String id) async {
    _instructorDetailApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      // InstructorResponse res = await CourseRepository().getInstructor(id);
      InstructorResponse res = await CourseRepository().getInstructor("628c47fd699d713c471cbcbb");
      if (res.success == true) {
        _instructor = res.data!;
        _instructorDetailApiResponse = ApiResponse.completed(res.success.toString());
      } else {
        print("ELSE :: " + res.success.toString());
        _instructorDetailApiResponse = ApiResponse.error(res.success.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _instructorDetailApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
