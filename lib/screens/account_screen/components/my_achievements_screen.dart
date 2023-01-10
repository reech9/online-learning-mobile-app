import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/widgets/explore_button.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/api_response.config.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/continueLearning_button.dart';
import '../../course_detail/course_detail.dart';
import '../../my_learning_screen/my_learning_screen.dart';
import '../account_screen.dart';
import 'Certificate_Componenets/certificate_screen.dart';
import 'achievement_card.dart';

class MyAchievement extends StatefulWidget {
  const MyAchievement({Key? key}) : super(key: key);

  static const String routeName = "/MyAchievement";

  @override
  State<MyAchievement> createState() => _MyAchievementState();
}

class _MyAchievementState extends State<MyAchievement> {
  late CommonViewModel common;
  late AuthViewModel auth;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      auth = Provider.of<AuthViewModel>(context, listen: false);
      common = Provider.of<CommonViewModel>(context, listen: false);
      getAll(common, auth);
    });
    super.initState();
  }

  Future<void> getAll(CommonViewModel common, AuthViewModel auth) async {
    if (auth.loggedIn) {
      common.getCertificate();
    }
  }

  Widget build(BuildContext context) {
    return Consumer<CommonViewModel>(builder: (context, common, child) {
      return Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [kPrimaryColor, Colors.black])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: RefreshIndicator(
                  edgeOffset: 80,
                  onRefresh: () => getAll(common, auth),
                  child: CustomScrollView(slivers: <Widget>[
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      toolbarHeight: 50,
                      titleSpacing: 10,
                      elevation: 8,
                      backgroundColor: Colors.transparent,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      title: Container(
                        margin: const EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        height: 50,
                        decoration: BoxDecoration(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.chevron_left)),
                            scafoldHeader(
                              "My Achievements",
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            if (common.achievementData.isEmpty)
                              Container(
                                // color: Colors.red,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30.0, horizontal: 10),
                                        child: Image.asset(
                                            "assets/images/landing/notfound.png",
                                            height: 300,
                                            width: 300,
                                            fit: BoxFit.fitWidth),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Seems like you haven't completed any course yet!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: h5,
                                          fontWeight: FontWeight.w500,
                                          color: kWhite,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            continueLearningButton(
                                              title: "Continue Your Learning",
                                              icon: Icons.arrow_forward,
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyLearningScreen(),
                                                    ));
                                                common.itemTapped(1);
                                              },
                                            )
                                          ])
                                    ]),
                              ),
                            if (common.achievementData.isNotEmpty)
                              ...List.generate(
                                  common.achievementData.length,
                                  (index) => Builder(builder: (context) {
                                        // print(common
                                        //     .achievementData[index].course!);
                                        return AchievementCard(
                                            title: common.achievementData[index]
                                                .course!.first.courseTitle
                                                .toString(),
                                            image:
                                                "assets/images/landing/certificateFront.png",
                                            onClick: () {
                                              Map<String, dynamic> data = {
                                                "course": common
                                                    .achievementData[index]
                                                    .course!
                                                    .first,
                                                "user": common
                                                    .achievementData[index]
                                                    .user!
                                                    .first
                                              };
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        GeneratedCertificate(
                                                            coursefinal: common
                                                                .achievementData[
                                                                    index]
                                                                .course!
                                                                .first,
                                                            userfinal: common
                                                                .achievementData[
                                                                    index]
                                                                .user!
                                                                .first),
                                                  ));
                                            });
                                      }))
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ));
    });
  }
}
