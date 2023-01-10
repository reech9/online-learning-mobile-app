import 'package:digi_school/api/api.dart';
import 'package:digi_school/api/endpoints.dart';
import 'package:digi_school/api/response/assessment_response.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/course_detail_response.dart';
import 'package:digi_school/api/response/course_response.dart';
import 'package:digi_school/api/response/instructor_response.dart';
import 'package:digi_school/api/response/routine_response.dart';

class CourseRepository {
  API api = API();

  Future<CourseResponse> courselist(List<Map<String, String>> params) async {
    String url = CustomerEndpoints.courses;
    String _addedParams = "?";
    for (var e in params) {
      int i = params.indexOf(e);
      if (i == 0) {
        _addedParams +=
            "${e.keys.first.toString()}=${e.values.first.toString()}";
      } else {
        _addedParams +=
            "&${e.keys.first.toString()}=${e.values.first.toString()}";
      }
    }
    url += _addedParams;
    print("URL :: " + url.toString());
    dynamic response;

    CourseResponse res;
    try {
      response = await api.getWithToken(url);
      print("RESPONSE :: " + response.toString());
      res = CourseResponse.fromJson(response);
    } catch (e) {
      res = CourseResponse.fromJson(response);
    }
    return res;
  }

  Future<CourseDetailResponse> getCourseDetail(String slug) async {
    dynamic response;
    CourseDetailResponse res;
    try {
      response = await api.getWithToken(CustomerEndpoints.courseDetail + slug);
      print("RAW  RESPONSE " + response.toString());
      res = CourseDetailResponse.fromJson(response);
      print("RESPONE " + res.toString());
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = CourseDetailResponse.fromJson(response);
    }

    return res;
  }

  Future<InstructorResponse> getInstructor(String id) async {
    dynamic response;
    InstructorResponse res;
    try {
      response = await api.getWithToken(CustomerEndpoints.lecturer + id);
      print("RAW  RESPONSE " + response.toString());
      res = InstructorResponse.fromJson(response);
      print("RESPONSE " + res.toString());
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = InstructorResponse.fromJson(response);
    }

    return res;
  }

  Future<CommonResponse> addLearner(dynamic data, String slug) async {
    dynamic response;
    CommonResponse res;
    print("REQUEST :: " + data.toString());
    try {
      response = await api.patchDataWithToken(
          data, CustomerEndpoints.courseAddLearner + slug);
      print("RAW RESPONSE " + response.toString());
      res = CommonResponse.fromJson(response);
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = CommonResponse.fromJson(response);
    }

    return res;
  }

  Future<AssessmentResponse> getAssessment(String slug) async {
    dynamic response;
    AssessmentResponse res;
    try {
      response =
          await api.getWithToken(CustomerEndpoints.courseAssessment + slug);
      res = AssessmentResponse.fromJson(response);
    } catch (e) {
      res = AssessmentResponse.fromJson(response);
    }

    return res;
  }

  Future<SingleAssessmentResponse> getSingleAssessment(String slug) async {
    dynamic response;
    SingleAssessmentResponse res;
    try {
      response =
          await api.getWithToken(CustomerEndpoints.lessonAssessment + slug);
      res = SingleAssessmentResponse.fromJson(response);
    } catch (e) {
      res = SingleAssessmentResponse.fromJson(response);
    }
    return res;
  }

  Future<CommonResponse> submitSubmission(dynamic data) async {
    dynamic response;
    CommonResponse res;
    print("data:: " + data.toString());
    try {
      response =
          await api.postDataWithToken(data, CustomerEndpoints.submission);
      res = CommonResponse.fromJson(response);
    } catch (e) {
      res = CommonResponse.fromJson(response);
    }
    return res;
  }

  Future<RoutineResponse> getRoutine(String slug) async {
    dynamic response;
    RoutineResponse res;
    try {
      response = await api.getWithToken(CustomerEndpoints.routine + slug);
      res = RoutineResponse.fromJson(response);
    } catch (e) {
      res = RoutineResponse.fromJson(response);
    }
    return res;
  }
}
