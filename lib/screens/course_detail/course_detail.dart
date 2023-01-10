import 'dart:convert';
import 'dart:ui';

import 'package:digi_school/api/response/course_detail_response.dart';
import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/configs/share.config.dart';
import 'package:digi_school/screens/account_screen/components/my_achievements_screen.dart';
import 'package:digi_school/screens/course_detail/achivement_view_model.dart';
import 'package:digi_school/screens/course_detail/components/course_detail_shimmer.dart';
import 'package:digi_school/screens/course_detail/components/coursecontent_coursedetail.dart';
import 'package:digi_school/screens/course_detail/components/instructordetails_coursedetail.dart';
import 'package:digi_school/screens/course_detail/components/recommendation_coursedetail.dart';
import 'package:digi_school/screens/course_detail/components/studentfeedback_coursedetail.dart';
import 'package:digi_school/screens/course_detail/components/subscription_coursedetail.dart';
import 'package:digi_school/screens/course_detail/course_detail_viewmodel.dart';
import 'package:digi_school/screens/instructor_screen/instructor_screen.dart';
import 'package:digi_school/screens/quiz/quiz_landing.dart';
import 'package:digi_school/screens/routine_screen/routine_screen.dart';
import 'package:digi_school/widgets/cache_image_util.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:digi_school/widgets/string_util.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/home_screen/components/home_item_list.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../api/repository/achievement_repository.dart';
import '../../api/response/login_response.dart';
import '../../configs/preference.config.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/popup_box.dart';

class CourseDetail extends StatelessWidget {
  const CourseDetail({Key? key, this.slug}) : super(key: key);
  final slug;
  static const String routeName = "/course-detail";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AchievementCheckViewModel>(
        create: (_) => AchievementCheckViewModel(),
        child: CourseDetailBody(
          slug: slug,
          id: null,
        ));
  }
}

class CourseDetailBody extends StatefulWidget {
  const CourseDetailBody({Key? key, this.slug, required this.id})
      : super(key: key);
  final slug;
  final id;
  @override
  _CourseDetailBodyState createState() => _CourseDetailBodyState();
}

class _CourseDetailBodyState extends State<CourseDetailBody> {
  late CourseDetailViewModel courseDetailViewModel;
  late AchievementCheckViewModel achievementCheckViewModel;
  late CommonViewModel common;
  late AuthViewModel auth;

  Future<void> getAll(CourseDetailViewModel courseDetailViewModel) async {
    await courseDetailViewModel.getCourse(widget.slug);
    // check access
    try {
      courseDetailViewModel.checkAccess(auth.user.email.toString());
    } catch (e) {}

    // check wishlist
    try {
      String? wishListId = (common.wishlist.firstWhere((element) =>
          element.course!.id == courseDetailViewModel.course!.details!.id)).id;
      if (wishListId != null) {
        courseDetailViewModel.setFav(true);
      } else {
        courseDetailViewModel.setFav(false);
      }
    } catch (e) {
      courseDetailViewModel.setFav(false);
    }
  }

