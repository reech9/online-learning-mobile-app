import 'dart:convert';

import 'package:digi_school/api/repository/user_repository.dart';
import 'package:digi_school/api/request/signup_request.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Registerwithemailscreen extends StatefulWidget {
  const Registerwithemailscreen({Key? key}) : super(key: key);

  static const String routeName = "/registerwithemail";

  @override
  _RegisterwithemailscreenState createState() =>
      _RegisterwithemailscreenState();
}

class _RegisterwithemailscreenState extends State<Registerwithemailscreen> {
  final firstname_controller = TextEditingController();
  final lastname_controller = TextEditingController();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirm_passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;

  bool validatePassword(String pass){
    String _password = pass.trim();
    if(_password.isEmpty){
      setState(() {
        password_strength = 0;
      });
    }else if(_password.length < 6 ){
      setState(() {
        password_strength = 1 / 4;
      });
    }else if(_password.length < 8){
      setState(() {
        password_strength = 2 / 4;
      });
    }else{
      if(pass_valid.hasMatch(_password)){
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      }else{
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }
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
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
        body: Consumer2<AuthViewModel, CommonViewModel>(
            builder: (context, auth, common, child) {
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Create an account',
                      style:
                          TextStyle(fontSize: h5,color: kWhite ,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text:
                          'By clicking on "Create account" you agree to \n our',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: ' Terms of use ',
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
                          text: ' Privacy Policy ',
                          style: TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: register_form(
                              "Firstname", firstname_controller, "firstname")),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: register_form(
                              "Lastname", lastname_controller, "lastname")),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: register_form("Email", email_controller, "email")),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: password_field(
                        "Password (8+ characters)", password_controller)),

                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: confirm_password(
                        "Confirm Password", confirm_passwordcontroller)),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: LinearProgressIndicator(
                    value: password_strength,
                    backgroundColor: Colors.grey[300],
                    minHeight: 5,
                    color: password_strength <= 1 / 4
                        ? Colors.red
                        : password_strength == 2 / 4
                        ? Colors.yellow
                        : password_strength == 3 / 4
                        ? Colors.blue
                        : Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kWhite, //background color of button
                      ),
                      onPressed: () async {
                        auth.setLoginEmail(email_controller.text);
                        auth.setLoginPassword(password_controller.text);
                        auth.setRegisterFirstname(firstname_controller.text);
                        auth.setRegisterLastname(lastname_controller.text);
                        common.setLoading(true);
                        auth.register().then((value) {
                          if (_formKey.currentState!.validate()) {

                            if (!isError(auth.registerApiResponse)) {
                              snackThis(
                                  context: context,
                                  color: Colors.green,
                                  content: const Text(
                                      "Sign up successful, Please verify your email"),
                                  duration: 3);
                              // Navigator.popUntil(context, (route) => route.isFirst);
                              email_controller.clear();
                              password_controller.clear();
                              firstname_controller.clear();
                              lastname_controller.clear();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            } else {
                              snackThis(
                                  context: context,
                                  color: Colors.red,
                                  content: Text(auth.registerApiResponse.message
                                      .toString()),
                                  duration: 3);
                            }
                          }
                          // print(auth.loginApiResponse.toString());
                          common.setLoading(false);
                        }).catchError((e) {
                          snackThis(
                              context: context,
                              color: Colors.red,
                              content: Text(
                                  auth.registerApiResponse.message.toString()),
                              duration: 3);
                          common.setLoading(false);
                        });
                        // common.setLoading(true);
                        // final data =  SignupRequest(email: email_controller.text,firstname: firstname_controller.text,lastname: lastname_controller.text,password: password_controller.text);
                        // CommonResponse res = await UserRepository().signup(jsonEncode(data));
                        // try {
                        //
                        //   if(_formKey.currentState!.validate()){
                        //     if(res.success == true){
                        //       common.setLoading(true);
                        //       snackThis(
                        //           color: Colors.green,
                        //           duration: 2,
                        //           content: Text(res.message.toString()),
                        //           context: context);
                        //       common.setLoading(false);
                        //
                        //     }else{
                        //       common.setLoading(true);
                        //       snackThis(
                        //           color: Colors.red,
                        //           duration: 2,
                        //           content: Text(res.message.toString()),
                        //           context: context);
                        //       common.setLoading(false);
                        //     }
                        //   }
                        // } on Exception catch (e) {
                        //   common.setLoading(true);
                        //   snackThis(
                        //       color: Colors.red,
                        //       duration: 2,
                        //       content: Text(e.toString()),
                        //       context: context);
                        //   common.setLoading(false);
                        //   // TODO
                        // }
                      },
                      child: const Text("Create Account",style: TextStyle(color: kBlack),)),
                ),
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
          );
        }),
      ),
    );
  }

  Widget register_form(
      String hint, TextEditingController controller, String validator) {
    return TextFormField(

      validator: (value) {
        // Null check

        if (validator == "email") {
          if (value == "") {
            return 'Please enter your email';
          }
          if (!RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value.toString())) {
            return "Please enter a valid email";
          }
        } else if (validator == "firstname" || validator == "lastname") {
          if (value == "") {
            return "Field can't be empty";
          }
        }
        // success condition
        return null;
      },
      style: TextStyle(color: kWhite),
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: kWhite),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: kWhite)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: kWhite)),
        hintText: hint,
      ),
      controller: controller,
    );
  }

  Icon icon = Icon(Icons.visibility,color: kWhite,);
  bool obscure = true;

  Icon icon2 = Icon(Icons.visibility,color: kWhite,);
  bool obscure2 = true;

  Widget password_field(String hint, TextEditingController controller) {
    return TextFormField(

      onChanged: (value){
        _formKey.currentState!.validate();
      },
      obscureText: obscure,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter password";
        }
        else{
          //call function to check password
          bool result = validatePassword(value);
          if(result){
            // create account event
            return null;
          }
          else{
            return " Password should contain Capital, small letter, Number & Special character";
          }
        }
      },
      // validator: (value) {
      //   if (value == "") {
      //     return "Please Enter Password";
      //   } else if (value!.length < 6) {
      //     return "Password must be atleast 6 characters long";
      //   } else if(password_controller.text != confirm_passwordcontroller.text){
      //     return "Password didn't match";
      //   }
      //
      //   else {
      //     return null;
      //   }
      // },
      style: TextStyle(color: kWhite),
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: kWhite)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: kWhite)),
        hintStyle: const TextStyle(color: kWhite),
        hintText: hint,
        suffixIcon:  IconButton(
            onPressed: () {
              setState(() {
                if (obscure == true) {
                  obscure = false;
                  icon = const Icon(Icons.visibility_off,color: kWhite,);
                } else {
                  obscure = true;
                  icon = const Icon(Icons.visibility,color: kWhite,);
                }
              });
            },
            icon: icon),
      ),
      controller: controller,
    );
  }
  Widget
  confirm_password(String hint, TextEditingController controller) {
    return TextFormField(
      onChanged: (value){
        _formKey.currentState!.validate();
      },
      obscureText: obscure2,
      validator: (value){
        if(password_controller.text != confirm_passwordcontroller.text){
          return "Password didn't match";
        }
        else return null;

      },
      // validator: (value) {
      //   if (value == "") {
      //     return "Please Enter Password";
      //   } else if (value!.length < 6) {
      //     return "Password must be atleast 6 characters long";
      //   } else if(password_controller.text != confirm_passwordcontroller.text){
      //     return "Password didn't match";
      //   }
      //
      //   else {
      //     return null;
      //   }
      // },
      style: TextStyle(color: kWhite),
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: kWhite)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: kWhite)),
        hintStyle: const TextStyle(color: kWhite),
        hintText: hint,
        suffixIcon:  IconButton(
            onPressed: () {
              setState(() {
                if (obscure2 == true) {
                  obscure2 = false;
                  icon2 = const Icon(Icons.visibility_off,color: kWhite,);
                } else {
                  obscure = true;
                  icon2 = const Icon(Icons.visibility,color: kWhite,);
                }
              });
            },
            icon: icon2),
      ),
      controller: controller,
    );
  }
}
