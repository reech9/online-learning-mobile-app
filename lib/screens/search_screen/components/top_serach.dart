import 'dart:math';

import 'package:digi_school/screens/home_screen/components/category_list.dart';
import 'package:digi_school/screens/search_screen_single/search_screen_single.dart';
import 'package:digi_school/widgets/circular_container_outlined.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';

class TopSearchWidget extends StatefulWidget {
  const TopSearchWidget({Key? key}) : super(key: key);

  @override
  _TopSearchWidgetState createState() => _TopSearchWidgetState();
}

class _TopSearchWidgetState extends State<TopSearchWidget> {
  List<String> demo = ["Science", "Maths", "Computer", "Law", "English", "Physics", "Python", "Javascript", "Mongo", "SQL", "Oracle"];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),

      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          ...List.generate(demo.length, (index) =>
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: CircularContainerOutlined(title: demo[index].toString(), onTap: (){
                    Navigator.pushNamed(context, SearchScreenSingle.routeName);
                  },))
          )
        ],
      ),
    );
  }
}
