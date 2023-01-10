
import 'dart:convert';

import 'package:digi_school/api/response/notification_response.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_click_handler.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static BuildContext? context;
  static CommonViewModel? common;
  static void initialize() {
    final InitializationSettings initializationSettings =

    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: IOSInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
        ));
    _notificationsPlugin.initialize(initializationSettings,onSelectNotification: (String ? route) async{
      print("ROUTE > "  +json.decode(route!).toString() );
      if(route!=null){
        try{
          notificationClickHandler(context!,  NotificationData.fromJson(json.decode(route)), common: common);
        }catch(e){print("ERR NOTIFICATION :: " + e.toString());}
        print(route);
      }

    });
  }

  static void display(RemoteMessage message, BuildContext _context, CommonViewModel _common) async {
    try{
      _common.addNotificationCount();
    }catch(e){
      print("NOTIFICATINO ADD ERR"+ e.toString());
    }
    try {
      // print("MESSAGEE :: " + message.da.toString());
      context = _context;
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "digishool",
            "digishool channel",
            channelDescription: "digischool channel",
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: IOSNotificationDetails()
      );
      await _notificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,payload: message.data["route"]);
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }
}

