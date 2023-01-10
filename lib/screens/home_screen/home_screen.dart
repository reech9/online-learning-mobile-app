import 'dart:convert';

import 'package:digi_school/api/models/category.dart';
import 'package:digi_school/api/response/category_response.dart';
import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/configs/preference.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/demo.dart';
import 'package:digi_school/constants/fonts.dart';
// import 'package:digi_school/screens/Test/Screens/course_testscreen.dart';
import 'package:digi_school/screens/become_lecturer/become_lecturer.dart';
import 'package:digi_school/screens/cart_screen/cart_screen.dart';
import 'package:digi_school/screens/home_screen/components/Course_test.dart';
import 'package:digi_school/screens/home_screen/components/course_check.dart';
import 'package:digi_school/screens/home_screen/components/home_item_list.dart';
import 'package:digi_school/screens/home_screen/components/infinityscroll_home.dart';
import 'package:digi_school/screens/home_screen/home_view_model.dart';
import 'package:digi_school/screens/landing/landing_screen.dart';
import 'package:digi_school/screens/login/login_email/loginemail_screen.dart';
import 'package:digi_school/screens/login/login_screen.dart';
import 'package:digi_school/screens/notification_screen/notification_screen.dart';
import 'package:digi_school/screens/search_screen/search_viewmodel.dart';
import 'package:digi_school/widgets/explore_button.dart';
import 'package:digi_school/widgets/why_digischool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/popup_box.dart';
import '../search_screen/search_screen.dart';
import 'components/category_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  List<Map<String, dynamic>> demo = [];
  List<String> demoCategories = [];
  dynamic datas;
  List<Category>? _category;
  late ScrollController _scrollController;
  late CommonViewModel _commonProvider;
  // final Uri _url = Uri.parse('https://digischoolglobal.com/become-a-lecturer');
  late HomeViewModel _homeViewModel;
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences sharedPreferences = PreferenceUtils.instance;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // init data
      _commonProvider = Provider.of<CommonViewModel>(context, listen: false);
      _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

      _homeViewModel.fetchCourses("");
    });

    datas = sharedPreferences.getStringList('recommendation');
    _scrollController = ScrollController()
      ..addListener(() {
        if (!_scrollController.position.isScrollingNotifier.hasListeners &&
            _scrollController.offset >=
                _scrollController.position.maxScrollExtent
            // && !_scrollController.position.outOfRange
            &&
            notLoading(_homeViewModel.loadmorecourseApiResponse)) {
          loadMore();
        }
      });
    super.initState();
  }


  Future<void> loadMore() async {
    Provider.of<HomeViewModel>(context, listen: false).loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, CommonViewModel>(
        builder: (context, auth, common, child) {
      return Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [kPrimaryColor, Colors.black])),
          child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child:
            CustomScrollView(controller: _scrollController, slivers: <Widget>[
          SliverAppBar(
            toolbarHeight: 40,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            pinned: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!auth.loggedIn)
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Loginemailscreen.routeName);
                    },
                    child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  fontSize: p1,
                                  fontWeight: FontWeight.w700,
                                  color: kWhite),
                            ))),
                  ),
                // if (auth.loggedIn)
                //   InkWell(
                //     borderRadius: BorderRadius.circular(10),
                //     onTap: () {
                //       Navigator.pushNamed(context, CartScreen.routeName);
                //     },
                //     child: Container(
                //         padding: EdgeInsets.symmetric(
                //             vertical: 5, horizontal: 5),
                //         child: Icon(
                //           Icons.shopping_bag_outlined,
                //           color: kBlack,
                //         )),
                //   ),
                if (auth.loggedIn)
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.pushNamed(
                          context, NotificationScreen.routeName);
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: Stack(
                          children: [
                            Icon(
                              common.unReadNotifications > 0
                                  ? Icons.notifications_active_outlined
                                  : Icons.notifications_none_outlined,
                              color: kWhite,
                              size: 30,
                            ),
                            Visibility(
                              visible: common.unReadNotifications > 0,
                              child: Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    common.unReadNotifications.toString(),
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  )
              ],
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/girl.png'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Learn with njonjvs",
                      style: TextStyle(color: Colors.red, fontSize: h5),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Join Today And Start Learning",
                      style: TextStyle(color: kWhite, fontSize: h4),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ExploreButton(
                        title: "Explore",
                        icon: Icons.arrow_forward,
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                          common.itemTapped(1);
                        }),


                    // ExploreButton(
                    //     title: "HelloTest",
                    //     icon: Icons.arrow_forward,
                    //     onTap: () {
                    //
                    //       // Navigator.pushNamed(contexts, PopupMessage.routeName);
                    //
                    //       // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeSetScreen(),));
                    //
                    //
                    //    }),
                    const SizedBox(
                      height: 15,
                    ),

                    // Container(
                    //   child: Image.asset(
                    //     "assets/images/landing/quiz.jpg",
                    //     width: double.infinity,
                    //     height: 230,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: const [
                    //       Text(
                    //         "Welcome",
                    //         style: TextStyle(
                    //             fontSize: h3, fontWeight: FontWeight.w600),
                    //       ),
                    //       Text(
                    //         "Digischool. Adapt. Learn.",
                    //         style: TextStyle(
                    //             fontSize: h4, fontWeight: FontWeight.w500),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       // isLoading(home.courseApiResponse ) ? const CircularProgressIndicator() :Builder(builder: (context) {
                    //       //   home.courses.shuffle();
                    //       //   return HomeItemList(
                    //       //     title: "Featured",
                    //       //     data: home.courses,
                    //       //   );
                    //       // }),
                    //
                    //       const SizedBox(
                    //         height: 15,
                    //       ),
                    //       CourseTest(id: "", title: "Featured"),
                    //       // ...List.generate(home.courses.length, (i) => Text(home.courses[i].courseTitle.toString())),
                    //       CategoryList(
                    //         title: "Categories",
                    //       ),
                    //
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Card(
                    //           child: Container(
                    //             height: 80,
                    //             child: GestureDetector(
                    //               onTap: () {
                    //                 // Navigator.of(context).pushNamed('/support');
                    //               },
                    //               child: Row(
                    //                 children: <Widget>[
                    //                   Expanded(
                    //                     flex: 1,
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.only(
                    //                           left: 10.0, top: 0),
                    //                       child: SizedBox(
                    //                           height: 60,
                    //                           width: 60,
                    //                           child: Image.asset(
                    //                               "assets/images/call-center.png")),
                    //                     ),
                    //                   ),
                    //                   Expanded(
                    //                     flex: 7,
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.only(
                    //                           left: 15, top: 20),
                    //                       child: Column(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: const <Widget>[
                    //                           Text(
                    //                               "Digi school help and support",
                    //                               style: TextStyle(
                    //                                   fontSize: 16,
                    //                                   fontWeight:
                    //                                       FontWeight.bold)),
                    //                           SizedBox(
                    //                             height: 6,
                    //                           ),
                    //                           Text(
                    //                               "Get quick support on your queries",
                    //                               style:
                    //                                   TextStyle(fontSize: 13)),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       TextButton(
                    //           onPressed: () {
                    //             Navigator.pushReplacementNamed(
                    //                 context, LandingScreen.routeName);
                    //           },
                    //           child: const Text("Edit you preferences",
                    //               style: TextStyle(color: kPrimaryColor))),
                    //
                    //       for (int i = 0; i < datas.length; i++)
                    //         Column(
                    //           children: [
                    //             CourseTest(
                    //                 id: datas[i],
                    //                 title: i == 0
                    //                     ? "Recommendation"
                    //                     : i == 1
                    //                         ? "Students also like"
                    //                         : "Other related course"),
                    //           ],
                    //         ),
                    //
                    //       InfinityScrollHome()
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(child: CourseTest(id: "", title: "Featured Courses")),
              const SizedBox(
                height: 20,
              ),
              CategoryList(
                title: "Subjects",
              ),
              const SizedBox(
                height: 20,
              ),

              // Container(
              //     child: CourseTest(id: datas.first, title: "Recommendations")),
              const SizedBox(
                height: 20,
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 13.0),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.pushReplacementNamed(
              //           context, LandingScreen.routeName);
              //     },
              //     child: Row(
              //       children: [
              //         Text(
              //           "Change preferences",
              //           style: TextStyle(
              //               fontWeight: FontWeight.w500,
              //               fontSize: h5,
              //               color: kWhite),
              //         ),
              //         Icon(
              //           Icons.settings,
              //           color: kWhite,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),

              WhyDigiSchoolBody(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Become a Lecturer',
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: h4),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Teach on Digi School, Join one of the largest online learning marketplace in Nepal',
                      style: TextStyle(
                          color: kWhite,
                          // fontWeight: FontWeight.bold,
                          fontSize: p1),
                    ),
                   const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Image.asset(
                          'assets/images/maskot1.png',
                        )),
                        const SizedBox(
                          width: 50,
                        ),
                        Expanded(
                            child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(primary: Colors.pink),
                          onPressed: _launchUrl,
                          label: const Text("Get Started"),
                          icon: const Icon(Icons.arrow_forward),
                        )),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     "Top Courses",
              //     style: TextStyle(
              //         color: kWhite, fontSize: h5, fontWeight: FontWeight.w500),
              //   ),
              // ),
              // InfinityScrollHome(),
              // for (int i = 0; i < datas.length; i++)
              //   Column(
              //     children: [
              //       CourseTest(
              //           id: datas[i],
              //           title: i == 0
              //               ? "Recommendation"
              //               : i == 1
              //               ? "Students also like"
              //               : "Other related course"),
              //     ],
              //   ),
              // Container(child: CourseTest(id: datas.first, title: "Recommended course for you")),

              const SizedBox(
                height: 100,
              ),
            ],
          )),
        ]),
      ));
    });
  }

  @override
  bool get wantKeepAlive => true;
}
final Uri _url = Uri.parse('https://digischoolglobal.com/become-a-lecturer');
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
  }
// import 'dart:ui';
//
// import 'package:digi_school/constants/colors.dart';
// import 'package:digi_school/constants/fonts.dart';
// import 'package:digi_school/widgets/explore_button.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);
//   static String routeName = "/home";
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [kPrimaryColor, Colors.black])),
//       child: Scaffold(
//         // By defaut, Scaffold background is white
//         // Set its value to transparent
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//         ),
//         backgroundColor: Colors.transparent,
//         body: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           children: [
//             Image.asset('assets/images/girl.png'),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "Learn with Digischool",
//               style: TextStyle(color: Colors.red, fontSize: h5),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "Join Today And Start Learning",
//               style: TextStyle(color: kWhite, fontSize: h4),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             ExploreButton()
//           ],
//         ),
//       ),
//     );
//   }
// }
