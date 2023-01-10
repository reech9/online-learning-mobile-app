import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/course_detail/course_detail.dart';
import 'package:digi_school/screens/login/login_email/loginemail_screen.dart';
import 'package:digi_school/screens/login/login_screen.dart';
import 'package:digi_school/screens/wishlist_screen/components/wishlist_card.dart';
import 'package:digi_school/widgets/explore_button.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth_viewmodel.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late CommonViewModel common;
  late AuthViewModel auth;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      auth = Provider.of<AuthViewModel>(context, listen: false);
      common = Provider.of<CommonViewModel>(context, listen: false);
      getAll(common, auth);
    });

    super.initState();
  }

  Future<void> getAll(CommonViewModel common, AuthViewModel auth) async {
    if (auth.loggedIn) {
      common.getWishlist();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommonViewModel>(builder: (context, common, child) {
      return Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [kPrimaryColor, Colors.black])),
          child: SafeArea(
              child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: RefreshIndicator(
                    edgeOffset: 80,
                    onRefresh: () => getAll(common, auth),
                    child: CustomScrollView(slivers: <Widget>[
                      SliverAppBar(
                        toolbarHeight: 50,
                        titleSpacing: 10,
                        backgroundColor: Colors.transparent,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        title: Container(
                          margin: const EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          height: 50,
                          decoration: const BoxDecoration(
                              // color: Colors.red
                              ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [scafoldHeader("My Wishlist")],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            if (common.wishlist.isEmpty)
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset("assets/images/empty.png"),
                                      Text(
                                        "It seems like your wishlist is empty",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: h5,
                                            fontWeight: FontWeight.w500,
                                            color: kWhite),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ExploreButton(
                                              title: "Explore",
                                              icon: Icons.arrow_forward,
                                              onTap: () {
                                                common.itemTapped(1);
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (common.wishlist.isNotEmpty)
                              ...List.generate(
                                  common.wishlist.length,
                                  (index) =>
                                      common.wishlist[index].course == null
                                          ? Container()
                                          : WishlistCard(
                                              title: common.wishlist[index]
                                                  .course!.courseTitle
                                                  .toString(),
                                              subTitle: common.wishlist[index]
                                                  .course!.courseDesc
                                                  .toString(),
                                              image:
                                                  "assets/images/landing/images-1.jpg",
                                              onClick: () {
                                                Navigator.of(context).pushNamed(
                                                    CourseDetail.routeName,
                                                    arguments: common
                                                        .wishlist[index]
                                                        .course!
                                                        .courseSlug
                                                        .toString());
                                              },
                                              onRemove: () {
                                                common.removeFromWishList(common
                                                    .wishlist[index].course!.id
                                                    .toString());
                                              },
                                            )),
                          ],
                        ),
                      )
                    ]
                    ),
                  ))));
    });
  }
}
