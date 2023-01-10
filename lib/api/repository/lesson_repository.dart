import 'package:digi_school/api/api.dart';
import 'package:digi_school/api/endpoints.dart';
import 'package:digi_school/api/response/comment_response.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/lesson_response.dart';
import 'package:digi_school/api/response/rating_response.dart';

class LessonRepository {
  API api = API();

  Future<LessonResponse> getLessonDetail(String slug) async {
    dynamic response;
    LessonResponse res;
    try {
      response = await api.getWithToken(CustomerEndpoints.lessonDetail  +slug);
      print("RAW  RESPONSE " + response.toString());
      res = LessonResponse.fromJson(response);
      print("RESPONSE "+ res.toString());
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = LessonResponse.fromJson(response);
    }
    return res;
  }

  Future<CommonResponse> startLesson(dynamic data, String slug) async {
    dynamic response;
    CommonResponse res;
    try {
      response = await api.postDataWithToken(data, CustomerEndpoints.lessonStatus + slug);
      print("RAW  RESPONSE " + response.toString());
      res = CommonResponse.fromJson(response);
      print("RESPONSE "+ res.toString());
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = CommonResponse.fromJson(response);
    }
    return res;
  }

  Future<CommonResponse> completeLesson(String courseSlug, String slug) async {
    dynamic response = await api.putDataWithToken(null, CustomerEndpoints.lessonStatus+ courseSlug + "/" + slug);
    print(response.toString());
    CommonResponse res = CommonResponse.fromJson(response);
    return res;
  }



  Future<CommentResponse> getComments(String slug) async {
    dynamic response = await api.getWithToken(CustomerEndpoints.comments + slug);
    CommentResponse res = CommentResponse.fromJson(response);
    return res;
  }


  Future<CommentAddResponse> writeComment(dynamic data, String slug) async {
    dynamic response = await api.postDataWithToken(data, CustomerEndpoints.comments + slug);
    print("Raw response :: " + response.toString());
    CommentAddResponse res = CommentAddResponse.fromJson(response);
    return res;
  }


  Future<CommentAddResponse> replyComment(dynamic data, String slug) async {
    dynamic response = await api.putDataWithToken(data, CustomerEndpoints.commentReply + slug);
    print("Raw response :: " + response.toString());
    CommentAddResponse res = CommentAddResponse.fromJson(response);
    return res;
  }

  Future<RatingResponse> getRating(String slug) async {
    dynamic response = await api.getWithToken(CustomerEndpoints.userRating + slug);
    print("Raw response :: " + response.toString());
    RatingResponse res = RatingResponse.fromJson(response);
    return res;
  }

  Future<CommonResponse> addRating(dynamic data, String slug) async {
    dynamic response = await api.postDataWithToken(data, CustomerEndpoints.userRatingUpdate + slug);
    CommonResponse res = CommonResponse.fromJson(response);
    return res;
  }
}
