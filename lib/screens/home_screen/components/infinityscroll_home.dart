import 'dart:math';

import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/home_screen/home_view_model.dart';
import 'package:digi_school/widgets/cache_image_util.dart';
import 'package:digi_school/widgets/list_card_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../widgets/single_card.dart';

class InfinityScrollHome extends StatefulWidget {
  const InfinityScrollHome({Key? key}) : super(key: key);

  @override
  _InfinityScrollHomeState createState() => _InfinityScrollHomeState();
}

class _InfinityScrollHomeState extends State<InfinityScrollHome> {
  ScrollController? _scrollController;

  bool _showBackToTopButton = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<HomeViewModel>(context, listen: false)
    //       .fetchCourses("");
    // });
    // _scrollController = ScrollController()
    //   ..addListener(() {
    //     if (_scrollController!.offset >=
    //         _scrollController!.position.maxScrollExtent &&
    //         !_scrollController!.position.outOfRange) {
    //       loadMore();
    //     }
    //     setState(() {
    //       if (_scrollController!.offset >= 300) {
    //         _showBackToTopButton = true; // show the back-to-top button
    //       } else {
    //         _showBackToTopButton = false; // hide the back-to-top button
    //       }
    //       if (_scrollController!.position.pixels <= 60) {
    //         _physics = const BouncingScrollPhysics();
    //       } else {
    //         _physics = const ClampingScrollPhysics();
    //       }
    //     });
    //   });
  }

  void _scrollToTop() {
    _scrollController!.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  ScrollPhysics _physics = ClampingScrollPhysics();

  Widget _buildSpinnerOnlyRefreshIndicator(
      BuildContext context,
      RefreshIndicatorMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent) {
    const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Opacity(
          opacity: opacityCurve
              .transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
          child: const CupertinoActivityIndicator(radius: 14.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeViewModel, CommonViewModel>(
        builder: (context, data, common, child) {
      return isLoading(data.courseApiResponse)
          ? Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            )
          : data.courses != []
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),

                        itemCount: data.courses.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){},
                            child:  SingleCard(
                              title: data
                                  .courses[index].courseTitle
                                  .toString(),
                              image: data.courses[index].image
                                  .toString(),
                              ratings: data.courses[index]
                                  .rating ==
                                  null
                                  ? 0
                                  : double.parse((data
                                  .courses[index]
                                  .rating!)
                                  .toStringAsPrecision(
                                  2)),
                              price:
                              data.courses[index].price ==
                                  null
                                  ? 0
                                  : data.courses[index]
                                  .price!,
                              discount: data.courses[index]
                                  .discount ==
                                  null
                                  ? 0
                                  : data.courses[index]
                                  .discount!,
                              ontap: () {
                                // Navigator.pushNamed(context,
                                //     CourseDetail.routeName,
                                //     arguments: home
                                //         .courses[index]
                                //         .courseSlug
                                //         .toString());
                              },
                            ),
                          );
                        },
                      ),
                      isLoadingOnly(data.loadmorecourseApiResponse)
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                  height: 160,
                                  child: Center(
                                      child: CircularProgressIndicator())))
                          : SizedBox(
                              height: 160,
                            ),
                    ],
                  ),
                )
              : Text("NO COURSE AVAILABLE");
    });
  }

  // Future<void> refreshPage() async {
  //   await Provider.of<C>(context, listen: false)
  //       .getactiveorder(status: _status, type: type);
  // }
  //
  // Future<void> loadMore() async {
  //   await Provider.of<ActiveorderViewModel>(context, listen: false)
  //       .loadMore(_status, type: type);
  // }
  //
  // bool loadMoreState(ActiveorderViewModel data) {
  //   return isLoading(data.loadMoreactiveorderApiResponse);
  // }
}
