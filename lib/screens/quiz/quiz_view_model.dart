import 'package:digi_school/api/api_response.dart';
import 'package:digi_school/api/repository/quiz_repository.dart';
import 'package:digi_school/api/request/answer_request.dart';
import 'package:digi_school/api/response/common_response.dart';

import 'package:digi_school/api/response/quiz_response.dart';
import 'package:flutter/material.dart';

class QuizViewModel with ChangeNotifier {
  ApiResponse _quizApiResponse = ApiResponse.initial('Empty data');
  ApiResponse get quizApiResponse => _quizApiResponse;
  Quiz _quiz = new Quiz();
  Quiz get quiz => _quiz;

  // List<Log> _logs = [];
  //
  //
  // void setLog(List<Log> data){
  //   _logs = data;
  //   notifyListeners();
  // }
  //
  // List<Log> get logs => _logs;

  List<Question> _questions = [];
  List<Question> get questions => _questions;

  List<String> _options = <String>[];
  List<String> get options => _options;

  setOptions(String value) {
    _options.add(value);
    notifyListeners();
  }

  clearOptions() {
    _options.clear();
  }

  String _qid = "";
  String get qid => _qid;

  setQuestionId(String value) {
    _qid = value;
    notifyListeners();
  }

  clearQID() {
    _qid = "";
  }

  List<UserAnswer> _answers = <UserAnswer>[];
  List<UserAnswer> get answers => _answers;

  setindividualAnswers(UserAnswer data) {
    _answers.add(data);
    notifyListeners();
  }

  List<UsersAnswers> _allAnswers = <UsersAnswers>[];
  List<UsersAnswers> get allAnswers => _allAnswers;

  setAllAnswer(UsersAnswers data) {
    _allAnswers.add(data);
  }


  Future<void> fetchQuiz(String id) async {
    _quizApiResponse = ApiResponse.loading('Fetching device data');
    notifyListeners();
    try {
      QuizResponse data = await QuizRepository().getQuiz(id);
      print("hiiiiii + ${data.data!.quiz!} ");
      _quiz = data.data!.quiz!;

      _quizApiResponse = ApiResponse.completed(data.msg);
      // _loadMoreApiResponse = ApiResponse.completed(data);
      notifyListeners();
    } catch (e) {
      _quizApiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
    notifyListeners();
  }




  // ApiResponse _scoresApiResponse = ApiResponse.initial('Empty data');
  //
  // ApiResponse get scoresApiResponse => _scoresApiResponse;
  // dynamic _scores;
  // dynamic get score => _scores;
  //
  // Future<void> fetchScores(String slug) async {
  //   _scoresApiResponse = ApiResponse.loading('Fetching device data');
  //   notifyListeners();
  //   try {
  //     CommonResponse data = await QuizRepository().getScores(slug);
  //
  //     _scores = data.data;
  //     _scoresApiResponse = ApiResponse.completed(data.msg);
  //     // _loadMoreApiResponse = ApiResponse.completed(data);
  //     notifyListeners();
  //   } catch (e) {
  //     _scoresApiResponse = ApiResponse.error(e.toString());
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }
}