  Map<String, dynamic> lessons = {
    "success": true,
    "lessons": [
      {
        "week": 1,
        "lessons": [
          {
            "_id": "5fb3bf097c24ec7233b8a7f8",
            "lessonTitle": "Basic Electricity And Electronics",
            "lessonSlug": "basic-electricity-and-electronics",
            "assessments": []
          },
          {
            "_id": "5fc73e3e3a1f5e0b9ea81233",
            "lessonTitle": "Chip-talk",
            "lessonSlug": "chip-talk",
            "assessments": []
          },
          {
            "_id": "5fc7f1b6ecb16e491df514f9",
            "lessonTitle": "Avr Microcontroller Atmega 328",
            "lessonSlug": "avr-microcontroller-atmega-328",
            "assessments": []
          },
          {
            "_id": "5fd18f7f599ddb78a3bfaf11",
            "lessonTitle": "Pervasive Computing ",
            "lessonSlug": "pervasive-computing",
            "assessments": []
          },
          {
            "_id": "5fd18fab599ddb78a3bfaf14",
            "lessonTitle": "Smart City",
            "lessonSlug": "smart-city",
            "assessments": []
          }
        ]
      },
      {
        "week": 2,
        "lessons": [
          {
            "_id": "5fc7f66eecb16e491df514fa",
            "lessonTitle": "Sensors",
            "lessonSlug": "sensors",
            "assessments": []
          },
          {
            "_id": "5fd19011599ddb78a3bfaf17",
            "lessonTitle": "Aspects Of Pervasive Computing ",
            "lessonSlug": "aspects-of-pervasive-computing",
            "assessments": []
          },
          {
            "_id": "60ec7e5af449b429073ffcfb",
            "lessonTitle": "Programming with Arduino",
            "lessonSlug": "programming-with-arduino",
            "assessments": []
          },
          {
            "_id": "60ec88a40d4db9291aa023cf",
            "lessonTitle": "LDR",
            "lessonSlug": "ldr",
            "assessments": []
          },
          {
            "_id": "619cc4f93f54582a42f4b619",
            "lessonTitle": "Micro controller ",
            "lessonSlug": "micro-controller",
            "assessments": []
          }
        ]
      },
      {
        "week": 3,
        "lessons": [
          {
            "_id": "5fcdf5b900e81b1e7c93a943",
            "lessonTitle": "Lab 1: Ultrasonic Sensor and GAS Sensor ",
            "lessonSlug": "lab-1:-ultrasonic-sensor-and-gas-sensor",
            "assessments": []
          },
          {
            "_id": "5fd045b5432fc82c1932955e",
            "lessonTitle": "Communication Protocols",
            "lessonSlug": "communication-protocols",
            "assessments": []
          },
          {
            "_id": "60ec8593f449b429073ffd78",
            "lessonTitle": "PIR Sensor",
            "lessonSlug": "pir-sensor",
            "assessments": []
          },
          {
            "_id": "60ec86060d4db9291aa02352",
            "lessonTitle": "Servo",
            "lessonSlug": "servo",
            "assessments": []
          },
          {
            "_id": "61a2fe596a1d5319108a3616",
            "lessonTitle": "Ultrasonic code",
            "lessonSlug": "ultrasonic-code",
            "assessments": []
          },
          {
            "_id": "61a330a36a1d5319108e129c",
            "lessonTitle": "Smoke Detection with MQ2 gas sensor",
            "lessonSlug": "smoke-detection-with-mq2-gas-sensor",
            "assessments": []
          },
          {
            "_id": "61a88e502480001357bdfdc0",
            "lessonTitle": "Arduino Project Book",
            "lessonSlug": "arduino-project-book",
            "assessments": []
          }
        ]
      },
      {
        "week": 4,
        "lessons": [
          {
            "_id": "5fd1b547599ddb78a3bfb242",
            "lessonTitle": "About Ultrasonic Sensor ",
            "lessonSlug": "about-ultrasonic-sensor",
            "assessments": []
          },
          {
            "_id": "5fd2d156d7c3861844e060e9",
            "lessonTitle": "Ultrasonic Sensor Applications video file",
            "lessonSlug": "ultrasonic-sensor-applications-video-file",
            "assessments": []
          },
          {
            "_id": "5fd30bdf16c92067a348bb4d",
            "lessonTitle": "Lab 2: Ultrasonic Sensor Codes",
            "lessonSlug": "lab-2:-ultrasonic-sensor-codes",
            "assessments": []
          },
          {
            "_id": "5fd41c2b1ca2247ad25104aa",
            "lessonTitle":
                "Lab 2: Using Arduino, Ultrasonic Sensor and Relay to control AC lights",
            "lessonSlug":
                "lab-2:-using-arduino-ultrasonic-sensor-and-relay-to-control-ac-lights",
            "assessments": []
          },
          {
            "_id": "5fd41f711ca2247ad25104bb",
            "lessonTitle": "IR Sensor",
            "lessonSlug": "lab-2:-arduino-with-ir-sensor",
            "assessments": []
          },
          {
            "_id": "61ac31b42480001357d3e416",
            "lessonTitle": "Potentiometer ",
            "lessonSlug": "potentiometer",
            "assessments": []
          },
          {
            "_id": "61ac390a2480001357d4ee32",
            "lessonTitle": "Buzzer Code",
            "lessonSlug": "buzzer-code",
            "assessments": []
          },
          {
            "_id": "61ac7e1e2480001357dae769",
            "lessonTitle": "BT Module",
            "lessonSlug": "bt-module",
            "assessments": []
          },
          {
            "_id": "61b051e33e53df3e52a2fea1",
            "lessonTitle": "LCD with ultrasonic sensor",
            "lessonSlug": "lcd-with-ultrasonic-sensor",
            "assessments": []
          }
        ]
      },
      {
        "week": 5,
        "lessons": [
          {
            "_id": "5fe01df43aeaa031304861d5",
            "lessonTitle": "RTLS Articles",
            "lessonSlug": "rtls-articles",
            "assessments": ["61d3f3fe5edc4d1cb3ae2a1d"]
          },
          {
            "_id": "5feb62a8d001087baab39034",
            "lessonTitle": "Raspberry pi Pdf",
            "lessonSlug": "raspberry-pi-official-website",
            "assessments": []
          },
          {
            "_id": "60ec84a89c9b022935fd2a88",
            "lessonTitle": "Node Mcu and Arduino UNO Communication",
            "lessonSlug": "node-mcu-and-arduino-uno-communication",
            "assessments": []
          },
          {
            "_id": "60ec85059c9b022935fd2ac5",
            "lessonTitle":
                "REAL-TIME MONITORING OF THE GREAT BARRIER REEF USING INTERNET OF THINGS WITH BIG DATA ANALYTICS",
            "lessonSlug":
                "real-time-monitoring-of-the-great-barrier-reef-using-internet-of-things-with-big-data-analytics",
            "assessments": []
          },
          {
            "_id": "60ec87d10d4db9291aa02392",
            "lessonTitle": "NODE MCU ",
            "lessonSlug": "node-mcu-1",
            "assessments": []
          },
          {
            "_id": "61bedec224952720b11128fd",
            "lessonTitle": "RTLS Slides",
            "lessonSlug": "rtls-slides",
            "assessments": []
          },
          {
            "_id": "61c2ce2224952720b132e342",
            "lessonTitle": "web server with node mcu",
            "lessonSlug": "web-server-with-node-mcu",
            "assessments": []
          },
          {
            "_id": "61cabc926ae14c14ba3777d7",
            "lessonTitle": "Sample document",
            "lessonSlug": "sample-document",
            "assessments": []
          }
        ]
      },
      {
        "week": 6,
        "lessons": [
          {
            "_id": "5febf48f86d32a61d0900e70",
            "lessonTitle": "Ethical Issues ",
            "lessonSlug": "ethical-issues",
            "assessments": []
          },
          {
            "_id": "5febf4e986d32a61d0900e7d",
            "lessonTitle": "Ethical social and legal issues and IOT",
            "lessonSlug": "ethical-social-and-legal-issues-and-iot",
            "assessments": []
          },
          {
            "_id": "6001a9a5e8716810ff32fb16",
            "lessonTitle": "18_Arduino_Projects_eBook_Rui_Santos",
            "lessonSlug": "18arduinoprojectsebookruisantos",
            "assessments": []
          },
          {
            "_id": "6001ce7be8716810ff32fc6a",
            "lessonTitle": "LAB 3 : Bluetooth Module (HC-05 & HC-06)",
            "lessonSlug": "lab-3-:-bluetooth-module-hc-05-and-hc-06",
            "assessments": []
          },
          {
            "_id": "6001d0b9e8716810ff32fc78",
            "lessonTitle":
                "LAB 3: Name Change Code Bluetooth Module HC-05/HC-06",
            "lessonSlug": "lab-3:-name-change-code-bluetooth-module-hc-05hc-06",
            "assessments": []
          },
          {
            "_id": "600253925d0ec06abc142105",
            "lessonTitle": "LAB: 3 Bluetooth Module HC05/HC06",
            "lessonSlug": "lab:-3-bluetooth-module-hc05hc06",
            "assessments": []
          },
          {
            "_id": "600254465d0ec06abc14210e",
            "lessonTitle": "Bluetooth: APP ",
            "lessonSlug": "bluetooth:-app",
            "assessments": []
          },
          {
            "_id": "60065f43a126b7322bfe2033",
            "lessonTitle": "RFID",
            "lessonSlug": "rfid"
          }
        ]
      },
      {
        "week": 7,
        "lessons": [
          {
            "_id": "601427183ff0771613379940",
            "lessonTitle": "LAB 4 : RFID",
            "lessonSlug": "lab-4-:-rfid",
            "assessments": []
          },
          {
            "_id": "601429735a779e19b68206af",
            "lessonTitle": "LAB 4 : Servo",
            "lessonSlug": "lab-4-:-servo",
            "assessments": []
          },
          {
            "_id": "601429d63ff0771613379952",
            "lessonTitle": "NODE MCU",
            "lessonSlug": "node-mcu",
            "assessments": []
          },
          {
            "_id": "60142a6e3ff077161337995c",
            "lessonTitle":
                "MPU 6050 Tutorial | How to Program MPU 6050 With Arduino",
            "lessonSlug":
                "mpu-6050-tutorial-or-how-to-program-mpu-6050-with-arduino",
            "assessments": []
          },
          {
            "_id": "60142b3a3ff0771613379968",
            "lessonTitle":
                "How RFID Works and How To Make an Arduino based RFID Door Lock",
            "lessonSlug":
                "how-rfid-works-and-how-to-make-an-arduino-based-rfid-door-lock",
            "assessments": []
          },
          {
            "_id": "6016d3b4f972ac0a7f01696b",
            "lessonTitle": "IOT Home Automation using Blynk and Node MCU",
            "lessonSlug": "iot-home-automation-using-blynk-and-node-mcu",
            "assessments": []
          },
          {
            "_id": "60ec8904a4428d2900468eae",
            "lessonTitle": "LCD",
            "lessonSlug": "lcd-1",
            "assessments": []
          }
        ]
      },
      {
        "week": 8,
        "lessons": [
          {
            "_id": "601c1710bb4883063f9a233b",
            "lessonTitle": "Microcontroller",
            "lessonSlug": "microcontroller",
            "assessments": []
          },
          {
            "_id": "601c411baf56744543025d77",
            "lessonTitle": "Assembly CODE",
            "lessonSlug": "assembly-code",
            "assessments": []
          },
          {
            "_id": "601cc080298c807b1c1ab389",
            "lessonTitle": "adxl345 Accelerometer",
            "lessonSlug": "adxl345-accelerometer",
            "assessments": []
          },
          {
            "_id": "60237f3aef91ee19c06f4da2",
            "lessonTitle": "ESP8266 Web Server with Arduino IDE",
            "lessonSlug": "esp8266-web-server-with-arduino-ide",
            "assessments": []
          },
          {
            "_id": "6023f2e7fb429119a7580d20",
            "lessonTitle": "Usability",
            "lessonSlug": "usability",
            "assessments": []
          },
          {
            "_id": "60ec8867a4428d2900468e70",
            "lessonTitle": "GSM Module",
            "lessonSlug": "gsm-module",
            "assessments": []
          },
          {
            "_id": "60ec89a5a4428d2900468eeb",
            "lessonTitle": "MQTT",
            "lessonSlug": "mqtt-1",
            "assessments": []
          },
          {
            "_id": "60ec89e5f449b429073ffdb6",
            "lessonTitle": "IFTTT",
            "lessonSlug": "ifttt",
            "assessments": []
          },
          {
            "_id": "60ec8ca90d4db9291aa024c3",
            "lessonTitle": "Web Server with Arduino",
            "lessonSlug": "web-server-with-arduino",
            "assessments": []
          }
        ]
      },
      {
        "week": 9,
        "lessons": [
          {
            "_id": "6023f5156c55b619ad042c35",
            "lessonTitle": "Zip file for Individual Projects ",
            "lessonSlug": "zip-file-for-individual-projects"
          },
          {
            "_id": "6023f584ef91ee19c06f4ee2",
            "lessonTitle": "Some useful codes for Pulse rate, Oled",
            "lessonSlug": "some-useful-codes-for-pulse-rate-oled"
          },
          {
            "_id": "6023f6c2ef91ee19c06f4ee5",
            "lessonTitle": "Node MCU Esp8266",
            "lessonSlug": "node-mcu-esp8266",
            "assessments": []
          },
          {
            "_id": "6023f75b6c55b619ad042c3d",
            "lessonTitle": "IFTTT and rpm to m/s",
            "lessonSlug": "ifttt-and-rpm-to-ms"
          },
          {
            "_id": "60254df859a87a76f88d288c",
            "lessonTitle": "Firebase Realtime Database",
            "lessonSlug": "firebase-realtime-database",
            "assessments": ["61e66250de7580234c65de68"]
          },
          {
            "_id": "60ec8bab9c9b022935fd2b80",
            "lessonTitle": "OLED SSD1106 DRIVER",
            "lessonSlug": "oled-ssd1106-driver",
            "assessments": []
          },
          {
            "_id": "61e8e49458c9902a8c406371",
            "lessonTitle": "IoT vulnerability ",
            "lessonSlug": "iot-vulnerability",
            "assessments": []
          }
        ]
      },
      {
        "week": 10,
        "lessons": [
          {
            "_id": "605186ff9b2158229a86d6ad",
            "lessonTitle": "Group Sample Documents",
            "lessonSlug": "group-sample-documents",
            "assessments": []
          },
          {
            "_id": "60ec8401f449b429073ffd3b",
            "lessonTitle": "Blynk Codes",
            "lessonSlug": "blynk-codes",
            "assessments": []
          },
          {
            "_id": "60ec843f9c9b022935fd2a4b",
            "lessonTitle": "HC-05 Codes",
            "lessonSlug": "hc-05-codes",
            "assessments": []
          },
          {
            "_id": "60ec89660d4db9291aa0240c",
            "lessonTitle": "Questions",
            "lessonSlug": "questions",
            "assessments": []
          },
          {
            "_id": "60ec8a389c9b022935fd2b05",
            "lessonTitle": "Assignment Format",
            "lessonSlug": "assignment-format",
            "assessments": []
          },
          {
            "_id": "60ec8b049c9b022935fd2b42",
            "lessonTitle": "Papers",
            "lessonSlug": "papers",
            "assessments": []
          },
          {
            "_id": "60ec8b450d4db9291aa02449",
            "lessonTitle": " mqtt light control that receive nodemcu dataFile",
            "lessonSlug": "mqtt-light-control-that-receive-nodemcu-datafile",
            "assessments": []
          },
          {
            "_id": "60ec8c1da4428d2900468f29",
            "lessonTitle": "Sensors files",
            "lessonSlug": "sensors-files",
            "assessments": []
          },
          {
            "_id": "60ec8c490d4db9291aa02486",
            "lessonTitle": "Keypad",
            "lessonSlug": "keypad",
            "assessments": []
          },
          {
            "_id": "60ec8dc59c9b022935fd2bbe",
            "lessonTitle": "Individual Project: Sample Report",
            "lessonSlug": "sample-report",
            "assessments": []
          },
          {
            "_id": "60ec8eeef449b429073ffdf8",
            "lessonTitle": "Library",
            "lessonSlug": "library",
            "assessments": []
          },
          {
            "_id": "61ba881dea5491284c810e8f",
            "lessonTitle": "RFID LAB",
            "lessonSlug": "rfid-lab",
            "assessments": []
          },
          {
            "_id": "61f00ce358c9902a8c71ab70",
            "lessonTitle": "MQTT",
            "lessonSlug": "mqtt-2",
            "assessments": []
          }
        ]
      },
      {
        "week": 11,
        "lessons": [
          {
            "_id": "61bcbab824952720b1051a0c",
            "lessonTitle": "Raspberry Pi Workshop 1A DAY 1",
            "lessonSlug": "raspberry-pi-workshop-1a-documents",
            "assessments": []
          },
          {
            "_id": "61bcc1f624952720b10557c6",
            "lessonTitle": "Raspberry Pi Workshop 1A DAY 2",
            "lessonSlug": "raspberry-pi-workshop-1a-day-2",
            "assessments": []
          },
          {
            "_id": "61bd805e24952720b1074fe2",
            "lessonTitle": "Python Basics command",
            "lessonSlug": "python-basics-command",
            "assessments": []
          }
        ]
      }
    ]
  };

