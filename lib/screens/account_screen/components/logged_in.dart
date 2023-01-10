import 'dart:convert';

import 'package:digi_school/api/response/login_response.dart';
import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/account_screen/components/about_you.dart';
import 'package:digi_school/screens/account_screen/components/acoount_settings.dart';
import 'package:digi_school/screens/account_screen/components/change_theme.dart';
import 'package:digi_school/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:day_night_switch/day_night_switch.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../configs/preference.config.dart';
import '../../../widgets/utils.dart';
import 'help_and_support.dart';

class LoggedInScreen extends StatefulWidget {
  const LoggedInScreen({Key? key}) : super(key: key);

  @override
  _LoggedInScreenState createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  var _darkTheme = true;


  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CommonViewModel>(context,listen:false).getMyDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<CommonViewModel>(context);
    // _darkTheme = (themeNotifier.getTheme() == MyThemes().darkTheme);
    return Consumer2<AuthViewModel, CommonViewModel>(
        builder: (context, auth, common, child) {
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
                        behavior: const ScrollBehavior().copyWith(overscroll: false),
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
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.horizontal()
                                // color: Colors.red
                              ),
                              padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [scafoldHeader("Account")],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                AboutYou(user: common.userDetail),
                                // ListTile(
                                //   title: Text('Dark Theme'),
                                //   contentPadding: const EdgeInsets.only(left: 16.0),
                                //   trailing: Transform.scale(
                                //     scale: 0.4,
                                //     child: DayNightSwitch(
                                //       value: _darkTheme,
                                //       onChanged: (val) {
                                //         setState(() {
                                //           _darkTheme = val;
                                //         });
                                //         onThemeChanged(val, themeNotifier);
                                //       },
                                //     ),
                                //   ),
                                // )
                                AccountSetting(),
                                SizedBox(
                                  height: 20,
                                ),
                                HelpAndSupport(),
                                SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () {


                                    auth.signout();
                                    common.signout();
                                  },

                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "Sign Out",
                                        style: TextStyle(
                                            color: kWhite,
                                            fontWeight: FontWeight.w600,
                                            fontSize: h5),
                                      )),
                                ),

                              ],
                            ),
                          )
                        ]))),
              ));
        });
  }
}