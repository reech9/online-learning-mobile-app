import 'package:digi_school/screens/home_screen/components/home_item_list.dart';
import 'package:flutter/material.dart';

class Recommendationcoursedetail extends StatelessWidget {
  final demo;
  const Recommendationcoursedetail({Key? key,this.demo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: HomeItemList(
        title: "Students also bought",
        data: demo,
      )
    );
  }
}
