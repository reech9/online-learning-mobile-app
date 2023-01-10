import 'package:digi_school/configs/share.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/account_screen/components/account_card.dart';
import 'package:digi_school/screens/webview_screen/webview_screen.dart';
import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Help and Support", style: TextStyle(
                color: kWhite,
                fontWeight: FontWeight.w600
            ),)),
        SizedBox(height: 20,),
        AccountCard(
            title: "About Digischool",
            onTap: (){
              Navigator.pushNamed(context, WebViewScreen.routeName, arguments:"https://np.linkedin.com/company/digischool-nepal" );
            }),
        SizedBox(height: 20,),
        AccountCard(
            title: "Terms and Conditions",
            onTap: (){
              Navigator.pushNamed(context, WebViewScreen.routeName, arguments:"https://www.nccedu.com/study-centres/digi-school/" );
            }),
        SizedBox(height: 20,),
        AccountCard(
            title: "Frequently Asked Questions",
            onTap: (){
              Navigator.pushNamed(context, WebViewScreen.routeName, arguments:"https://www.nccedu.com/study-centres/digi-school/" );
            }),
        SizedBox(height: 20,),
        AccountCard(
            title: "Share Digischool",
            onTap: (){

              shareUrl("Digischool", "https://np.linkedin.com/company/digischool-nepal");
            }),
      ],
    );
  }
}
