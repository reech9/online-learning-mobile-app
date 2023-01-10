import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/screens/account_screen/account_screen.dart';
import 'package:digi_school/screens/home_screen/home_screen.dart';
import 'package:digi_school/screens/my_learning_screen/my_learning_screen.dart';

import 'package:digi_school/screens/search_screen/search_screen.dart';

import 'package:digi_school/screens/account/account_screen.dart';
import 'package:digi_school/screens/wishlist_screen/wishlist_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../common_viewmodel.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../notifications/fcm_service.dart';
import '../account_screen/components/my_achievements_screen.dart';

class NavigationScreen extends StatefulWidget {
  final data;
  String? redirect;
  String? args;
  NavigationScreen({Key? key, required this.data, this.redirect, this.args})
      : super(key: key);
  static const String routeName = "/home_screen";

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  PageController pagecontroller = PageController();
  int selectedIndex = 1;
  String title = 'Home';

  _onPageChanged(int index) {
    // onTap
    common.setNavigationIndex(index);
    setState(() {
      switch (index) {
        case 0:
          {
            title = 'Home';
          }
          break;
        case 1:
          {
            title = 'Search';
          }
          break;
        case 2:
          {
            title = 'My Learning';
          }
          break;
        case 3:
          {
            title = 'Wishlist';
          }
          break;
        case 4:
          {
            title = 'Profile';
          }
          break;
      }
    });
  }
  late CommonViewModel common;
  late AuthViewModel auth;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      auth = Provider.of<AuthViewModel>(context, listen: false);
      common = Provider.of<CommonViewModel>(context, listen: false);

      registerNotification(context, common, auth);
      getAll(common, auth);
    });

    super.initState();
  }

  void getAll(CommonViewModel common, AuthViewModel auth) {
    if (auth.loggedIn) {
      common.signin();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      common.setInitial(widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommonViewModel>(builder: (context, common, child) {
      print("NAVIGATION :: " + common.navigationIndex.toString());
      return WillPopScope(
        onWillPop: () {
          if (common.navigationIndex == 0) {
            showMaterialModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                backgroundColor: kWhite,
                builder: (context) {
                  return Container(
                    constraints: BoxConstraints(maxHeight: 600),
                    child: SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Do you want to quit the application?",
                                style: TextStyle(
                                    fontSize: p1,
                                    fontWeight: FontWeight.w800,
                                    color: gray_900),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: gray_900),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                kPrimaryColor),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                      onPressed: () {
                                        SystemNavigator.pop();
                                      },
                                      child: Text("Quit"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  );
                });
          } else {
            common.itemTapped(0);
          }

          return Future.value(false);
        },
        child: Scaffold(
          extendBody: true,
          key: common.homeKey,
          // backgroundColor: Color(0x00ffffff),
          // backgroundColor: Color(0x00ffffff),

          backgroundColor: Colors.transparent,

          body: Stack(
            children: <Widget>[
              PageView(
                controller: common.pageController,
                children: <Widget>[
                  HomeScreen(),
                  SearchScreen(),
                  MyLearningScreen(),
                  WishlistScreen(),
                  AccountScreen(),

                  // MyAchievement(),

                ],
                onPageChanged: _onPageChanged,
                physics: const NeverScrollableScrollPhysics(),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Theme(
                      data: Theme.of(context)
                          .copyWith(canvasColor: Colors.black),
                      child: BottomNavigationBar(
                        // backgroundColor: Colors.black.withOpacity(
                        //     0), //here set your transparent level

                        selectedItemColor: Colors.white,
                        unselectedItemColor: Colors.white,
                        type: BottomNavigationBarType.fixed,
                        currentIndex: common.navigationIndex,
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        onTap: common.itemTapped,

                        items: [
                          BottomNavigationBarItem(
                              icon: Image.asset(
                                'assets/icons/home.png',
                                height: common.navigationIndex == 0 ? 35 : 25,
                                width: common.navigationIndex == 0 ? 35 : 25,
                                color: common.navigationIndex == 0
                                    ? kWhite
                                    : kWhite,
                              ),
                              label: 'Home'),
                          BottomNavigationBarItem(
                            icon: Image.asset(
                              'assets/icons/loupe.png',
                              height: common.navigationIndex == 1 ? 35 : 25,
                              width: common.navigationIndex == 1 ? 35 : 25,
                              color: common.navigationIndex == 1
                                  ? kWhite
                                  : kWhite,
                            ),
                            label: 'search',
                          ),
                          BottomNavigationBarItem(
                              icon: Image.asset(
                                'assets/icons/play.png',
                                height: common.navigationIndex == 2 ? 35 : 25,
                                width: common.navigationIndex == 2 ? 35 : 25,
                                color: common.navigationIndex == 2
                                    ? kWhite
                                    : kWhite,
                              ),
                              label: 'learning'),
                          BottomNavigationBarItem(
                              icon: Image.asset(
                                'assets/icons/wishlist.png',
                                height: common.navigationIndex == 3 ? 35 : 25,
                                width: common.navigationIndex == 3 ? 35 : 25,
                                color: common.navigationIndex == 3
                                    ? kWhite
                                    : kWhite,
                              ),
                              label: 'Wishlist'),
                          BottomNavigationBarItem(
                              icon: Image.asset(
                                'assets/icons/user.png',
                                height: common.navigationIndex == 4 ? 35 : 25,
                                width: common.navigationIndex == 4 ? 35 : 25,
                                color: common.navigationIndex == 4
                                    ? kWhite
                                    : kWhite,
                              ),
                              label: 'Account')
                        ],
                      ))),
            ],
          ),

          // body: PageView(
          //   controller: common.pageController,
          //   children: <Widget>[
          //     HomeScreen(),
          //     SearchScreen(),
          //     WishlistScreen(),
          //     MyLearningScreen(),
          //     AccountScreen(),
          //   ],
          //   onPageChanged: _onPageChanged,
          //   physics: const NeverScrollableScrollPhysics(),
          // ),
          // bottomNavigationBar: BottomAppBar(
          //   shape: CircularNotchedRectangle(),
          //   notchMargin: 10,
          //   clipBehavior: Clip.antiAlias,
          //   child: BottomNavigationBar(
          //     elevation: 0,
          //     selectedItemColor: primary_2,
          //     unselectedItemColor: gray_900,
          //     selectedLabelStyle: TextStyle(color: primary_2),
          //     unselectedLabelStyle: TextStyle(color: gray_900),
          //     selectedFontSize: 12,
          //     unselectedFontSize: 12,
          //     currentIndex: common.navigationIndex,
          //     backgroundColor: Color(0x00ffffff),
          //     onTap: common.itemTapped,
          //     type: BottomNavigationBarType.fixed,
          //     items: [
          //       BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.home,
          //           color: common.navigationIndex == 0 ? primary_2 : gray_900,
          //         ),
          //         label: 'Home',
          //       ),
          //       BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.search,
          //           color: common.navigationIndex == 1 ? primary_2 : gray_900,
          //         ),
          //         label: 'Search',
          //       ),
          //       BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.star,
          //           color: common.navigationIndex == 2 ? primary_2 : gray_900,
          //         ),
          //         label: 'Wishlist',
          //       ),
          //       BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.play_circle_fill_outlined,
          //           color: common.navigationIndex == 3 ? primary_2 : gray_900,
          //         ),
          //         label: 'Learnings',
          //       ),
          //       BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.supervisor_account_rounded,
          //           color: common.navigationIndex == 4 ? primary_2 : gray_900,
          //         ),
          //         label: 'Account',
          //       ),
          //     ],
          //   ),
          // ),
        ),
      );
    });
  }
}
