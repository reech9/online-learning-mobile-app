import 'package:digi_school/api/models/course.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/course_detail/course_detail.dart';
import 'package:digi_school/screens/home_screen/components/all_course.dart';
import 'package:digi_school/screens/home_screen/home_view_model.dart';
import 'package:digi_school/widgets/list_card_product.dart';
import 'package:digi_school/widgets/single_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../constants/fonts.dart';

class CourseTest extends StatefulWidget {
  final id;
  final display;
  CourseTest({Key? key, this.display, this.id = "", this.title = ""})
      : super(key: key);
  String title = "";

  @override
  _CourseTestState createState() => _CourseTestState();
}

class _CourseTestState extends State<CourseTest> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      child: CourseTestBody(
          id: widget.id, display: widget.display, title: widget.title),
    );
  }
}

class CourseTestBody extends StatefulWidget {
  final id;
  final display;
  final title;
  const CourseTestBody({Key? key, this.id, this.display, this.title})
      : super(key: key);

  @override
  _CourseTestBodyState createState() => _CourseTestBodyState();
}

class _CourseTestBodyState extends State<CourseTestBody> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeViewModel>(context, listen: false)
          .fetchCourses(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, home, child) {
        return home.courses.isEmpty
            ? const SizedBox()
            : widget.display == "list"
                ? isLoading(home.courseApiResponse)
                    ? CircularProgressIndicator()
                    : Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...List.generate(
                                home.courses.length,
                                (index) => ListCardProduct(
                                      title: home.courses[index].courseTitle
                                          .toString(),
                                      user: "",
                                      image:
                                          home.courses[index].image.toString(),
                                      discount:
                                          home.courses[index].discount == null
                                              ? 0
                                              : home.courses[index].discount!,
                                      price: home.courses[index].price == null
                                          ? 0
                                          : home.courses[index].price!,
                                      rating: home.courses[index].rating == null
                                          ? 0
                                          : home.courses[index].rating!,
                                      onPress: () {
                                        Navigator.pushNamed(
                                            context, CourseDetail.routeName,
                                            arguments: home
                                                .courses[index].courseSlug
                                                .toString());
                                      },
                                    ))
                          ],
                        ),
                      )
                : isLoading(home.courseApiResponse)
                    ? CircularProgressIndicator()
                    : Container(
                        height: 300,
                        child: ListView(
                          shrinkWrap: true,
                          cacheExtent: 10,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                    color: kWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: h4),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (home.courses != null)
                                    ...List.generate(
                                        home.courses.length,
                                        (index) => Container(
                                              padding: EdgeInsets.only(
                                                  left: index == 0 ? 15 : 0,
                                                  right: 15,
                                                  bottom: 10),
                                              // title: home.courses[index].courseTitle
                                              //     .toString(),
                                              // user: "",
                                              // image: home.courses[index].image
                                              //     .toString(),
                                              // discount: home.courses[index].discount == null ? 0 : home.courses[index].discount!,
                                              // price:  home.courses[index].price==null ? 0 :  home.courses[index].price!,
                                              // rating: home.courses[index].rating==null ? 0 :  home.courses[index].rating!,
                                              child: SingleCard(
                                                title: home
                                                    .courses[index].courseTitle
                                                    .toString(),
                                                image: home.courses[index].image
                                                    .toString(),
                                                ratings: home.courses[index]
                                                            .rating ==
                                                        null
                                                    ? 0
                                                    : double.parse((home
                                                            .courses[index]
                                                            .rating!)
                                                        .toStringAsPrecision(
                                                            2)),
                                                price:
                                                    home.courses[index].price ==
                                                            null
                                                        ? 0
                                                        : home.courses[index]
                                                            .price!,
                                                discount: home.courses[index]
                                                            .discount ==
                                                        null
                                                    ? 0
                                                    : home.courses[index]
                                                        .discount!,
                                                ontap: () {
                                                  Navigator.pushNamed(context,
                                                      CourseDetail.routeName,
                                                      arguments: home
                                                          .courses[index]
                                                          .courseSlug
                                                          .toString());
                                                },
                                              ),
                                            )),
                                  // ...List.generate(size, (index) => Container(
                                  //   padding: EdgeInsets.only(left: index==0 ? 10 : 0, right: index==size ? 0: 10),
                                  //   child: SingleCard(
                                  //       title: "Test",
                                  //   ),
                                  // )),

                                  if (home.courses.length < 5)
                                    const SizedBox()
                                  else
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(context, PageTransition(child:Allcourse(), type: PageTransitionType.leftToRight));
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                child: Allcourse(
                                                  data: home.courses,
                                                  title: widget.title,
                                                ),
                                                type: PageTransitionType
                                                    .rightToLeftWithFade));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // color: Colors.red,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 100.0),
                                                child: Text(
                                                  "See all",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: h4,
                                                      color: kWhite),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
        // :   Center(
        //   child: Column(
        //     children: [
        //       Image.asset('assets/images/nodata.PNG',height: 200,),
        //       const Text("No course available",style: TextStyle(fontSize: h6,fontWeight: FontWeight.bold),)
        //     ],
        //   ),
        // );
      },
    );
  }
}
