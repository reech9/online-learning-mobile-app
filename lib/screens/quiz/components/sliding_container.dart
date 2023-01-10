import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/quiz/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SlideContainer extends StatelessWidget {
  bool isActive;
  int index;
  SlideContainer(this.isActive, this.index);

  @override
  Widget build(BuildContext context) {
    // return AnimatedContainer(
    //   duration: const Duration(milliseconds: 500),
    //   margin: const EdgeInsets.symmetric(horizontal: 10),
    //   height: isActive ? 12 : 8,
    //   width: isActive ? 12 : 8,
    //   decoration: BoxDecoration(
    //     color: isActive ? kBlack : Colors.grey,
    //     borderRadius: const BorderRadius.all(Radius.circular(12)),
    //   ),
    // );
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuizBody(selectedIndex: index),
              ));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: isActive ? 16 : 12,
          // width: isActive ? 50 : 60,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.grey.shade300,
            borderRadius: const BorderRadius.all(Radius.circular(1)),
          ),
        ),
      ),
    );
  }
}
