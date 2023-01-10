import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/login/components/login_header.dart';
import 'package:digi_school/screens/login/login_screen.dart';
import 'package:digi_school/screens/register/register_email/registeremail_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String routeName = "/register";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Create an account',
                  style: TextStyle(fontSize: h5,color: kWhite ,fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
                child: _registerButtons(
                    "Sign up with email", const Icon(Icons.email_outlined,color: kWhite,), () {
                  Navigator.pushNamed(context, Registerwithemailscreen.routeName);
                })),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: _registerButtons(
                    "Sign up with gmail",
                    SvgPicture.asset(
                      "assets/icons/svg/google.svg",
                      height: 20,
                      width: 20,
                    ),
                    () {})),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: _registerButtons(
                    "Sign up with facebook",
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
                  text: 'Have an Account ? ',
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pop();
                        },
                      text: ' Sign in ',
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

  Widget _registerButtons(String loginWith, Widget icons, Function() _ontap) {
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
              style: const TextStyle(color: kWhite,fontWeight: FontWeight.bold),
            )
          ],
        ),
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: kWhite)),
      ),
    );
  }
}
