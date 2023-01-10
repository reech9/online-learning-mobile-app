import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/configs/share.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/demo.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/course_detail/course_detail_viewmodel.dart';
import 'package:digi_school/screens/instructor_screen/components/instructor_footer.dart';
import 'package:digi_school/screens/instructor_screen/instructor_viewmodel.dart';
import 'package:digi_school/screens/my_learning_screen/components/my_learning_shimmer.dart';
import 'package:digi_school/widgets/cache_image_util.dart';
import 'package:digi_school/widgets/string_util.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:digi_school/widgets/list_card_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'components/my_courses.dart';

class InstructorScreen extends StatefulWidget {
  InstructorScreen({Key? key, this.id = ""}) : super(key: key);
  String id = "";
  static const String routeName = "/instructor";
  @override
  _InstructorScreenState createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InstructorViewModel>(
        create: (_) => InstructorViewModel(),
        child: InstructorBody(
          id: widget.id,
        ));
  }
}

class InstructorBody extends StatefulWidget {
  InstructorBody({Key? key, this.id = ""}) : super(key: key);
  String id = "";
  @override
  _InstructorBodyState createState() => _InstructorBodyState();
}

class _InstructorBodyState extends State<InstructorBody> {
  Map<String, dynamic> demoInstructor = {};
  List<Map<String, dynamic>> demo = [];
  late CourseDetailViewModel data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    demoInstructor = demoInstrcutor;
    demo = dummyProduct.toList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data = Provider.of<CourseDetailViewModel>(context,listen:false);
      getAll(data, widget.id);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<CourseDetailViewModel>(
        builder: (context, data, child) {
        return Scaffold(
            body: Container(
                color: kWhite,
                child: SafeArea(
                    child: ScrollConfiguration(
                        behavior:
                            const ScrollBehavior().copyWith(overscroll: false),
                        child: RefreshIndicator(
                          edgeOffset: 50,
                          onRefresh:   ()=>getAll(data, widget.id),
                          child: CustomScrollView(slivers: <Widget>[
                            SliverAppBar(
                              toolbarHeight: 50,
                              backgroundColor: kWhite,
                              pinned: true,
                              automaticallyImplyLeading: true,
                              leading: backButton(context),
                              titleSpacing: 0,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  scafoldHeader("Instructor"),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    alignment: Alignment.centerRight,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        // color: Colors.red
                                        ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () =>
                                                shareUrl("title", "google.com"),
                                            borderRadius: BorderRadius.circular(20),
                                            child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Icon(
                                                  Icons.share,
                                                  color: kBlack,
                                                ))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SliverToBoxAdapter(
                              child:
                              isLoading(data.instructorDetailApiResponse) ?
                              MyLearningShimmer()
                                  :
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child:
                                          CacheImageUtil(
                                            image: data.instructor!.user!.userImage!,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${capitalize(data.instructor!.user!.firstname.toString())} ${capitalize(data.instructor!.user!.lastname.toString())}",
                                                style: TextStyle(
                                                    color: kBlack,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: h2),
                                              ),
                                              Text(
                                                data.instructor!.user!.email.toString(),
                                                style: TextStyle(
                                                    color: kBlack, fontSize: p1),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Total students",
                                                style: TextStyle(
                                                    color: kBlack,
                                                    fontSize: p2,
                                                    fontWeight: FontWeight.w500)),
                                            Text(
                                              data.instructor!.summary!.learnerCount.toString(),
                                              style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: h5,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        // Column(
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text("Courses",
                                        //         style: TextStyle(
                                        //             color: kBlack,
                                        //             fontSize: p2,
                                        //             fontWeight: FontWeight.w500)),
                                        //     Text(
                                        //       data.instructor!.summary!.courseCount.toString(),
                                        //       style: TextStyle(
                                        //           color: kBlack,
                                        //           fontSize: h5,
                                        //           fontWeight: FontWeight.w600),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Builder(builder: (context) {
                                      bool loadMore = false;
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "About Me",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: p1),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              data.instructor!.user
                                                  .toString(),
                                              maxLines: loadMore
                                                  ? double.maxFinite.toInt()
                                                  : 5,
                                              style: TextStyle(
                                                color: kBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  loadMore = !loadMore;
                                                });
                                              },
                                              child: Text(
                                                loadMore ? "Show Less" : "Show More",
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: p1),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                    }),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  MyCourseWidget(courses: data.instructor!.courses!),
                                  SizedBox(height: 20,),
                                  InstructorFooter(),
                                  SizedBox(height: 20,),

                                ],
                              ),
                            )
                          ]),
                        )))));
      }
    );
  }

  Future<void> getAll(CourseDetailViewModel data, String id) async {
    await data.getInstructor(id);
  }
}