  List<Map<String, dynamic>> demo = [
    {
      "title": "Title 1",
      "user": "User 1",
      "image": "assets/demo/course/course1.jpg",
      "rating": 3.4,
      "price": 100,
      "discount": 10
    },
    {
      "title": "Title 2",
      "user": "User 2",
      "image": "assets/demo/course/course2.jpg",
      "rating": 1.4,
      "price": 200,
      "discount": 0
    },
    {
      "title": "Title 3",
      "user": "User 3",
      "image": "assets/demo/course/course3.jpg",
      "rating": 2.3,
      "price": 300,
      "discount": 20
    },
    {
      "title": "Title 4",
      "user": "User 4",
      "image": "assets/demo/course/course4.jpg",
      "rating": 3.2,
      "price": 400,
      "discount": 100
    },
    {
      "title": "Title 5",
      "user": "User 5",
      "image": "assets/demo/course/course5.jpg",
      "rating": 5.0,
      "price": 100,
      "discount": 30
    },
  ];

  ScrollController? _hideButtonController;

  var _isVisible;
  // late UserData _user;
  @override
  initState() {
    super.initState();
    _isVisible = false;
    _hideButtonController = new ScrollController();
    _hideButtonController!.addListener(() {
      if (_hideButtonController!.offset > 680) {
        setState(() {
          _isVisible = true;
        });
      } else {
        setState(() {
          _isVisible = false;
        });
      }
    });

    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      courseDetailViewModel =
          Provider.of<CourseDetailViewModel>(context, listen: false);
      common = Provider.of<CommonViewModel>(context, listen: false);
      achievementCheckViewModel =
          Provider.of<AchievementCheckViewModel>(context, listen: false);

      achievementCheckViewModel.fetchcheckCertificate(widget.slug);
      auth = Provider.of<AuthViewModel>(context, listen: false);
      getAll(courseDetailViewModel);
    });
  }
  // void showAlertDialog() {
  //   showDialog(
  //       context: context,
  //       barrierColor: Colors.white.withOpacity(0.1),
  //       builder: (context) {
  //         return BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
  //           child: PopupMessage(
  //               slug: widget.slug,
  //               title: "Congratulations! 🎉",
  //               description: "You can now view your certificate"),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    // print("user ${_user.username}");
    return Consumer3<CourseDetailViewModel, AuthViewModel,
            AchievementCheckViewModel>(
        builder: (context, provider, auth, achievement, child) {
      return Scaffold(
        bottomSheet: isLoading(provider.courseDetailApiResponse)
            ? SizedBox()
            : Builder(
                builder: (context) {
                  if (provider.course!.progress != null &&
                      double.parse(provider.course!.progress.toString()) ==
                          100) {
                    // print("ghsdfghjdfghjkjzxcvbnmkl");

                    if (achievement.achievementCertificateData == null ||
                        achievement.achievementCertificateData.isEmpty) {
                      return SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              context.loaderOverlay.show();
                              final res = await AchievementRepository()
                                  .postCertificate(provider
                                      .course!.details!.courseSlug
                                      .toString());
                              if (res.success == true) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 2.0, sigmaY: 2.0),
                                          child: Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Stack(
                                              alignment: Alignment.topCenter,
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  height: 280,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 80,
                                                        ),
                                                        Text(
                                                          "Congratulations  🎉",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: h4,
                                                              color:
                                                                  kPrimaryColor),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "You can now view your certificate",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: p1,
                                                              color: kBlack),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          height: 35,
                                                        ),
                                                        SizedBox(
                                                          height: 50,
                                                          width: 200,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  primary:
                                                                      kPrimaryColor,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8))),
                                                              onPressed: () {
                                                                Navigator
                                                                    .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              MyAchievement(),
                                                                        )).then(
                                                                    (value) {
                                                                  getData();
                                                                  print(
                                                                      'i am here');
                                                                  print(value
                                                                      .toString());
                                                                });
                                                              },
                                                              child: Text(
                                                                "View",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        p0,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    top: -60,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          kPrimaryColor,
                                                      radius: 60,
                                                      child: Image.asset(
                                                        "assets/images/trophy-icon.png",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ));

                                      //
                                      //   PopupMessage(
                                      //       slug: widget.slug,
                                      //       title: "Congratulations! 🎉",
                                      //       description: "You can now view your certificate"),
                                      // );
                                    });
                                context.loaderOverlay.hide();
                              } else {
                                context.loaderOverlay.hide();
                                snackThis(
                                    context: context,
                                    color: Colors.red,
                                    content: Text(res.msg.toString()),
                                    duration: 5);
                              }
                            } catch (e) {
                              context.loaderOverlay.hide();
                              snackThis(
                                  context: context,
                                  color: Colors.red,
                                  content: Text(e.toString()),
                                  duration: 3);
                            }
                            context.loaderOverlay.hide();
                          },
                          child: Text("Generate Certificate"),
                        ),
                      );
                    }
                  }
                  return SizedBox();
                },
              ),
        // achievement.achievementCertificateData == null || provider.course?.progress == null ? SizedBox():  isLoading(provider.courseDetailApiResponse)
        //     ? CircularProgressIndicator()
        //     : Builder(
        //         builder: (context) {
        //
        //           if (double.parse(provider.course!.progress.toString()) >=100 && achievement.achievementCertificateData.data!= null) {
        //               return Container(
        //                 height: 50,
        //                 color: Colors.yellow,
        //                 width: 100,
        //                 child: CustomGenerateCertificateButton(
        //                   title: "Generate Certificate",
        //                   onTap: (){},
        //
        //                 ),
        //               );
        //             }
        //             else {
        //               return Container(
        //                 height: 50,
        //
        //                 width: double.infinity,
        //                 child: ElevatedButton(
        //                   style:
        //                       ElevatedButton.styleFrom(primary: Colors.green),
        //                   child: Text(
        //                       "The certificate has been already generated"),
        //                   onPressed: () {},
        //                 ),
        //               );
        //             }
        //
        //
        //         },
        //       ),
        // bottomSheet: isLoading(provider.courseDetailApiResponse)
        //     ? CircularProgressIndicator()
        //     : (double.parse(provider.course!.progress.toString()) >= 100 &&
        //             cvm.achievementCertifcateData == null)
        //         ? Container(
        //             height: 50,
        //             color: Colors.yellow,
        //             width: double.infinity,
        //             child: ElevatedButton(
        //               style: ElevatedButton.styleFrom(primary: Colors.yellow),
        //               child: Text("Generate Certificate"),
        //               onPressed: () {},
        //             ),
        //           )
        //         : SizedBox(),
        appBar: AppBar(
          backgroundColor: kWhite,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: kBlack,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          actions: [
            if (!isLoading(provider.courseDetailApiResponse) &&
                provider.course != null &&
                auth.user.id != null)
              Padding(
                padding: const EdgeInsets.all(0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RoutineScreen.routeName,
                          arguments: widget.slug);
                    },
                    icon: Icon(Icons.calendar_today)),
              ),
            if (!isLoading(provider.courseDetailApiResponse) &&
                provider.course != null)
              Padding(
                padding: const EdgeInsets.all(0),
                child: IconButton(
                    onPressed: () {
                      shareUrl("Digischool", "https://google.com");
                    },
                    icon: const Icon(Icons.share)),
              ),
            if (!isLoading(provider.courseDetailApiResponse) &&
                provider.course != null &&
                auth.user.id != null)
              Padding(
                padding: const EdgeInsets.all(0),
                child: IconButton(
                    onPressed: () {
                      if (provider.isFav) {
                        common
                            .removeFromWishList(provider.course!.details!.id!)
                            .then((value) {
                          commonSnackHacks(
                              context: context,
                              response: common.wishlistUpdateApiResponse,
                              success: [provider.setFav(false)]);
                        }).catchError((e) {
                          commonSnackHacksError(context: context, e: e);
                        });
                      } else {
                        common
                            .addToWishList(provider.course!.details!.id!)
                            .then((value) {
                          print(common.wishlistUpdateApiResponse.toString());
                          commonSnackHacks(
                              context: context,
                              response: common.wishlistUpdateApiResponse,
                              success: [provider.setFav(true)]);
                        }).catchError((e) {
                          commonSnackHacksError(context: context, e: e);
                        });
                      }
                    },
                    icon: provider.isFav
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: kBlack,
                          )),
              ),
          ],
          iconTheme: const IconThemeData(color: kBlack),
        ),
        body: RefreshIndicator(
          onRefresh: () => getAll(provider),
          child: CustomScrollView(
            controller: _hideButtonController,
            shrinkWrap: true,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: isLoading(provider.courseDetailApiResponse)
                    ? SliverFillRemaining(
                        child: CourseDetailShimmer(),
                      )
                    : provider.course == null
                        ? SliverFillRemaining(
                            child: Image.asset("assets/images/no-data.png"),
                          )
                        : new SliverList(
                            delegate: SliverChildListDelegate(
                              <Widget>[
                                Builder(builder: (context) {
                                  return _header(
                                      provider.course!.details!.image);
                                }),
                                _introductionCourse(provider.course!),
                                Subscriptioncoursedetail(),

                                Coursecontentcoursedetail(
                                  lessons: lessons,
                                  weeks: provider.course!.weeks!,
                                  hasAccess: provider.hasAccess,
                                ),
                                SizedBox(
                                  height: 40,
                                )
                                // Recommendationcoursedetail(demo: demo),
                                // Instructorcoursedetail(
                                //     instructor: data["module"]["moduleLeader"]),
                                // Studentfeedbackcoursedetail(
                                //     data: feedback["feedback"]),
                              ],
                            ),
                          ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: _isVisible ? 60.0 : 0.0,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade200,
                width: 5.0,
              ),
            ),
          ),
          child: _isVisible
              ? Row(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5),
                              child: Text(
                                provider.course!.details!.learnType!
                                            .toLowerCase() ==
                                        "free"
                                    ? "Npr. 0"
                                    : "Npr. 5500",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.purple),
                                onPressed: () {},
                                child: provider.hasAccess
                                    ? Text("Enrolled")
                                    : Text("Buy now"),
                              ),
                            ))
                      ],
                    ))
                  ],
                )
              : Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                ),
        ),
      );
    });
  }

  // Widget _courseContent(String courseDesc) {
  //   return
  // }

  Widget _header(String? image) {
    return Container(
        child: CacheImageUtil(
      width: double.infinity,
      height: 230,
      image: image.toString(),
      default_image: "assets/images/landing/images-1.jpg",
      fit: BoxFit.cover,
    ));
  }

  Widget _introductionCourse(
    CourseData course,
  ) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            course.details!.courseTitle.toString(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        Wrap(
          children: [
            if (course.details != null && course.details!.tags!.length > 0)
              ...course.details!.tags!.map((e) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Chip(
                        backgroundColor: Colors.black54,
                        label: Text(
                          e.toString(),
                          style: TextStyle(color: kWhite),
                        )),
                  ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(course.details!.rating == null
                  ? "0"
                  : course.details!.rating!.toStringAsFixed(2)),
              SizedBox(
                width: 2,
              ),
              SmoothStarRating(
                allowHalfRating: false,
                rating: course.details!.rating!.toDouble(),
                isReadOnly: true,
                size: 20,
                starCount: 5,
                color: Colors.yellow.shade700,
                borderColor: Colors.yellow.shade700,
                spacing: 0.0,
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     children: [
        //       Icon(
        //         Icons.warning_outlined,
        //         size: 12,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Text("last updated 12 Nov, 2022")
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.payment,
                      size: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${course.details!.learners!.length.toString()} students enrolled",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Icon(
              //         Icons.warning_outlined,
              //         size: 12,
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text("last updated 12 Nov, 2022")
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.payment,
                      size: 12,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(course.details!.learnType.toString())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      size: 12,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(course.details!.duration.toString())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("${course.details!.weeklyStudy.toString()} hours")
                  ],
                ),
              )
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instructors ',
                style: const TextStyle(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: p1,
                ),
              ),
              ...course.details!.lecturers!.map((e) => InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CacheImageUtil(
                              height: 50,
                              width: 50,
                              default_image: "assets/images/default_user.png",
                              fit: BoxFit.cover,
                              image: e.user!.userImage.toString(),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                              "${capitalize(e.user!.firstname.toString())} ${capitalize(e.user!.lastname.toString())}",
                              style: const TextStyle(
                                color: khyperlink,
                                fontSize: 15,
                              )),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       Text(
        //         "NRP ${discount > 0 ? (price - discount).toString() : price.toString()}",
        //         style: TextStyle(
        //             fontSize: p1, fontWeight: FontWeight.w600, color: gray_900),
        //       ),
        //       SizedBox(
        //         width: 2,
        //       ),
        //       if (discount > 0)
        //         Text(
        //           price.toString(),
        //           style: TextStyle(
        //               fontSize: p2,
        //               color: gray_900,
        //               decoration: TextDecoration.lineThrough),
        //         )
        //     ],
        //   ),
        // ),
      ],
    ));
  }
}
