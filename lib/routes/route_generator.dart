import 'dart:convert';
import 'package:digi_school/screens/account_profile_screen/account_profile_screen.dart';
import 'package:digi_school/screens/account_screen/components/acoount_settings.dart';
import 'package:digi_school/screens/account_security_screen/account_security_screen.dart';
import 'package:digi_school/screens/assessment_screen/assessment_screen.dart';
import 'package:digi_school/screens/cart_screen/cart_screen.dart';
import 'package:digi_school/screens/category_screen/category_screen.dart';
import 'package:digi_school/screens/field_interest/field_interest.dart';
import 'package:digi_school/screens/instructor_screen/instructor_screen.dart';
import 'package:digi_school/screens/course_detail/course_detail.dart';
import 'package:digi_school/screens/landing/landing_screen.dart';
import 'package:digi_school/screens/lesson_screen/lesson_screen.dart';
import 'package:digi_school/screens/login/login_email/loginemail_screen.dart';
import 'package:digi_school/screens/login/login_email/loginemailwithpass_screen.dart';
import 'package:digi_school/screens/login/login_screen.dart';
import 'package:digi_school/screens/notification_screen/notification_screen.dart';
import 'package:digi_school/screens/quiz/quiz_landing.dart';
import 'package:digi_school/screens/quiz/quiz_screen.dart';
import 'package:digi_school/screens/register/register_email/registeremail_screen.dart';
import 'package:digi_school/screens/register/register_screen.dart';
import 'package:digi_school/screens/routine_screen/routine_screen.dart';
import 'package:digi_school/screens/search_screen_single/search_screen_single.dart';
import 'package:digi_school/screens/splash_screen/splash_screen.dart';
import 'package:digi_school/screens/webview_screen/webview_screen.dart';
import 'package:flutter/material.dart';
import '../api/response/certificate_generate_response.dart';
import '../configs/environment.config.dart';
import '../configs/preference.config.dart';
import '../screens/account_screen/components/Certificate_Componenets/certificate_screen.dart';
import '../screens/account_screen/components/my_achievements_screen.dart';
import '../screens/navigation/navigation_screen.dart';



class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;
    print("ROUTE GENERATED :: " + settings.name.toString());

    switch (settings.name) {
      case NavigationScreen.routeName:
        return MaterialPageRoute(builder: (_) => NavigationScreen(data: 0));
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case CategoryScreen.routeName:
        return MaterialPageRoute(builder: (_) {
          CategoryScreen argument = args;
          return CategoryScreen(
            id: argument.id,
            subcategory: argument.subcategory,
            name: argument.name,
          );
        });

      case InstructorScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => InstructorScreen(
                  id: args.toString(),
                ));
      case WebViewScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => WebViewScreen(
                  url: args.toString(),
                ));
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case SearchScreenSingle.routeName:
        return MaterialPageRoute(builder: (_) => const SearchScreenSingle());

      case CartScreen.routeName:
        return MaterialPageRoute(builder: (_) => CartScreen());

      case FieldInterest.routeName:
        return MaterialPageRoute(builder: (_) => const FieldInterest());

      case LessonScreen.routeName:
        String args = settings.arguments.toString();
        return MaterialPageRoute(
            builder: (_) => LessonScreen(
                  slug: args,
                ));
      case RoutineScreen.routeName:
        String args = settings.arguments.toString();
        return MaterialPageRoute(
            builder: (_) => RoutineScreen(
                  slug: args,
                ));

      case AssessmentScreen.routeName:
        String args = settings.arguments.toString();
        return MaterialPageRoute(
            builder: (_) => AssessmentScreen(
                  slug: args,
                ));

      case Registerwithemailscreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const Registerwithemailscreen());

      case Loginemailscreen.routeName:
        return MaterialPageRoute(builder: (_) => const Loginemailscreen());

      case Registerwithemailscreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const Registerwithemailscreen());

      case NotificationScreen.routeName:
        return MaterialPageRoute(builder: (_) => NotificationScreen());

      case AccountProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) => AccountProfileScreen());

      case AccountSecurityScreen.routeName:
        return MaterialPageRoute(builder: (_) => AccountSecurityScreen());

      case MyAchievement.routeName:
        return MaterialPageRoute(builder: (_)=> MyAchievement());


      // case GeneratedCertificate.routeName:
      //   dynamic args = settings.arguments as dynamic ;
        // return MaterialPageRoute(builder: (_)=> GeneratedCertificate(data: args,));



      case Loginemailwithpasswordscreen.routeName:
        String args = settings.arguments.toString();
        return MaterialPageRoute(
            builder: (_) => Loginemailwithpasswordscreen(
                  email: args,
                ));

      case CourseDetail.routeName:
        String args = settings.arguments.toString();
        return MaterialPageRoute(
            builder: (_) => CourseDetail(
                  slug: args,
                ));

      // case QuizScreen.routeName:
      //   // String args = settings.arguments.toString();
      //   return MaterialPageRoute(builder: (_) => QuizScreen());

      case QuizLanding.routeName:
        String args = settings.arguments.toString();
        return MaterialPageRoute(builder: (_) => QuizLanding(id: args,));

      // case LandingScreen.routeName:
      //   // String args = settings.arguments.toString();
      //   return MaterialPageRoute(builder: (_) => LandingScreen());

      case "/":
        if (EnvironmentConfig.open == true) {
          return MaterialPageRoute(builder: (_) => NavigationScreen(data: 0));
        } else {
          return MaterialPageRoute(builder: (_) => Splashscreen());
          // bool _seen = PreferenceUtils.instance.getBool('seen') ?? false;
          // // bool _seen = true;
          // if (_seen) {
          //   return MaterialPageRoute(builder: (_) => Splashscreen());
          // } else {
          //   try {
          //     PreferenceUtils.instance.clear();
          //     // HiveUtils.box.clear();
          //   } catch (e) {
          //     print(e.toString());
          //   }
          //   PreferenceUtils.instance.setBool('seen', true);
          //   return MaterialPageRoute(builder: (_) => LandingScreen());
          // }
        }
      default:
        print("DEFAULT ROUTE GENERATED " + settings.name.toString());
        return MaterialPageRoute(builder: (_) => NavigationScreen(data: 0));
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
