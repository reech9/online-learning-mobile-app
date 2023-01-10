import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:flutter/material.dart';

class CustomGenerateCertificateButton extends StatelessWidget {
  VoidCallback? onTap = (){};
  String title;

  CustomGenerateCertificateButton({Key? key, this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(10)
              ),
            ),
            height: 20,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                      title,
                  style: TextStyle(
                  fontSize: p1,
                  fontWeight: FontWeight.w600,
                  color: kWhite
                ),
                textAlign: TextAlign.center,
                ),

                )
              ],
            ),
          ),
        ],
      ),

    );
  }
}
