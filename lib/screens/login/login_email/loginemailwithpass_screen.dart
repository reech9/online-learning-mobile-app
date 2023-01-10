import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/home_screen/home_screen.dart';
import 'package:digi_school/screens/register/register_email/registeremail_screen.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loginemailwithpasswordscreen extends StatefulWidget {
  final email;
  const Loginemailwithpasswordscreen({Key? key, this.email}) : super(key: key);
  static const String routeName = "/loginwithemailpass";
  @override
  _LoginemailwithpasswordscreenState createState() =>
      _LoginemailwithpasswordscreenState();
}

class _LoginemailwithpasswordscreenState
    extends State<Loginemailwithpasswordscreen> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Almost there!",
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: h5),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Enter your password to sign with",
                      style: TextStyle(color: kWhite),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.email,
                      style: TextStyle(color: kWhite),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    child: TextFormField(
                      style: TextStyle(color: kWhite),
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kWhite)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kWhite)),
                        hintStyle: TextStyle(color: kWhite),
                        hintText: 'Password (8+ characters)',
                      ),
                      controller: password_controller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(color: khyperlink),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kWhite, //background color of button
                            ),
                            onPressed: () {
                              auth.setLoginPassword(password_controller.text);
                              common.setLoading(true);
                              auth.login().then((value) {
                                if (!isError(auth.loginApiResponse)) {
                                  snackThis(
                                      context: context,
                                      color: Colors.green,
                                      content: const Text("Login successful"),
                                      duration: 3);
                                  common.signin();
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                } else {
                                  snackThis(
                                      context: context,
                                      color: Colors.red,
                                      content: Text(auth
                                          .loginApiResponse.message
                                          .toString()),
                                      duration: 3);
                                }
                                // print(auth.loginApiResponse.toString());
                                common.setLoading(false);
                              }).catchError((e) {
                                snackThis(
                                    context: context,
                                    color: Colors.red,
                                    content: Text(auth.loginApiResponse.message
                                        .toString()),
                                    duration: 3);
                                common.setLoading(false);
                              });
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: kBlack),
                            ))
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'By clicking on "Sign in" you agree to \nour Terms of Use and Privacy Policy',
                        style: TextStyle(color: kWhite),
                      ),
                    ],
                  ),
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
              )
            ],
          ),
        ),
      );
    });
  }
}
