import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/login/components/facebook_login.dart';
import 'package:digi_school/screens/login/components/google_login.dart';
import 'package:digi_school/screens/login/components/login_header.dart';
import 'package:digi_school/screens/login/login_email/loginemail_screen.dart';
import 'package:digi_school/screens/register/register_email/registeremail_screen.dart';
import 'package:digi_school/screens/register/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernamecontroller = new TextEditingController();
  final _passwordcontroller = new TextEditingController();
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            const Loginheader(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'By using our services you are agreeing to \n our',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text: ' Terms ',
                      style: TextStyle(
                        color: kWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: 'and',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: ' Privacy Statement ',
                      style: TextStyle(
                        color: khyperlink,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: _loginButtons(
                    "Sign in with email",
                    const Icon(
                      Icons.email_outlined,
                      color: kWhite,
                    ), () {
                  Navigator.pushNamed(context, Loginemailscreen.routeName);
                })),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: _loginButtons(
                    "Sign in with gmail",
                    SvgPicture.asset(
                      "assets/icons/svg/google.svg",
                      height: 20,
                      width: 20,
                    ),
                    () {})),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: _loginButtons(
                    "Sign in with facebook",
                    SvgPicture.asset(
                      "assets/icons/svg/facebook.svg",
                      height: 20,
                      width: 20,
                    ),
                    () {})),
            SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'New here? ',
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                              context, Registerwithemailscreen.routeName);
                        },
                      text: ' Create an account ',
                      style: const TextStyle(
                        color: khyperlink,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loginButtons(String loginWith, Widget icons, void Function() _ontap) {
    return InkWell(
      onTap: _ontap,
      child: Container(
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icons,
            const SizedBox(
              width: 10,
            ),
            Text(
              loginWith,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: kWhite),
            )
          ],
        ),
        decoration: BoxDecoration(border: Border.all(width: 1, color: kWhite)),
      ),
    );
  }
}
