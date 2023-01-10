import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AchievementCard extends StatefulWidget {
  AchievementCard({Key? key, this.title = "", this.image = "", this.onClick})
      : super(key: key);
  VoidCallback? onClick = () {};
  String title = "";
  String image = "";

  @override
  State<AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<AchievementCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: InkWell(
            onTap: () {
              if (widget.onClick != null) {
                widget.onClick!();
              }
            },
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/landing/certificateFront.png"))),
                ),
                 Container(
                   constraints: BoxConstraints(
                     maxHeight: double.infinity
                   ),

                  alignment: Alignment.center,
                  color: kPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
                    child: Text(widget.title,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: p0, fontWeight: FontWeight.w600, color: kWhite)),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),



    );


  }
}
