import 'package:chewie/chewie.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LessonScreen extends StatefulWidget {
  LessonScreen({Key? key}) : super(key: key);
  static const String routeName = "/lesson-screen";
  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
    initializePlayer();
    controller = new TabController(length: 2, vsync: this);
  }

  bool completed = false;

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(
        "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    await Future.wait([_videoPlayerController.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];

    final subtitles = [
      Subtitle(
        index: 0,
        start: Duration.zero,
        end: const Duration(seconds: 10),
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Hello',
              style: TextStyle(color: Colors.red, fontSize: 22),
            ),
            TextSpan(
              text: ' from ',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            TextSpan(
              text: 'subtitles',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            )
          ],
        ),
      ),
      Subtitle(
        index: 0,
        start: const Duration(seconds: 10),
        end: const Duration(seconds: 20),
        text: 'Whats up? :)',
        // text: const TextSpan(
        //   text: 'Whats up? :)',
        //   style: TextStyle(color: Colors.amber, fontSize: 22, fontStyle: FontStyle.italic),
        // ),
      ),
    ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: true,
      // additionalOptions: (context) {
      //   return <OptionItem>[
      //     OptionItem(
      //       onTap: toggleVideo,
      //       iconData: Icons.live_tv_sharp,
      //       title: 'Toggle Video Src',
      //     ),
      //   ];
      // },
      subtitle: Subtitles(subtitles),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),

      hideControlsTimer: const Duration(seconds: 1),

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  late TabController controller;

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

  double videoHeight = 220.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
            setState(() {
              completed = !completed;
            });
          },
          label:
              completed ? Text("Marked as complete") : Text('Mark as complete'),
          icon: completed ? Icon(Icons.check) : Icon(Icons.thumb_up),
          backgroundColor: completed ? green_1 : kPrimaryColorHover,
        ),
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
                  offset: const Offset(-2, 0), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                        child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      color: kPrimaryColor,
                    ),
                    Text("Section 1"),
                  ],
                ))),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                        child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Section 3"),
                    Icon(
                      Icons.chevron_right,
                      color: kPrimaryColor,
                    )
                  ],
                ))),
              ],
            ),
          ),
        ),
        body: Container(
            color: kWhite,
            child: SafeArea(
                child: ScrollConfiguration(
                    behavior:
                        const ScrollBehavior().copyWith(overscroll: false),
                    child: CustomScrollView(slivers: <Widget>[
                      SliverAppBar(
                        elevation: 0,
                        toolbarHeight: 50,
                        backgroundColor: kWhite,

                        pinned: true,
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        collapsedHeight: videoHeight,
                        expandedHeight: videoHeight,
                        flexibleSpace: Container(
                          decoration: BoxDecoration(color: gray_500),
                          child: Center(
                            child: _chewieController != null &&
                                    _chewieController!.videoPlayerController
                                        .value.isInitialized
                                ? Chewie(
                                    controller: _chewieController!,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 20),
                                      Text('Loading'),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      SliverAppBar(
                        backgroundColor: kWhite,
                        title: Text(
                          "Learn Python: The Complete Python Programming Course",
                          style: TextStyle(
                            color: kBlack,
                          ),
                        ),
                        elevation: 0,
                        pinned: true,
                        floating: false,
                        automaticallyImplyLeading: false,
                        bottom: TabBar(
                            indicatorColor: kPrimaryColor,
                            labelPadding: const EdgeInsets.only(
                              bottom: 16,
                            ),
                            controller: controller,
                            tabs: [
                              Text(
                                "Contents",
                                style: TextStyle(color: kBlack),
                              ),
                              Text(
                                "Lessons",
                                style: TextStyle(color: kBlack),
                              ),
                            ]),
                      ),
                      new SliverFillRemaining(
                        child: TabBarView(
                          controller: controller,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                    """Do you want to become a programmer? Do you want to learn how to create games, automate your browser, visualize data, and much more?

If you’re looking to learn Python for the very first time or need a quick brush-up, this is the course for you!

Python has rapidly become one of the most popular programming languages around the world. Compared to other languages such as Java or C++, Python consistently outranks and outperforms these languages in demand from businesses and job availability. The average Python developer makes over \$100,000 - this number is only going to grow in the coming years.

The best part? Python is one of the easiest coding languages to learn right now. It doesn’t matter if you have no programming experience or are unfamiliar with the syntax of Python. By the time you finish this course, you'll be an absolute pro at programming!

This course will cover all the basics and several advanced concepts of Python. We’ll go over:

    The fundamentals of Python programming

    Writing and Reading to Files

    Automation of Word and Excel Files

    Web scraping with BeautifulSoup4

    Browser automation with Selenium

    Data Analysis and Visualization with MatPlotLib

    Regex parsing and Task Management

    GUI and Gaming with Tkinter

    And much more!

If you read the above list and are feeling a bit confused, don’t worry! As an instructor and student on Udemy for almost 4 years, I know what it’s like to be overwhelmed with boring and mundane. I promise you’ll have a blast learning the ins and outs of python. I’ve successfully taught over 200,000+ students from over 200 countries jumpstart their programming journeys through my courses.

Here’s what some of my students have to say:

    “I wish I started programming at a younger age like Avi.  This Python course was excellent for those that cringe at the thought of starting over from scratch with attempts to write programs once again. Python is a great building language for any beginner programmer. Thank you Avi!”


    “I had no idea about any programming language. With Avi's lectures, I'm now aware of several python concepts and I'm beginning to write my own programs. Avi is crisp and clear in his lectures and it is easy to catch the concepts and the depth of it through his explanations. Thanks, Avi for the wonderful course, You're awesome! It's helping me a lot :)”


    "Videos are short and concise and well-defined in their title, this makes them easy to refer back to when a refresher is needed. Explanations aren't convoluted with complicated examples, which adds to the quick pace of the videos. I am very pleased with the decision to enroll in this course. Not only has it increased the pace I'm learning Python but I actively look forward to continuing the course, whenever I get the chance. Avi is friendly and energetic, absolutely delightful as an instructor.”

So what are you waiting for? Jumpstart your programming journey and dive into the world of Python by enrolling in this course today!""")),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lessons["lessons"].length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    Theme(
                                      data: ThemeData().copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(

                                          // trailing:  const Icon(Icons.add,color: kBlack,),
                                          title: Text(
                                            "Section " +
                                                lessons['lessons'][i]["week"]
                                                    .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          children: List.generate(
                                              lessons['lessons'][i].length,
                                              (j) {
                                            var index = j + 1;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              LessonScreen
                                                                  .routeName);
                                                    },
                                                    child: ListTile(
                                                      // trailing: completion
                                                      //     .contains(datas
                                                      //     .lessons![
                                                      // i]
                                                      //     .id)
                                                      //     ? const Icon(
                                                      //   Icons
                                                      //       .check_circle,
                                                      //   color: Colors
                                                      //       .green,
                                                      // )
                                                      //     : null,
                                                      title: Text(
                                                        "Lecture $index : " +
                                                            lessons['lessons']
                                                                        [i][
                                                                    "lessons"][j]
                                                                ["lessonTitle"],
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      // trailing: completion
                                                      //         .contains(datas
                                                      //             .lessons[i]
                                                      //             .id)
                                                      //     ? Icon(
                                                      //         Icons
                                                      //             .check_circle,
                                                      //         color: Colors
                                                      //             .green,
                                                      //       )
                                                      //     : null,\
                                                      // onTap: () {
                                                      //   Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder:
                                                      //             (context) =>
                                                      //             Lessoncontent(
                                                      //               data: datas,
                                                      //               moduleSlug: widget.moduleslug,
                                                      //               index: i,
                                                      //             )),
                                                      //   );
                                                      // },
                                                      // onTap: () async {
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //       builder:
                                                      //           (context) =>

                                                      // );
                                                      //   final SharedPreferences
                                                      //       sharedPreferences =
                                                      //       await SharedPreferences
                                                      //           .getInstance();
                                                      //   sharedPreferences
                                                      //       .setString(
                                                      //           'lessonId',
                                                      //           datas
                                                      //               .lessons[
                                                      //                   i]
                                                      //               .id);
                                                      // },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: 60,),
                      )
                    ])))));
  }
}
