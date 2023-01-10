import 'package:digi_school/constants/fonts.dart';
import 'package:flutter/material.dart';

class InstructorFooter extends StatelessWidget {
  const InstructorFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FooterCard(icon: Icon(Icons.link), title: "Website"),
        FooterCard(icon: Icon(Icons.link), title: "Twitter"),
        FooterCard(icon: Icon(Icons.link), title: "Facebook"),
        FooterCard(icon: Icon(Icons.link), title: "LinkedIn"),
        FooterCard(icon: Icon(Icons.link), title: "Youtube"),
      ],
    );
  }
}


class FooterCard extends StatelessWidget {
  FooterCard({Key? key, required this.icon, required this.title}) : super(key: key);
  Icon icon;
  String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
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
                        child: icon)),
                Expanded(
                    flex: 6,
                    child: Text(title, style: TextStyle(
                        fontSize: p1
                    ),)),
                Expanded(flex: 1,child: Container(
                    alignment: Alignment.centerRight, child: Icon(Icons.chevron_right)))
              ],
            ),
          )),
    );
  }
}

