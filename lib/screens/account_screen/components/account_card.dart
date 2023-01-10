import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  AccountCard({Key? key, this.title="", required this.onTap}) : super(key: key);
  String title = "";
  VoidCallback onTap = (){};
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
              fontSize: h5, color: kWhite, fontWeight: FontWeight.w500
            )),
            Icon(Icons.chevron_right, color: kWhite,)
          ],
        ),
      ),
    );
  }
}
