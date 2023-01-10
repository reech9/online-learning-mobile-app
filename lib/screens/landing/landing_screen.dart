// import 'dart:async';
// import 'dart:convert';
//
// import 'package:digi_school/api/models/category.dart';
// import 'package:digi_school/constants/colors.dart';
// import 'package:digi_school/constants/fonts.dart';
// import 'package:digi_school/screens/landing/models/slide.dart';
// import 'package:digi_school/screens/landing/widgets/slide_dots.dart';
// import 'package:digi_school/screens/landing/widgets/slide_item.dart';
// import 'package:digi_school/screens/login/login_screen.dart';
// import 'package:digi_school/screens/navigation/navigation_screen.dart';
// import 'package:digi_school/screens/search_screen/components/top_categoeies.dart';
// import 'package:digi_school/screens/search_screen/search_viewmodel.dart';
// import 'package:digi_school/widgets/snakbar.utils.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../configs/preference.config.dart';
//
// class LandingScreen extends StatefulWidget {
//   const LandingScreen({Key? key}) : super(key: key);
//   static const String routeName = "/landing";
//   @override
//   _LandingScreenState createState() => _LandingScreenState();
// }
//
// class _LandingScreenState extends State<LandingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SearchViewModel>(builder: (context, value, child) {
//       return Container(
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [kPrimaryColor, Colors.black])),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             title: const Text(
//               "What are you interested in?",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: kWhite, fontSize: h5),
//             ),
//             backgroundColor: Colors.transparent,
//             elevation: 0.0,
//           ),
//           body: ListView(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             children: [
//               const Text(
//                 "Select field of your interest to get personlized recommendations that match your goals",
//                 textAlign: TextAlign.start,
//                 softWrap: true,
//                 style: TextStyle(fontSize: 16, color: kWhite),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               RichText(
//                 textAlign: TextAlign.start,
//                 text: const TextSpan(
//                   text: 'Choose any two',
//                   style: TextStyle(
//                     color: kWhite,
//                     fontSize: 15,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: ' *',
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               const TopCategoriesWidget(screen: "landing"),
//             ],
//           ),
//           // body: Container(
//           //   color: Colors.white,
//           //   child: Padding(
//           //     padding: const EdgeInsets.all(20),
//           //     child: Column(
//           //       children: <Widget>[
//           //         Expanded(
//           //           child: Stack(
//           //             alignment: AlignmentDirectional.bottomCenter,
//           //             children: <Widget>[
//           //               PageView.builder(
//           //                 scrollDirection: Axis.horizontal,
//           //                 controller: _pageController,
//           //                 onPageChanged: _onPageChanged,
//           //                 itemCount: slideList.length,
//           //                 itemBuilder: (ctx, i) => SlideItem(i),
//           //               ),
//           //               Stack(
//           //                 alignment: AlignmentDirectional.topStart,
//           //                 children: <Widget>[
//           //                   Container(
//           //                     margin: const EdgeInsets.only(bottom: 35),
//           //                     child: Row(
//           //                       mainAxisSize: MainAxisSize.min,
//           //                       mainAxisAlignment: MainAxisAlignment.center,
//           //                       children: <Widget>[bac
//           //                         for (int i = 0; i < slideList.length; i++)
//           //                           if (i == _currentPage)
//           //                             SlideDots(true)
//           //                           else
//           //                             SlideDots(false)
//           //                       ],
//           //                     ),
//           //                   )
//           //                 ],
//           //               )
//           //             ],
//           //           ),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//           bottomNavigationBar: BottomAppBar(
//             color: kPrimaryColor,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 MaterialButton(
//                   child: Text(
//                     "Continue",
//                     style: TextStyle(
//                       color: Colors.grey.shade300,
//                       fontSize: 20.0,
//                     ),
//                   ),
//                   onPressed: () async {
//                     if (value.recommendation.length < 2) {
//                       snackThis(
//                           context: context,
//                           color: Colors.red,
//                           content: Text("Select atleast two categories"));
//                     } else {
//                       final SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//
//                       await prefs.setStringList(
//                           'recommendation', value.recommendation);
//                       Navigator.pushReplacementNamed(
//                           context, NavigationScreen.routeName);
//                     }
//
//                     // Navigator.pushReplacement(
//                     //   context,
//                     //   PageTransition(
//                     //     child: NavigationScreen(data: 0,),
//                     //       // child: await prefStorage.isLoggedIn()`
//                     //       //     ? HomeScreen()
//                     //       //     : SignInPage(),
//                     //       type: PageTransitionType.leftToRightWithFade),
//                     // );
//                   },
//                 ),
//                 // MaterialButton(
//                 //     child: Text(
//                 //       "Sign In",
//                 //       style: TextStyle(
//                 //         color: Colors.grey.shade300,
//                 //         fontSize: 20.0,
//                 //       ),
//                 //     ),
//                 //     onPressed: () =>
//                 //         Navigator.pushNamed(context, LoginScreen.routeName)),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
