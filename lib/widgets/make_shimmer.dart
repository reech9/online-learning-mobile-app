import 'package:flutter/material.dart';

Widget shimmerContainer ({double height = 200, double width = double.infinity, Color color =  Colors.white, double round = 5,
  EdgeInsets margin = const EdgeInsets.all(0),
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
} )=> Container(
  height: height,
  width: width,
  margin: margin,
  padding: padding,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(round),
    color: color
  ),
);

