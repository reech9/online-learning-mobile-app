import 'package:digi_school/configs/share.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/account_screen/components/about_you.dart';
import 'package:digi_school/screens/account_screen/components/account_card.dart';
import 'package:digi_school/screens/account_screen/components/acoount_settings.dart';
import 'package:digi_school/screens/account_screen/components/help_and_support.dart';
import 'package:digi_school/screens/login/login_email/loginemail_screen.dart';
import 'package:digi_school/screens/login/login_screen.dart';
import 'package:digi_school/screens/webview_screen/webview_screen.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';

class LoggedOutScreen extends StatefulWidget {
  const LoggedOutScreen({Key? key}) : super(key: key);

  @override
  _LoggedOutScreenState createState() => _LoggedOutScreenState();
}

class _LoggedOutScreenState extends State<LoggedOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kPrimaryColor, Colors.black])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: ScrollConfiguration(
                  behavior:
                  const ScrollBehavior().copyWith(overscroll: false),
                  child: CustomScrollView(slivers: <Widget>[
                    SliverAppBar(
                      toolbarHeight: 50,
                      titleSpacing: 10,
                      backgroundColor: Colors.transparent,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      title: Container(
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        height: 50,
                        decoration: BoxDecoration(
                          // color: Colors.red
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            scafoldHeader("Account")
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),

                          HelpAndSupport(),
                          SizedBox(height: 40,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("It seems like you're not signed in",style: TextStyle(color: kWhite),)),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: (){
                                Navigator.pushNamed(context, Loginemailscreen.routeName);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text("Sign in", style: TextStyle(
                                  color: kWhite,
                                  fontWeight: FontWeight.w600,
                                  fontSize: h5
                                ),)),
                          )
                        ],
                      ),
                    )
                  ]))),
        ));
  }
}
