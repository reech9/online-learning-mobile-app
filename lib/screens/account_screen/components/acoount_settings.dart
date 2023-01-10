import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/account_profile_screen/account_profile_screen.dart';
import 'package:digi_school/screens/account_screen/components/account_card.dart';
import 'package:digi_school/screens/account_security_screen/account_security_screen.dart';
import 'package:flutter/material.dart';

import 'my_achievements_screen.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Account Settings",
              style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w600),
            )),
        const SizedBox(
          height: 20,
        ),
        AccountCard(
            title: "About you",
            onTap: () {
              Navigator.pushNamed(context, AccountProfileScreen.routeName);
            }),
        const SizedBox(
          height: 20,
        ),
        AccountCard(
            title: "Account security",
            onTap: () {
              Navigator.of(context).pushNamed(AccountSecurityScreen.routeName);
            }),
        const SizedBox(
          height: 20,
        ),
        AccountCard(
            title: "My Achievements",
            onTap: (){
              Navigator.of(context).pushNamed(MyAchievement.routeName);
            })
      ],
    );
  }
}