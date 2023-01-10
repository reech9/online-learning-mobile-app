import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  static String url = "";
  static String platform = "";
  static bool open = false;
  static String? queueRouteName;
  static String? queueArgs;
  static String? ref;

  static String? deviceSpecificTopic;
  static String? endUserTopic;
  static String environment = "development";
  static String eSewaClientId = "";
  static String eSewaSecretKey = "";
  static String khaltiApiKey = "";

  init() {
    environment = dotenv.env["ENV"].toString();
    print("ENVIRONMENT :: " + environment);
    if (Platform.isAndroid) {
      platform = "android";
    } else if (Platform.isIOS) {
      platform = "ios";
    }

    // URL
    switch (environment) {
      case "production":
        url = dotenv.env["LIVE_URL"].toString();
        break;
      case "staging":
        url = dotenv.env["STAGING_URL"].toString();
        break;
      case "local":
        url = dotenv.env["LOCAL_URL"].toString();
        break;
      case "development":
      default:
        url = dotenv.env["DEV_URL"].toString();
        break;
    }

    // payment gateway environment
    switch (environment) {
      case "production":
        eSewaClientId = dotenv.env["LIVE_ESEWA_CLIEND_ID"].toString();
        eSewaSecretKey = dotenv.env["LIVE_ESEWA_SECRET_KEY"].toString();
        khaltiApiKey = dotenv.env["LIVE_KHALTI_API"].toString();
        break;
      default:
        eSewaClientId = dotenv.env["DEV_ESEWA_CLIEND_ID"].toString();
        eSewaSecretKey = dotenv.env["DEV_ESEWA_SECRET_KEY"].toString();
        khaltiApiKey = dotenv.env["DEV_KHALTI_API"].toString();
        break;
    }

    if (dotenv.env["ENV"].toString() == "production") {
      deviceSpecificTopic = platform == "android" ? "android" : "ios";
      endUserTopic = "end_user";
    } else {
      deviceSpecificTopic = platform == "android" ? "android_dev" : "ios_dev";
      endUserTopic = "end_user_dev";
    }
  }
}
