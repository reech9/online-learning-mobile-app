import 'package:digi_school/screens/quiz/quiz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnswerScreen extends StatefulWidget {
  const AnswerScreen({Key? key}) : super(key: key);

  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(builder: (context, quiz, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            "Your log",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            children: [
              ...List.generate(
                  quiz.allAnswers.length,
                  (index) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount:
                                  quiz.allAnswers[index].userAnswers!.length,
                              itemBuilder: (context, i) => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Question: " +
                                        quiz.allAnswers[index].userAnswers![i]
                                            .question
                                            .toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Your answer",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  ...List.generate(
                                      quiz.allAnswers[index].userAnswers![i]
                                          .answer!.length,
                                      (j) => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                quiz.allAnswers[index]
                                                    .userAnswers![i].answer![j]
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ))
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Submit Answers"))
            ],
          ),
        ),
      );
    });
  }
}
