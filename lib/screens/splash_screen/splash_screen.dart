import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/notifications/fcm_service.dart';
import 'package:digi_school/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/environment.config.dart';
import '../../configs/preference.config.dart';
import '../navigation/navigation_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late AuthViewModel _auth;
  late CommonViewModel _common;
  Future<Widget> loginFuture() async {
    EnvironmentConfig.open = true;
    // remove this in prod
    await Future.delayed(const Duration(seconds: 2));
    await _auth.checkLogin();
    return Future.value(NavigationScreen(data: 0));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _auth = Provider.of<AuthViewModel>(context, listen: false);
    _common = Provider.of<CommonViewModel>(context, listen: false);
    loginFuture().then((data) {
      print("OPEN :: " + EnvironmentConfig.open.toString());
      if (EnvironmentConfig.queueRouteName != null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(
                builder: (context) => NavigationScreen(
                      data: 0,
                      redirect: EnvironmentConfig.queueRouteName.toString(),
                      args: EnvironmentConfig.queueArgs,
                    )))
            .then((value) {
          EnvironmentConfig.queueArgs = null;
          EnvironmentConfig.queueRouteName = null;
        });
        // Navigator.of(context).pushNamed("/");
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => data));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: SizedBox(
                  height: 100, child: Image.asset('assets/icons/logo.png'))),
          const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
