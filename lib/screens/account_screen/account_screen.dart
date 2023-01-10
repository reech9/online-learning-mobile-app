import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/screens/account_screen/components/logged_in.dart';
import 'package:digi_school/screens/account_screen/components/logged_out.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
        builder: (context, data, child) {
          return data.loggedIn ? LoggedInScreen() : LoggedOutScreen();
        }
    );
  }
}