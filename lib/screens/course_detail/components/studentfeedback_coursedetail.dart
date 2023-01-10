import 'package:digi_school/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Studentfeedbackcoursedetail extends StatefulWidget {
  final data;
  const Studentfeedbackcoursedetail({Key? key, this.data}) : super(key: key);

  @override
  State<Studentfeedbackcoursedetail> createState() =>
      _StudentfeedbackcoursedetailState();
}

class _StudentfeedbackcoursedetailState
    extends State<Studentfeedbackcoursedetail> {
  @override
  Widget build(BuildContext context) {
    return Container();

    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Container(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         const Text(
    //           "Student Feedback",
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    //         ),
    //         SizedBox(
    //           height: 15,
    //         ),
    //         RichText(
    //           textAlign: TextAlign.center,
    //           text: const TextSpan(
    //             text: '4.7',
    //             style: TextStyle(
    //               color: kBlack,
    //               fontWeight: FontWeight.bold,
    //               fontSize: 18,
    //             ),
    //             children: [
    //               TextSpan(
    //                 text: ' course rating ',
    //                 style: TextStyle(
    //                   color: kBlack,
    //                   fontWeight: FontWeight.normal,
    //                   fontSize: 15,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 15,
    //         ),
    //         Row(
    //           children: [
    //             Expanded(
    //                 flex: 3,
    //                 child: Container(
    //                     height: 33,
    //                     child: Column(
    //                       children: [
    //                         SizedBox(
    //                           height: 3,
    //                         ),
    //                         Container(
    //                           height: 22,
    //                           color: Colors.grey.shade100,
    //                         ),
    //                         SizedBox(
    //                           height: 6,
    //                         ),
    //                       ],
    //                     ))),
    //             Expanded(
    //                 flex: 2,
    //                 child: Container(
    //                   height: 30,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       SmoothStarRating(
    //                         allowHalfRating: false,
    //                         rating: 5,
    //                         isReadOnly: true,
    //                         size: 20,
    //                         starCount: 5,
    //                         color: Colors.yellow.shade700,
    //                         borderColor: Colors.yellow.shade700,
    //                         spacing: 0.0,
    //                         // color: ,
    //                       ),
    //                       const Text("61%")
    //                     ],
    //                   ),
    //                 )),
    //           ],
    //         ),
    //         Row(
    //           children: [
    //             Expanded(
    //                 flex: 3,
    //                 child: Container(
    //                     height: 33,
    //                     child: Column(
    //                       children: [
    //                         SizedBox(
    //                           height: 3,
    //                         ),
    //                         Container(
    //                           height: 22,
    //                           color: Colors.grey.shade100,
    //                         ),
    //                         SizedBox(
    //                           height: 6,
    //                         ),
    //                       ],
    //                     ))),
    //             Expanded(
    //                 flex: 2,
    //                 child: Container(
    //                   height: 30,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       SmoothStarRating(
    //                         allowHalfRating: false,
    //                         rating: 4,
    //                         isReadOnly: true,
    //                         size: 20,
    //                         starCount: 5,
    //                         color: Colors.yellow.shade700,
    //                         borderColor: Colors.yellow.shade700,
    //                         spacing: 0.0,
    //                         // color: ,
    //                       ),
    //                       const Text("56%")
    //                     ],
    //                   ),
    //                 )),
    //           ],
    //         ),
    //         Row(
    //           children: [
    //             Expanded(
    //                 flex: 3,
    //                 child: Container(
    //                     height: 33,
    //                     child: Column(
    //                       children: [
    //                         SizedBox(
    //                           height: 3,
    //                         ),
    //                         Container(
    //                           height: 22,
    //                           color: Colors.grey.shade100,
    //                         ),
    //                         SizedBox(
    //                           height: 6,
    //                         ),
    //                       ],
    //                     ))),
    //             Expanded(
    //                 flex: 2,
    //                 child: Container(
    //                   height: 30,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       SmoothStarRating(
    //                         allowHalfRating: false,
    //                         rating: 3,
    //                         isReadOnly: true,
    //                         size: 20,
    //                         starCount: 5,
    //                         color: Colors.yellow.shade700,
    //                         borderColor: Colors.yellow.shade700,
    //                         spacing: 0.0,
    //                         // color: ,
    //                       ),
    //                       const Text("23%")
    //                     ],
    //                   ),
    //                 )),
    //           ],
    //         ),
    //         Row(
    //           children: [
    //             Expanded(
    //                 flex: 3,
    //                 child: Container(
    //                     height: 33,
    //                     child: Column(
    //                       children: [
    //                         SizedBox(
    //                           height: 3,
    //                         ),
    //                         Container(
    //                           height: 22,
    //                           color: Colors.grey.shade100,
    //                         ),
    //                         SizedBox(
    //                           height: 6,
    //                         ),
    //                       ],
    //                     ))),
    //             Expanded(
    //                 flex: 2,
    //                 child: Container(
    //                   height: 30,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       SmoothStarRating(
    //                         allowHalfRating: false,
    //                         rating: 2,
    //                         isReadOnly: true,
    //                         size: 20,
    //                         starCount: 5,
    //                         color: Colors.yellow.shade700,
    //                         borderColor: Colors.yellow.shade700,
    //                         spacing: 0.0,
    //                         // color: ,
    //                       ),
    //                       const Text("10%")
    //                     ],
    //                   ),
    //                 )),
    //           ],
    //         ),
    //         Row(
    //           children: [
    //             Expanded(
    //                 flex: 3,
    //                 child: Container(
    //                     height: 33,
    //                     child: Column(
    //                       children: [
    //                         SizedBox(
    //                           height: 3,
    //                         ),
    //                         Container(
    //                           height: 22,
    //                           color: Colors.grey.shade100,
    //                         ),
    //                         SizedBox(
    //                           height: 6,
    //                         ),
    //                       ],
    //                     ))),
    //             Expanded(
    //                 flex: 2,
    //                 child: Container(
    //                   height: 30,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       SmoothStarRating(
    //                         allowHalfRating: false,
    //                         rating: 1,
    //                         isReadOnly: true,
    //                         size: 20,
    //                         starCount: 5,
    //                         color: Colors.yellow.shade700,
    //                         borderColor: Colors.yellow.shade700,
    //                         spacing: 0.0,
    //                         // color: ,
    //                       ),
    //                       const Text("0%")
    //                     ],
    //                   ),
    //                 )),
    //           ],
    //         ),
    //         _feedbacks(widget.data),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             width: double.infinity,
    //             height: 50,
    //             child: TextButton(
    //                 style: ButtonStyle(
    //                   side: MaterialStateProperty.all(
    //                     const BorderSide(width: 1, color: Colors.black),
    //                   ),
    //                 ),
    //                 child: const Text(
    //                   "See more reviews",
    //                   style: TextStyle(color: kBlack,fontWeight: FontWeight.bold),
    //                 ),
    //                 onPressed: () {}),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _feedbacks(dynamic data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(data.length, (index) {
          var feedback = data[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feedback['firstname'] + " " + feedback['lastname'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Row(
                children: [
                  SmoothStarRating(
                    allowHalfRating: false,
                    rating: feedback['ratings'].toDouble(),
                    isReadOnly: true,
                    size: 16,
                    starCount: 5,
                    color: Colors.yellow.shade700,
                    borderColor: Colors.yellow.shade700,
                    spacing: 0.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    feedback['createdAt'] + " ago",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )
                ],
              ),
              ReadMoreText(
                feedback['feedback'],
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16
                ),
                trimLines: 3,
                // colorClickableText: Colors.blueAccent,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Read more',
                trimExpandedText: ' Less',
                textAlign: TextAlign.justify,
                moreStyle: const TextStyle(
                    fontSize: 16,
                    color: khyperlink,
                    fontWeight: FontWeight.bold),
                lessStyle: const TextStyle(
                    fontSize: 16,
                    color: khyperlink,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15,),

            ],
          );
        })
      ],
    );
  }
}
