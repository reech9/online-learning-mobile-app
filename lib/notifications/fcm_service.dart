

import 'dart:convert';

import 'package:digi_school/api/response/notification_response.dart';
import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/notifications/local_notification_service.dart';
import 'package:digi_school/notifications/notification_click_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

void registerNotification(BuildContext context, CommonViewModel _common, AuthViewModel auth) async {
  await Firebase.initializeApp();
  // 2. Instantiate Firebase Messaging
  var _messaging = FirebaseMessaging.instance;
  _messaging.getToken().then((value) {
    auth.setFcm(value.toString());
  });
  LocalNotificationService.common = _common;
  // 3. On iOS, this helps to take the user permissions
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );


  NotificationData makeNotificationPreprocess(RemoteMessage message){
    print(message.data.toString());
    print(message.notification!.android!.imageUrl.toString());
    String imageUrl = "";
    try{
      if(message.data["image"]!=null || message.data["image"]!=""){
        imageUrl = message.data["image"];
      }
    }catch(e){}
    return NotificationData(
      notificationTitle: message.data["title"].toString(),
      notificationContent: message.notification!.body,
      clickAction: message.data["click_action"].toString(),
      imageUrl: imageUrl,
      link: message.data["link"].toString(),
      url: message.data["url"].toString(),
      isExternal: message.data["is_external_link"] =="true",
    );
  }

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    FirebaseMessaging.instance.subscribeToTopic("android");
    // For handling the received notifications
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        if (message.notification != null) {
          NotificationData _data = makeNotificationPreprocess(message);
          notificationClickHandler(context, _data);
        }

        // try{
        //   if(message.notification!.title=="New Order"){
        //     Navigator.of(context).pushNamed(OrderScreenCustomer.routeName, arguments: "0");
        //   }
        //   if(message.notification!.title=="Order Cancellation"){
        //     Navigator.of(context).pushNamed(OrderScreenCustomer.routeName, arguments: "4");
        //   }
        // }catch(e){
        //   print("ERR :: "+ e.toString());
        // }
        //
        // final routeFromMessage = message.data['route'];
        // print(routeFromMessage);
      }
    });
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("fcm: " + token!);
    });

    //foreground notification
    FirebaseMessaging.onMessage.listen((message) {
      print("NOTIFICATION RECEIVED :: "+message.notification.toString());
      if (message.notification != null) {
        // print(message.notification!.)
        print(message.notification!.body);
        print(message.notification!.title);
      }
      message.data["route"]=json.encode(makeNotificationPreprocess(message).toJson());
      LocalNotificationService.display(message, context, _common);

    });

    //when the app is in background but opened and user taps
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("NOTIFICATION MESSAGE :: "+ message.toString());
      try {
        NotificationData _data = makeNotificationPreprocess(message);
        notificationClickHandler(context, _data);
      } catch (e) {
        print("ERR :: " + e.toString());
      }
    });
  } else {
    print('User declined or has not accepted permission');
  }


}


class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}


