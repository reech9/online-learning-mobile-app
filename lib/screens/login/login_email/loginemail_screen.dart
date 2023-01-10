import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/forget_password/forget_password.dart';
import 'package:digi_school/screens/login/components/login_header.dart';
import 'package:digi_school/screens/login/login_email/loginemailwithpass_screen.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../register/register_email/registeremail_screen.dart';

class Loginemailscreen extends StatefulWidget {
  const Loginemailscreen({Key? key}) : super(key: key);
  static const String routeName = "/loginwithemail";
  
 
  @override
  _LoginemailscreenState createState() => _LoginemailscreenState();
}

class _LoginemailscreenState extends State<Loginemailscreen> {
  bool _isChecked = false;
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthViewModel _auth;

  @override
  void initState() {
    super.initState();
    _auth = Provider.of<AuthViewModel>(context, listen: false);
  }

  @override

  Icon visibilityicon = Icon(Icons.visibility,color: kWhite,);
  bool obscure = true;
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel,CommonViewModel>(builder: (context, auth,common, child) {
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
          body: Form(
            key: _formKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Email',
                            style: TextStyle(color: kWhite),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      child: TextFormField(
                        validator: (value){
                          if(value == ""){
                            return "Email can't be empty";
                          }else    if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value.toString())) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        style: TextStyle(color: kWhite),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kWhite)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kWhite)),

                          hintText: 'Enter valid email',
                          hintStyle: TextStyle(color: kWhite),
                        ),
                        controller: email_controller,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Password',
                            style: TextStyle(color: kWhite),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      child: TextFormField(
                        style: const TextStyle(color: kWhite),
                        obscureText: obscure,
                        validator: (value){
                          if(value == ""){
                            return "password can't be empty";
                          }
                          return null;
                        },
                        decoration:  InputDecoration(

                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kWhite)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kWhite)),
                          hintStyle: TextStyle(color: kWhite),
                          hintText: 'Password (8+ characters)',
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              if(obscure == true){
                                obscure = false;
                                visibilityicon = const Icon(Icons.visibility_off, color: kWhite,);
                              }
                              else{
                                obscure = true;
                                visibilityicon = const Icon(Icons.visibility, color: kWhite,);
                              }

                            });
                          }, icon: visibilityicon),

                        ),
                        controller: password_controller,
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [


                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgetPassword(),));
                              },
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(
                                    color: khyperlink,
                                    fontWeight: FontWeight.w600),
                              )),

                        ],
                      ),
                    ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'By clicking on "Sign in" you agree to \nour Terms of Use and Privacy Policy',
                    //       style: TextStyle(color: kWhite),
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [


                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: kWhite,
                                fixedSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )//background color of button
                              ),
                              onPressed: () {
                                auth.setLoginPassword(password_controller.text);
                                auth.setLoginEmail(email_controller.text);
                                common.setLoading(true);
                                auth.login().then((value) {
                                  if(_formKey.currentState!.validate()){
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
                                  }
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
                              )),
                          SizedBox(height: 20),

                          Container(
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Don\'t have an account?',
                                  style: TextStyle(
                                    color:kWhite,
                                    fontSize: 15
                                  ),
                                  children: [
                                    TextSpan(
                                      text: " Sign Up",
                                      style: TextStyle(
                                          color:khyperlink,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700
                                      ),
                                      recognizer: TapGestureRecognizer()
                                    ..onTap = (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Registerwithemailscreen(),));
                                    }
                                    )
                                  ]
                                  )
                                ),

                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

  }
}


















































































































































































































































































