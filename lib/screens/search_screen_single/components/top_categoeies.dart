import 'package:flutter/material.dart';

import '../../../constants/fonts.dart';

class TopCategoriesWidget extends StatefulWidget {
  const TopCategoriesWidget({Key? key}) : super(key: key);

  @override
  _TopCategoriesWidgetState createState() => _TopCategoriesWidgetState();
}

class _TopCategoriesWidgetState extends State<TopCategoriesWidget> {
  List<Map<String, dynamic>> demo = [
    {"icon": Icons.supervisor_account_rounded, "title": "Category 1", "url": ""},
    {"icon": Icons.vpn_key, "title": "Category 2", "url": ""},
    {"icon": Icons.zoom_in_sharp, "title": "Category 3", "url": ""},
    {"icon": Icons.message, "title": "Category 4", "url": ""},
    {"icon": Icons.android, "title": "Category 5", "url": ""},{"icon": Icons.supervisor_account_rounded, "title": "Category 1", "url": ""},
    {"icon": Icons.vpn_key, "title": "Category 2", "url": ""},
    {"icon": Icons.zoom_in_sharp, "title": "Category 3", "url": ""},
    {"icon": Icons.message, "title": "Category 4", "url": ""},
    {"icon": Icons.android, "title": "Category 5", "url": ""},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(demo.length, (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                              child: Icon(demo[index]["icon"]), )),
                      Expanded(
                        flex: 3,
                          child: Text(demo[index]["title"].toString(), style: TextStyle(
                            fontSize: p1
                          ),)),
                      Expanded(flex: 1,child: Container(
                          alignment: Alignment.centerRight, child: Icon(Icons.chevron_right)))
                    ],
                ),
              )))
        ],
      ),
    );
  }
}
