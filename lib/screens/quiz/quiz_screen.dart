import 'dart:convert';
import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:digi_school/api/repository/quiz_repository.dart';
import 'package:digi_school/api/request/answer_request.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/postquiz_response.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/alert_style.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/home_screen/home_view_model.dart';
import 'package:digi_school/screens/quiz/answer_screen.dart';
import 'package:digi_school/screens/quiz/components/score_screen.dart';
import 'package:digi_school/screens/quiz/components/sliding_container.dart';
import 'package:digi_school/screens/quiz/quiz_view_model.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:lottie/lottie.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../api/response/quiz_response.dart';
import '../landing/models/slide.dart';
import '../landing/widgets/slide_dots.dart';
import '../landing/widgets/slide_item.dart';
//
// class QuizScreen extends StatefulWidget {
//   final selectedIndex;
//   QuizScreen({Key? key, this.selectedIndex}) : super(key: key);
//   static const String routeName = "/quiz-screen";
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen> {
//   Map<String, dynamic> dummyQuestions = {
//     "success": true,
//     "message": "Quiz get success",
//     "quiz": [
//       {"questions": "What is computeaaaar", "_id": "a"},
//       {"questions": "What is your name", "_id": "b"},
//       {"questions": "What is ??", "_id": "c"}
//     ]
//   };
//
//   final int _duration = 260;
//   final CountDownController _controller = CountDownController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: QuizBody(
//       selectedIndex: widget.selectedIndex,
//     ));
//   }
// }

class QuizBody extends StatefulWidget {
  int selectedIndex;
  QuizBody({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _QuizBodyState createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  final _options = <String>[];

  List<UserAnswer> _userAnswer = <UserAnswer>[];
  List<UsersAnswers> _usersAnswers = <UsersAnswers>[];

  final int _duration = 260;
  final CountDownController _controller = CountDownController();

  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  int pageChanged = 0;

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var _provider = Provider.of<QuizViewModel>(context, listen: false);
      _provider.fetchQuiz("638427efd2e149561c6ec475");
      for (int i = 0; i < _provider.quiz.questions!.length; i++) {
        _final.add(_final[i]);
      }
    });

    super.initState();
  }

  List<String> _final = <String>[];
  PageController pageController = PageController(initialPage: 0);

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Are you sure'),
                  content: const Text('This will erase all your progress'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          // _dismissDialog();
                          Navigator.of(context).pop();
                        },
                        child: const Text('No')),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Yes'),
                    )
                  ],
                ))) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircularCountDownTimer(
                duration: _duration,
                controller: _controller,
                width: 50,
                height: 50,
                ringColor: Colors.grey[300]!,
                ringGradient: null,
                fillColor: Colors.purpleAccent[100]!,
                fillGradient: null,
                backgroundColor: Colors.purple[500],
                backgroundGradient: null,
                strokeWidth: 3.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {
                  debugPrint('Countdown Started');
                },
                onComplete: () {
                  Alert(
                      style: commonAlertStyle,
                      context: context,
                      type: AlertType.error,
                      content: const Text("Time up"),
                      buttons: [
                        DialogButton(
                            color: Colors.green,
                            child: const Text(
                              "Start over",
                              style: TextStyle(color: kWhite),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }),
                      ]).show();
                },
              )),
        ],
      ),
      body:
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Consumer2<QuizViewModel, CommonViewModel>(
            builder: (context, quiz, common, child) {
          return isLoading(quiz.quizApiResponse)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 200,
                          width: 200,
                          child:
                              Lottie.asset("assets/62266-walking-orange.json")),
                      const Text(
                        "Please wait..",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: quiz.quiz.questions == null || quiz.quiz.questions!.isEmpty? Container():
                      ListView(
                        children: [
                          Container(
                              width: double.infinity,
                              height: 700,
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Builder(builder: (context) {
                                        var sn = widget.selectedIndex + 1;
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Question ${sn.toString()}/${quiz.quiz.questions!.length.toString()}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }),
                                      Container(
                                        width: double.infinity,
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Padding(

                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "  quiz.quiz.questions![widget.selectedIndex].question.toString(),",

                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: h5)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: quiz
                                            .quiz
                                            .questions![widget.selectedIndex]
                                            .options!
                                            .length,
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                //set border radius more than 50% of height and width to make circle
                                              ),
                                              child: ListTile(
                                                selectedColor: Colors.green,
                                                textColor: Colors.black,
                                                // selected:

                                                selected: _options.contains(quiz
                                                    .quiz
                                                    .questions![
                                                        widget.selectedIndex]
                                                    .options![i]
                                                    .toString()),
                                                onTap: () {
                                                  setState(() {
                                                    if (_options.contains(quiz
                                                        .quiz
                                                        .questions![widget
                                                            .selectedIndex]
                                                        .options![i])) {
                                                      setState(() {
                                                        _options.remove(quiz
                                                            .quiz
                                                            .questions![widget
                                                                .selectedIndex]
                                                            .options![i]);
                                                      });
                                                    } else {
                                                      _options.add(quiz
                                                          .quiz
                                                          .questions![widget
                                                              .selectedIndex]
                                                          .options![i]);
                                                    }
                                                  });
                                                },
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    quiz
                                                        .quiz
                                                        .questions![widget
                                                            .selectedIndex]
                                                        .options![i]
                                                        .toString(),
                                                    // style: TextStyle(
                                                    //     fontSize: _answers.contains(quiz
                                                    //             .quiz
                                                    //             .questions![
                                                    //                 index]
                                                    //             .options![i])
                                                    //         ? 17
                                                    //         : 16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      widget.selectedIndex + 1 ==
                                              quiz.quiz.questions!.length
                                          ? SizedBox()
                                          : InkWell(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => QuizBody(
                                                          selectedIndex: widget
                                                                  .selectedIndex +
                                                              1),
                                                    ));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 10),
                                                child: Text(
                                                  "Skip Questions",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                    ],
                                  )
                                ],
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            // Container(
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: <Widget>[
                            //       for (int i = 0;
                            //           i < quiz.quiz.questions!.length;
                            //           i++)
                            //         if (i == widget.selectedIndex)
                            //           SlideContainer(true, i)
                            //         else
                            //           SlideContainer(false, i)
                            //     ],
                            //   ),
                            // ),
                            ElevatedButton(
                                onPressed: () {
                                  inspect(quiz.allAnswers);
                                },
                                child: Text("check data")),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Builder(builder: (context) {
                                  print("122222222222222222222222222+${quiz.quiz.questions}");
                                  return widget.selectedIndex == 0
                                      ? SizedBox()
                                      : IconButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => QuizBody(
                                                      selectedIndex:
                                                          widget.selectedIndex -
                                                              1),
                                                ));
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                            size: 30,
                                          ));
                                }),
                                Builder(builder: (context) {
                                  // int length = quiz.quiz.questions!.length;
                                  print(_currentPage);
                                  // print(length);

                                  return true
                                    // widget.selectedIndex + 1 == length
                                      ?

                                  TextButton(
                                          onPressed: () {
                                            _userAnswer.add(UserAnswer(
                                                answer: _options,
                                                question: quiz
                                                    .quiz.questions![widget.selectedIndex]
                                                    .question!
                                                    .toString(),
                                                questionId: quiz
                                                    .quiz
                                                    .questions![
                                                        widget.selectedIndex]
                                                    .id));
                                            quiz.setAllAnswer(UsersAnswers(
                                                userAnswers: _userAnswer));
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AnswerScreen()));
                                          },
                                          child: Text(
                                            "Check Answers",
                                          ))
                                      :
                                  IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _userAnswer.add(UserAnswer(
                                                  answer: _options,
                                                  question: quiz
                                                      .quiz
                                                      .questions![
                                                          widget.selectedIndex]
                                                      .question!
                                                      .toString(),
                                                  questionId: quiz
                                                      .quiz
                                                      .questions![
                                                          widget.selectedIndex]
                                                      .id));
                                              quiz.setAllAnswer(UsersAnswers(
                                                  userAnswers: _userAnswer));
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => QuizBody(
                                                      selectedIndex:
                                                          widget.selectedIndex +
                                                              1),
                                                ));

                                            // common.setLoading(false);
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white,
                                            size: 30,
                                          ));
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
        }),
      )
      ,
    );
  }
}
