import 'dart:convert';

import 'package:digi_school/api/response/notification_response.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:flutter/material.dart';

import '../screens/course_detail/course_detail.dart';


void notificationClickHandler(BuildContext context, NotificationData e, {CommonViewModel? common}){

  try{
    print(e.clickAction.toString());
    if(e.clickAction!=null){
      switch(e.clickAction){
        case "profile":
          try{
            Navigator.popUntil(context, (route) => route.isFirst);
            common!.setNavigationIndex(4);
            common.itemTapped(4);
          }catch(e){
            print("ERR:: " + e.toString());
          }
          break;
        case "course":
          try{
            print(e.toJson().toString());
            String slug = e.url!.split("/").last;
            print("SLUG :: " + slug.toString());
            Navigator.pushNamed(context, CourseDetail.routeName, arguments: slug);
          }catch(e){
            print("NOTIFICATION COURSE :: "+ e.toString());
          }
          break;
        default:
          break;
      }


    }
  }catch(e){
    print("NOTIFIcATION HANLDE RRRPP :: "+ e.toString());
  }
}