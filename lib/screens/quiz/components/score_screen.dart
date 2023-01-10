// import 'package:digi_school/configs/api_response.config.dart';
// import 'package:digi_school/constants/colors.dart';
// import 'package:digi_school/screens/quiz/quiz_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
//
// class ScoreScreen extends StatefulWidget {
//   final data;
//   const ScoreScreen({Key? key, this.data}) : super(key: key);
//
//   @override
//   _ScoreScreenState createState() => _ScoreScreenState();
// }
//
// class _ScoreScreenState extends State<ScoreScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<QuizViewModel>(
//       create: (_) => QuizViewModel(),
//       child: ScoreBody(),
//     );
//   }
// }
//
// class ScoreBody extends StatefulWidget {
//   const ScoreBody({Key? key}) : super(key: key);
//
//   @override
//   _ScoreBodyState createState() => _ScoreBodyState();
// }
//
// class _ScoreBodyState extends State<ScoreBody> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       var _provider = Provider.of<QuizViewModel>(context, listen: false);
//
//       _provider.fetchScores("6295c75eb11c8f12710e88d7");
//     });
//     _showOverlay(context);
//     super.initState();
//   }
//
//   void _showOverlay(BuildContext context) async {
//     // Declaring and Initializing OverlayState
//     // and OverlayEntry objects
//     OverlayState? overlayState = Overlay.of(context);
//     OverlayEntry overlayEntry;
//     overlayEntry = OverlayEntry(builder: (context) {
//       // You can return any widget you like
//       // here to be displayed on the Overlay
//       return Container(
//         width: MediaQuery.of(context).size.width * 0.8,
//         child: Lottie.asset('assets/85744-success.json'),
//       );
//     });
//
//     // Inserting the OverlayEntry into the Overlay
//     overlayState?.insert(overlayEntry);
//
//     // Awaiting for 3 seconds
//     await Future.delayed(Duration(seconds: 3));
//
//     // Removing the OverlayEntry from the Overlay
//     overlayEntry.remove();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<QuizViewModel>(builder: (context, score, child) {
//       return Scaffold(
//           appBar: AppBar(
//               backgroundColor: kWhite,
//               iconTheme: const IconThemeData(color: kBlack),
//               elevation: 0.0,
//
//               // title: const Text(
//               //   "Quiz",
//               //   style: TextStyle(color: kBlack),
//               // ),
//               ),
//           body: isLoading(score.scoresApiResponse)
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : ListView(
//                   physics: const ScrollPhysics(),
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   children: [
//                     Column(
//                       children: [
//                         const Text('Congratulations, ',
//                         style:  TextStyle(
//                             color: Colors.green,
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold)),
//
//                          Text(score.score["user"]["firstname"]+" " + score.score["user"]["lastname"],
//                             style: const TextStyle(
//
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold)),
//
//                         RichText(
//                           textAlign: TextAlign.center,
//                           text: const TextSpan(
//                             text: 'You have passed quiz with \n result of ',
//                             style:  TextStyle(
//                               color: kBlack,
//                               fontStyle: FontStyle.italic,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             children: [
//                               TextSpan(
//                                 text: "80%",
//                                 style: TextStyle(
//                                   color: kBlack,
//                                   fontStyle: FontStyle.italic,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Stack(
//                       children: [
//                         Image.asset("assets/images/congrats.jpg"),
//                         Positioned(
//                             right: 135,
//                             top: 75,
//                             child: Text("80%",style: TextStyle(color: kWhite,fontSize: 22,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),))
//                       ],
//                     ),
//                     Container(
//                       height: 20,
//                       width: double.infinity,
//                       color: Colors.grey.shade200,
//                     ),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: score.score["logs"].length,
//                       physics: const ScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         var logs = score.score["logs"][index];
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 10.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               RichText(
//                                 text: TextSpan(
//                                   text: 'Q.',
//                                   style: const TextStyle(
//                                     color: kBlack,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   children: [
//                                     TextSpan(
//                                       text: logs["questionId"]["question"],
//                                       style: const TextStyle(
//                                         color: kBlack,
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: 15,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               ...List.generate(
//                                   logs["questionId"]["correct_answers"].length,
//                                   (l) {
//                                 var answers =
//                                     logs["questionId"]["correct_answers"][l];
//                                 return RichText(
//                                   text: TextSpan(
//                                     text: 'Answer: ',
//                                     style: const TextStyle(
//                                       color: kBlack,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     children: [
//                                       TextSpan(
//                                         text: answers,
//                                         style: const TextStyle(
//                                           color: kBlack,
//                                           fontWeight: FontWeight.normal,
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }),
//                               ...List.generate(logs["answer"].length, (l) {
//                                 var your_answer = logs["answer"][l];
//                                 return RichText(
//                                   text: TextSpan(
//                                     text: 'your answer: ',
//                                     style: const TextStyle(
//                                       color: kBlack,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     children: [
//                                       TextSpan(
//                                         text: your_answer,
//                                         style: const TextStyle(
//                                           color: kBlack,
//                                           fontWeight: FontWeight.normal,
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ));
//     });
//   }
// }
