import 'package:digi_school/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/fonts.dart';

class CircularContainerOutlined extends StatelessWidget {
  CircularContainerOutlined({Key? key, this.title="", this.onTap}) : super(key: key);
  String title = "";
  VoidCallback? onTap  = (){};
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          // border: Bo,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: kWhite,
              width: 1
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          title.toString(),
          style: TextStyle(
              color: kWhite,
              fontSize: p1,

          ),
        ),
      ),
    );
  }
}
