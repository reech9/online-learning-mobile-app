import 'package:digi_school/api/request/password_reset_request.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth_viewmodel.dart';
import '../../configs/api_response.config.dart';

class AccountSecurityScreen extends StatefulWidget {
  AccountSecurityScreen({Key? key}) : super(key: key);
  static const String routeName = "/account-security";

  @override
  _AccountSecurityScreenState createState() => _AccountSecurityScreenState();
}

class _AccountSecurityScreenState extends State<AccountSecurityScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  TextEditingController _passwordConfirm2Controller = TextEditingController();

  FocusNode _passwordNode = FocusNode();
  FocusNode _passwordConfirmNode = FocusNode();
  FocusNode _passwordConfirm2Node = FocusNode();
  final _formKey = GlobalKey<FormState>();

  void _requestFocus(_focusNode) {
    setState(() {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, CommonViewModel>(
        builder: (context, auth, common, child) {
        return Scaffold(

            bottomNavigationBar: Container(
              child: Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(
                          -2, 0), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            child:
                            ElevatedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: kPrimaryColor, width: 1),

                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text("Back", style: TextStyle(
                                color: kBlack
                            ),)))),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      kPrimaryColor),
                                ),
                                onPressed: () {
                                  try{
                                    common.setLoading(true);
                                    if(_formKey.currentState!.validate()){
                                      auth.resetPassword(PasswordResetRequest(
                                        email: auth.user.email,
                                        oldPassword: _passwordController.text.toString(),
                                        password: _passwordConfirm2Controller.text.toString()
                                      )).then((value) {
                                        if(isError(auth.forgetPasswordApiResponse)){
                                          snackThis(context: context, color: Colors.red, content: Text(auth.forgetPasswordApiResponse.data.toString()), );
                                        }else{
                                          snackThis(context: context, color: Colors.green, content: Text(auth.forgetPasswordApiResponse.data.toString()), );
                                        }
                                        common.setLoading(false);
                                      });
                                    }

                                  }catch(e){
                                    common.setLoading(false);
                                    print(e.toString());
                                  }
                                }, child: Text("Save")))),
                  ],
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: Container(
                  color: kWhite,
                  child: SafeArea(
                      child: ScrollConfiguration(
                          behavior:
                              const ScrollBehavior().copyWith(overscroll: false),
                          child: CustomScrollView(slivers: <Widget>[
                            SliverAppBar(
                              toolbarHeight: 50,
                              backgroundColor: kWhite,
                              pinned: true,
                              automaticallyImplyLeading: true,
                              leading: backButton(context),
                              titleSpacing: 0,
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
                                    Text(
                                      "Account Security",
                                      style: TextStyle(
                                          color: kBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: h5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  SizedBox(height: 40,),
                                  Text("Reset password", style: TextStyle(
                                    color: kBlack, fontSize: h5,
                                    fontWeight: FontWeight.w600
                                  ),),
                                  SizedBox(height: 10,),
                                  Text("The password should have atleast 6 charaters.", style: TextStyle(
                                    color: gray_600, fontSize: p2
                                  ),),
                                  SizedBox(height: 40,),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                    child: TextFormField(
                                      focusNode: _passwordNode,
                                      onTap: ()=>_requestFocus(_passwordNode),
                                      enabled: true,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      validator: (value) {
                                        // Null check
                                        if (value == "") {
                                          return 'Please enter password';
                                        }
                                        // success condition
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter your old password",
                                          fillColor: gray_100,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: -10, horizontal: 10),
                                          filled: true,
                                          enabledBorder:
                                          const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: gray_500)),
                                          focusColor: kPrimaryColor,
                                          focusedBorder:
                                          const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor)),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                          label: Text("Old Password", style: TextStyle(
                                              color: kPrimaryColor
                                          ),)),
                                      controller: _passwordController,
                                    ),
                                  ),
                                  SizedBox(height: 10,),

                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                    child: TextFormField(
                                      focusNode: _passwordConfirmNode,
                                      onTap: ()=>_requestFocus(_passwordConfirmNode),
                                      enabled: true,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      validator: (value) {
                                        // Null check
                                        if (value == "") {
                                          return 'Please enter new password';
                                        }
                                        // success condition
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter your new password",
                                          fillColor: gray_100,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: -10, horizontal: 10),
                                          filled: true,
                                          enabledBorder:
                                          const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: gray_500)),
                                          focusColor: kPrimaryColor,
                                          focusedBorder:
                                          const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor)),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                          label: Text("New Password", style: TextStyle(
                                              color: kPrimaryColor
                                          ),)),
                                      controller: _passwordConfirmController,
                                    ),
                                  ),
                                  SizedBox(height: 10,),

                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                    child: TextFormField(
                                      focusNode: _passwordConfirm2Node,
                                      onTap: ()=>_requestFocus(_passwordConfirm2Node),
                                      enabled: true,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      validator: (value) {
                                        // Null check
                                        if (value == "") {
                                          return 'Please enter confirm password';
                                        }
                                        // success condition
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter your new password",
                                          fillColor: gray_100,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: -10, horizontal: 10),
                                          filled: true,
                                          enabledBorder:
                                          const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: gray_500)),
                                          focusColor: kPrimaryColor,
                                          focusedBorder:
                                          const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor)),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                          label: Text("Confirm Password", style: TextStyle(
                                              color: kPrimaryColor
                                          ),)),
                                      controller: _passwordConfirm2Controller,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                            )
                          ])))),
            ));
      }
    );
  }
}
