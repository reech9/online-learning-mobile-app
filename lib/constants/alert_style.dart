import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

var commonAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,

  isOverlayTapDismiss: false,

  descStyle: const TextStyle(fontWeight: FontWeight.bold),
  animationDuration:const Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
    side: const BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: const TextStyle(
    color: Color.fromRGBO(91, 55, 185, 1.0),
  ),
);