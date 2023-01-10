import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/login/components/login_header.dart';
import 'package:digi_school/screens/login/login_email/loginemailwithpass_screen.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);
  static const String routeName = "/forget-password";
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final email_controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthViewModel _auth;

  @override
  void initState() {
    super.initState();
    _auth = Provider.of<AuthViewModel>(context, listen: false);
  }

  @override
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
                   const Text("Reset Password",style: TextStyle(fontSize: h3,color: kWhite ,fontWeight: FontWeight.bold),),
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
                        style: const TextStyle(color: kWhite),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kWhite)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kWhite)),

                          hintText: 'Enter your email address',
                          hintStyle: TextStyle(color: kWhite),
                        ),
                        controller: email_controller,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: kWhite, //background color of button
                              ),
                              onPressed: () {

                                common.setLoading(true);
                                auth.resetPassword(email_controller.text).then((value) {
                                  if(_formKey.currentState!.validate()){
                                    if (!isError(auth.forgetPasswordApiResponse)) {
                                      snackThis(
                                          context: context,
                                          color: Colors.green,
                                          content: const Text("We have sent mail for password reset"),
                                          duration: 3);

                                      Navigator.pop(context);

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
                                'Submit',
                                style: TextStyle(color: kBlack),
                              )),
                        ),
                      ],
                    )
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20.0, vertical: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //             primary: kWhite, //background color of button
                    //           ),
                    //           onPressed: () {
                    //             auth.setLoginEmail(email_controller.text);
                    //             Navigator.push(
                    //                 context,
                    //                 PageTransition(
                    //                     child: Loginemailwithpasswordscreen(
                    //                         email: email_controller.text),
                    //                     type: PageTransitionType.rightToLeft));
                    //           },
                    //           child: const Text(
                    //             'Next',
                    //             style: TextStyle(color: kBlack),
                    //           ))
                    //     ],
                    //   ),
                    // )
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
