import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/quiz/quiz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class QuizLanding extends StatefulWidget {
  String id;
  QuizLanding({Key? key, required this.id}) : super(key: key);

  static const String routeName = "/quiz-landing";

  @override
  _QuizLandingState createState() => _QuizLandingState();
}

class _QuizLandingState extends State<QuizLanding> {
  final double buttonHeight = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
            backgroundColor: Colors.grey.shade100,
            iconTheme: const IconThemeData(color: kBlack),
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
            // title: const Text(
            //   "Quiz",
            //   style: TextStyle(color: kBlack),
            // ),
            ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                // const Text(
                //   "Week 1",
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const Text(
                //   "The Basics of Multer",
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                const SizedBox(
                  height: 50,
                ),
                Stack(
                  clipBehavior: Clip.antiAlias,
                  // overflow: Overflow.visible,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            height: 390,
                            decoration: BoxDecoration(
                                color: Colors.purple.shade300,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "You have 2 minutes to answer \n one question",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // const Text("Best of luck",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  Image.asset("assets/images/landing/quiz.jpg"),

                                  const SizedBox(
                                    height: 6,
                                  )
                                ],
                              ),
                            )),
                        Container(
                            width: double.infinity,
                            height: 28,
                            color: Colors.transparent),
                      ],
                    ),
                    Positioned(
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 150,
                          child: ElevatedButton.icon(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            icon: const Icon(Icons.play_circle_fill),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: QuizBody(selectedIndex: 0),
                                      type: PageTransitionType.rightToLeft));
                              // Navigator.popAndPushNamed(
                              //     context, QuizScreen.routeName);
                            },
                            label: const Text("Start Quiz"),
                          ),
                        ),
                      ),
                      right: 0,
                      left: 0,
                      bottom: 9,
                    ),
                    // Positioned(
                    //   child: FloatingActionButton(
                    //     child: ElevatedButton(
                    //       child: Container(),
                    //       onPressed: null,
                    //     ),
                    //     // child: const Icon(Icons.play_circle_fill),
                    //     // onPressed: () {
                    //     //   print('FAB tapped!');
                    //     // },
                    //     backgroundColor: Colors.blueGrey, onPressed: () {  },
                    //   ),
                    //
                    //   right: 0,
                    //   left: 0,
                    //   bottom: 0,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
