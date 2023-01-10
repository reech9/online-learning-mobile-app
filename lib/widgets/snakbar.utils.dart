import 'package:digi_school/api/api_response.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

void
snackThis(
    {required BuildContext context,
    Widget content = const Text("Something Happened. Please try again."),
    int duration = 2,
    Color color = Colors.green,
    SnackBarBehavior behavior = SnackBarBehavior.floating}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Color changeColor = color;
    if (color.green > 100) {
      changeColor = green_1;
    } else if (color.red > 100) {
      changeColor = red_1;
    }
    Flushbar flush = Flushbar();
    dismiss() {
      flush.dismiss();
    }

    Widget changedContent = content;
    try {
      changedContent = Text(
        (content as Text).data.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      );
    } catch (e) {}
    flush = Flushbar(
      isDismissible: true,
      messageColor: Colors.white,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      backgroundColor: changeColor,
      duration: Duration(seconds: duration),
      messageText: TweenAnimationBuilder<Duration>(
          duration: Duration(seconds: duration),
          tween: Tween(begin: Duration(seconds: duration), end: Duration.zero),
          builder: (context, Duration value, Widget? child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 5, child: changedContent),
                InkWell(
                  onTap: () {
                    dismiss();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)),
                    child: Stack(
                      children: [
                        Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: kWhite,
                          value: value.inMilliseconds / (duration * 1000),
                        )),
                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.center,
                              child:  Container(
                                  child: Icon(
                                Icons.close,
                                color: kWhite,
                              ))),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    )..show(context);
  });
}

void snackThisWoBinding(
    {required BuildContext context,
    Widget content = const Text("Something Happened. Please try again."),
    int duration = 2,
    Color color = Colors.green,
    SnackBarBehavior behavior = SnackBarBehavior.floating}) {
  Color changeColor = Colors.green;
  if (color.green > 100) {
    changeColor = green_1;
  } else if (color.red > 100) {
    changeColor = red_1;
  }
  Flushbar flush = Flushbar();
  dismiss() {
    flush.dismiss();
  }

  Widget changedContent = content;
  try {
    changedContent = Text(
      (content as Text).data.toString(),
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
    );
  } catch (e) {}
  flush = Flushbar(
    isDismissible: true,
    messageColor: Colors.white,
    message: "",
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    backgroundColor: changeColor,
    duration: Duration(seconds: duration),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    messageText: TweenAnimationBuilder<Duration>(
        duration: Duration(seconds: duration),
        tween: Tween(begin: Duration(seconds: duration), end: Duration.zero),
        builder: (context, Duration value, Widget? child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 5, child: changedContent),
              InkWell(
                onTap: () {
                  dismiss();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50)),
                  child: Stack(
                    children: [
                      Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: kWhite,
                        value: value.inMilliseconds / (duration * 1000),
                      )),
                      Positioned.fill(
                        child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                child: Icon(
                              Icons.close,
                              color: kWhite,
                            ))),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
  )..show(context);
}

void commonSnackHacks(
    {required BuildContext context,
    required ApiResponse response,
    List<VoidCallback>? success,
    List<VoidCallback>? failure}) {
  if (isError(response)) {
    snackThis(
        context: context,
        color: Colors.red,
        content: Text(response.message.toString()));
    if (success != null) {
      for (var element in success) {
        element();
      }
    }
  } else {
    if (failure != null) {
      for (var element in failure) {
        element();
      }
    }
    snackThis(
        context: context,
        color: Colors.green,
        content: Text(response.message.toString()));
  }
}

void commonSnackHacksError({required BuildContext context, dynamic e}) {
  snackThis(context: context, color: Colors.red, content: Text(e.toString()));
}
