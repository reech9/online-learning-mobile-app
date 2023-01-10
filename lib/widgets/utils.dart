import 'package:digi_school/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/fonts.dart';


Widget backButton(BuildContext context){
  return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.chevron_left,
        size: 30,
        color: kBlack,
      ));
}

Widget scafoldHeader(String title){
  return Text(
    title, style: TextStyle(
      color: kWhite,
      fontWeight: FontWeight.w600,
      fontSize: h5,

  ),
  );
}
//
// Widget appBarIcon(String ){
//   return InkWell(
//     onTap: (){
//       Navigator.of(context).pop();
//     },
//       child: Icon(
//         Icons.chevron_left,
//         size: 30,
//         color: kWhite,
//       ));
//
// }
