import 'dart:convert';

import 'package:digi_school/api/api_response.dart';
import 'package:digi_school/api/repository/lesson_repository.dart';
import 'package:digi_school/api/response/comment_response.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/lesson_response.dart';
import 'package:digi_school/api/response/rating_response.dart';
import 'package:flutter/material.dart';

class LessonViewModel extends ChangeNotifier{
  ApiResponse _lessonDetailApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get lessonDetailApiResponse => _lessonDetailApiResponse;

  LessonData? _lesson;
  LessonData? get lesson =>_lesson;

  Future<void> getLesson(String slug) async {
    _lessonDetailApiResponse = ApiResponse.initial("Loading");
    notifyListeners();
    _lesson = null;
    _hasStarted = false;
    _hasFinished = false;
    try {
      LessonResponse res = await LessonRepository().getLessonDetail(slug);
      if (res.success == true) {
        _lesson = res.data!;
        print("START DATE :: " + _lesson!.status.toString());
        if(_lesson!.status!=null && _lesson!.status!.startDate!=null){
          _hasStarted = true;
          if(_lesson!.status!.endDate!=null){
            _hasFinished = true;
          }
        }
        _lessonDetailApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        print("ELSE :: " +res.msg.toString());
        _lessonDetailApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _lessonDetailApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  bool _hasStarted = false;
  bool _hasFinished = false;

  bool get hasStarted => _hasStarted;
  bool get hasFinished => _hasFinished;

  ApiResponse _lessonStatusApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get lessonStatusApiResponse => _lessonStatusApiResponse;


  Future<void> startLesson(String slug) async {
    _lessonStatusApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      CommonResponse res = await LessonRepository().startLesson(null, slug);
      if (res.success == true) {
        _hasStarted = true;
        _lessonStatusApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _lessonStatusApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      _lessonStatusApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }


  Future<void> completeLesson(String courseSlug, String slug) async {
    _lessonStatusApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      CommonResponse res = await LessonRepository().completeLesson(courseSlug, slug);
      if (res.success == true) {
        _hasFinished = true;
        _lessonStatusApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _lessonStatusApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      _lessonStatusApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }


  ApiResponse _lessonCommentApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get lessonCommentApiResponse => _lessonCommentApiResponse;
  List<CommentData> _comments = [];
  List<CommentData> get comment => _comments;
  Future<void> getComments(String slug) async {
    _lessonCommentApiResponse = ApiResponse.loading("Loading");
    _comments = [];
    notifyListeners();
    try {
      CommentResponse res = await LessonRepository().getComments(slug);
      if (res.success == true) {
        _comments = res.data!;
        _lessonCommentApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _lessonCommentApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("ERRO R :: "+ e.toString());
      _lessonCommentApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }


  ApiResponse _lessonCommentUpdateApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get lessonCommentUpdateApiResponse => _lessonCommentUpdateApiResponse;

  Future<void> writeComment(String data, String slug) async {
    _lessonCommentUpdateApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      CommentAddResponse res = await LessonRepository().writeComment(jsonEncode({
        "comment": data
      }) , slug);
      if (res.success == true) {
        _comments.add(res.data!);
        _lessonCommentUpdateApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _lessonCommentUpdateApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      _lessonCommentUpdateApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }


  ApiResponse _lessonCommentReplyUpdateApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get lessonCommentReplyUpdateApiResponse => _lessonCommentReplyUpdateApiResponse;

  Future<void> replyComment(String id, String comment, List<int> stack) async {
    _lessonCommentReplyUpdateApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      CommentAddResponse res = await LessonRepository().replyComment(jsonEncode({
        "comment": comment,
      }) , id);
      if (res.success == true) {
        if(stack.length == 1){
          _comments[stack[0]].replies!.add(res.data!);
        }else if(stack.length == 2){
          _comments[stack[0]].replies![stack[1]].replies!.add(res.data!);
        }
        _lessonCommentReplyUpdateApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _lessonCommentReplyUpdateApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      _lessonCommentReplyUpdateApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }


  ApiResponse _lessonRatingApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get lessonRatingApiResponse => _lessonRatingApiResponse;

  int _rating = -1;
  int  get rating => _rating;

  Future<void> getRatings(String slug) async {
    _lessonRatingApiResponse = ApiResponse.loading("Loading");
    _rating = -1;
    notifyListeners();
    try {
      RatingResponse res = await LessonRepository().getRating(slug);
      if (res.success == true) {
        _rating = res.data!.rating!;
        _lessonRatingApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _lessonRatingApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("ERR : "+ e.toString());
      _lessonRatingApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }


  ApiResponse _lessonUpdateRatingApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get lessonUpdateRatingApiResponse => _lessonUpdateRatingApiResponse;

  Future<void> doRating(int rating, String slug) async {
    _lessonRatingApiResponse = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      CommonResponse res;
        res = await LessonRepository().addRating(jsonEncode({
          "rating": rating
        }), slug);

      if (res.success == true) {
        _rating = rating;
        _lessonRatingApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _lessonRatingApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      _lessonRatingApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}