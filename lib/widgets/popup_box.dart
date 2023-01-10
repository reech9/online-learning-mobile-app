import 'dart:ui';

import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/course_detail/achivement_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/account_screen/components/my_achievements_screen.dart';
import '../screens/course_detail/course_detail_viewmodel.dart';

class PopupMessage extends StatefulWidget {
  static String routeName = "/PopupMessage";
  PopupMessage(
      {Key? key, this.title = "", this.description = "", required this.slug})
      : super(key: key);

  String title = "";
  String description = "";
  String slug = "";

  @override
  State<PopupMessage> createState() => _PopupMessageState();
}

class _PopupMessageState extends State<PopupMessage> {
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

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() {
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 280,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: h4,
                        color: kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: p1,
                        color: kBlack),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyAchievement(),
                              )).then((value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => super.widget,
                              )));
                          // Navigator.pop(context);
                        },
                        child: Text(
                          "View",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: p0,
                              color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: -60,
              child: CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: 60,
                child: Image.asset(
                  "assets/images/trophy-icon.png",
                  fit: BoxFit.fill,
                ),
              ))
        ],
      ),
    );
  }
}
