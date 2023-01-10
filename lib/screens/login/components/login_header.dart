import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loginheader extends StatelessWidget {
  const Loginheader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          'Sign In',
          style: TextStyle(fontSize: h3,color: kWhite ,fontWeight: FontWeight.bold),
        ),

      ],
    );
  }
}
