import 'dart:convert';

import 'package:digi_school/api/api_response.dart';
import 'package:digi_school/api/repository/user_repository.dart';
import 'package:digi_school/api/request/forget_password_request.dart';
import 'package:digi_school/api/request/login_request.dart';
import 'package:digi_school/api/request/signup_request.dart';
import 'package:digi_school/api/response/common_response.dart';
import 'package:digi_school/api/response/forget_password_response.dart';
import 'package:digi_school/api/response/login_response.dart';
import 'package:digi_school/configs/preference.config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/request/password_reset_request.dart';
import 'api/request/updateprofile_request.dart';

class AuthViewModel with ChangeNotifier {
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  final SharedPreferences localStorage = PreferenceUtils.instance;

  String _email = "";
  String _password = "";
  String _firstname = "";
  String _lastname = "";
  String _fcm_token = "";
  String _panNumber = "";

  String get email => _email;
  String get password => _password;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get fcm_token => _fcm_token;
  String get panNumber => _panNumber;

  void setFcm(String fcm) {
    _fcm_token = fcm;
    notifyListeners();
  }

  setLoginEmail(String email) {
    _email = email;
    notifyListeners();
  }

  setPanNumber(String pan) {
    _panNumber = pan;

    notifyListeners();
  }

  setLoginPassword(String password) {
    _password = password;
    notifyListeners();
  }

  setRegisterFirstname(String firstname) {
    _firstname = firstname;
    notifyListeners();
  }

  setRegisterLastname(String lastname) {
    _lastname = lastname;
    notifyListeners();
  }

  ApiResponse _loginApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get loginApiResponse => _loginApiResponse;
  UserData _user = UserData();
  UserData get user => _user;

  Future<void> login() async {
    _loginApiResponse = ApiResponse.initial("Loading");
    notifyListeners();
    try {
      dynamic data = loginRequestToJson(LoginRequest(
          email: _email, password: _password, fcm_token: _fcm_token));
      print("Data :: " + data);
      LoginResponse res = await UserRepository().login(data);
      if (res.success == true) {
        _user = res.user!;
        _loggedIn = true;
        localStorage.setString("LOGGED_IN_USER", jsonEncode(_user));
        localStorage.setString("TOKEN", res.token!.accessToken.toString());
        localStorage.setString(
            "REFRESH_TOKEN", res.token!.refreshToken.toString());
        resetLoginCredential();
        _loginApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        print("ELSE :: " + res.msg.toString());
        _loginApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _loginApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  ApiResponse _forgetPasswordApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get forgetPasswordApiResponse => _forgetPasswordApiResponse;

  Future<void> resetPassword(emails) async {
    _forgetPasswordApiResponse = ApiResponse.initial("Loading");
    notifyListeners();
    try {
      dynamic data = forgetPasswordRequestToJson(ForgetPasswordRequest(
          email: emails));
      print("Data :: " + data);
      ForgetPasswordResponse res = await UserRepository().forgetPassword(data);
      if (res.success == true) {
        _forgetPasswordApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _forgetPasswordApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _forgetPasswordApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }




  ApiResponse _registerApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get registerApiResponse => _registerApiResponse;

  Future<void> register() async {
    _registerApiResponse = ApiResponse.initial("Loading");
    notifyListeners();
    try {
      dynamic data = signupRequestToJson(SignupRequest(
          email: _email,
          password: _password,
          firstname: _firstname,
          lastname: _lastname));
      print("Data :: " + data);
      CommonResponse res = await UserRepository().signup(data);
      if (res.success == true) {
        _registerApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _registerApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _registerApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> checkLogin() async {
    if (localStorage.containsKey("LOGGED_IN_USER") &&
        localStorage.containsKey("TOKEN") &&
        localStorage.containsKey("REFRESH_TOKEN")) {
      await UserRepository().checkLogin().then((value) {
        if (value) {
          try {
            _user = UserData.fromJson(
                jsonDecode(localStorage.getString("LOGGED_IN_USER")!));
            _loggedIn = true;
            notifyListeners();
          } catch (e) {
            print("LOGIN ERR:: " + e.toString());
            _loggedIn = false;
            _user = UserData();
          }
        } else {
          signout();
        }
      });
    } else {
      signout();
    }
    notifyListeners();
  }

  resetLoginCredential() {
    _email = "";
    _password = "";
  }

  // ApiResponse _passwordResetApiResponse = ApiResponse.initial("Empty Data");
  // ApiResponse get passwordResetApiResponse => _passwordResetApiResponse;
  //
  // Future<void> resetPassword(PasswordResetRequest request) async {
  //   _passwordResetApiResponse = ApiResponse.initial("Loading");
  //   notifyListeners();
  //   try {
  //     dynamic data = passwordResetRequestToJson(request);
  //     CommonResponse res = await UserRepository().passwordReset(data);
  //
  //     print("RESPNSE VM :: " + res.msg.toString());
  //     if (res.success == true) {
  //       _passwordResetApiResponse = ApiResponse.completed(res.msg.toString());
  //     } else {
  //       _passwordResetApiResponse = ApiResponse.error(res.msg.toString());
  //     }
  //   } catch (e) {
  //     _passwordResetApiResponse = ApiResponse.error(e.toString());
  //   }
  //   notifyListeners();
  // }

  ApiResponse _updateUserApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get updateUserApiResponse => _updateUserApiResponse;

  Future<void> updateProfile() async {
    _updateUserApiResponse = ApiResponse.initial("Loading");
    notifyListeners();
    try {
      dynamic data = updateProfileRequestToJson(UpdateProfileRequest(
          panNumber: _panNumber.toString(), firstname: _firstname, lastname: _lastname));
      print("Data :: " + data);
      CommonResponse res = await UserRepository().updateProfile(data);
      if (res.success == true) {

        localStorage.setString("LOGGED_IN_USER", jsonEncode(res.data));
        _updateUserApiResponse = ApiResponse.completed(res.msg.toString());
      } else {
        _updateUserApiResponse = ApiResponse.error(res.msg.toString());
      }
    } catch (e) {
      print("VM CATCH ERR :: " + e.toString());
      _updateUserApiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  void signout() {
    localStorage.remove("LOGGED_IN_USER");
    localStorage.remove("TOKEN");
    localStorage.remove("REFRESH_TOKEN");
    _user = UserData();
    _loggedIn = false;
    resetLoginCredential();
    notifyListeners();
  }
}
