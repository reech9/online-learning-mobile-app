// To parse this JSON data, do
//
//     final usersAnswers = usersAnswersFromJson(jsonString);

import 'dart:convert';

UsersAnswers usersAnswersFromJson(String str) => UsersAnswers.fromJson(json.decode(str));

String usersAnswersToJson(UsersAnswers data) => json.encode(data.toJson());

class UsersAnswers {
  UsersAnswers({
    this.userAnswers,
  });

  List<UserAnswer> ? userAnswers;

  factory UsersAnswers.fromJson(Map<String, dynamic> json) => UsersAnswers(
    userAnswers: List<UserAnswer>.from(json["userAnswers"].map((x) => UserAnswer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userAnswers": List<dynamic>.from(userAnswers!.map((x) => x.toJson())),
  };
}

class UserAnswer {
  UserAnswer({
    this.questionId,
    this.answer,
    this.question
  });

  String ? questionId;
  String ? question;
  List<String> ? answer;

  factory UserAnswer.fromJson(Map<String, dynamic> json) => UserAnswer(
    questionId: json["questionId"],
    question: json["question"],
    answer: List<String>.from(json["answer"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "question": question,
    "answer": List<dynamic>.from(answer!.map((x) => x)),
  };
}
