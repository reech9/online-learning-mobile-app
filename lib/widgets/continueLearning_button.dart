import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class continueLearningButton extends StatelessWidget {
  VoidCallback? onTap = () {};
  String title = "";
  IconData icon;

  continueLearningButton(
      {Key?key, this.onTap, required this.title, required this.icon}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            height: 70,
            width: 200,
            child: Row(
              children: [
                Expanded(
                  flex:2,
                    child:Text(
                  title,
                  style: const TextStyle(
                      color: kWhite,
                      fontSize: h6,
                      fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                )),

                 Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      height: 75,
                      width: 15,
                      child: Icon(icon),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
