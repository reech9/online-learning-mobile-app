import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/course_detail/components/course_detail_shimmer.dart';
import 'package:digi_school/screens/course_detail/course_detail_viewmodel.dart';
import 'package:digi_school/screens/routine_screen/routine_screen.dart';
import 'package:digi_school/widgets/cache_image_util.dart';
import 'package:digi_school/widgets/string_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../configs/api_response.config.dart';
import '../../../constants/fonts.dart';
import '../../instructor_screen/instructor_screen.dart';

class CourseDetailDrawer extends StatefulWidget {
  CourseDetailDrawer({Key? key, required this.globalKey}) : super(key: key);
  GlobalKey<ScaffoldState>? globalKey;
  @override
  State<CourseDetailDrawer> createState() => _CourseDetailDrawerState();
}

class _CourseDetailDrawerState extends State<CourseDetailDrawer> {
  Widget _getRadialGauge(num progress) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          axisLineStyle: AxisLineStyle(
            thickness: 0.2,
            cornerStyle: CornerStyle.bothCurve,
            color: Color.fromARGB(30, 0, 169, 181),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                positionFactor: 0.1,
                angle: 90,
                widget: Text(
                  "${progress.toStringAsFixed(2)} %",
                  style: TextStyle(fontSize: h3),
                ))
          ],
          pointers: <GaugePointer>[
            RangePointer(
                cornerStyle: CornerStyle.bothCurve,
                width: 0.2,
                sizeUnit: GaugeSizeUnit.factor,
                value: progress.toDouble(),
                gradient: const SweepGradient(colors: <Color>[
                  Color(0xFFa4edeb),
                  Color(0xFF00a9b5),
                ], stops: <double>[
                  0.25,
                  0.75
                ]))
          ],
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CourseDetailViewModel, AuthViewModel>(
        builder: (context, course, auth, child) {
      return SafeArea(
          child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                try {
                  course.getCourse(course.course!.details!.courseSlug!,
                      email: auth.user.email.toString());
                } catch (e) {}
              },
              child: isLoading(course.courseDetailApiResponse)
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: const CourseDetailShimmer())
                  : course.course == null
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text(
                                "Course Detail",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (course.course!.progress != null)
                              Column(
                                children: [
                                  _getRadialGauge(course.course!.progress!),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                course.course!.details!.courseTitle.toString(),
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ReadMoreText(
                                course.course!.details!.courseDesc.toString(),
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                trimLines: 3,
                                // colorClickableText: Colors.blueAccent,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: ' Read more',
                                trimExpandedText: ' Less',
                                textAlign: TextAlign.justify,
                                moreStyle: const TextStyle(
                                    fontSize: 12,
                                    color: khyperlink,
                                    fontWeight: FontWeight.bold),
                                lessStyle: const TextStyle(
                                    fontSize: 12,
                                    color: khyperlink,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text(course.course!.details!.rating == null
                                      ? "0"
                                      : course.course!.details!.rating!
                                          .toStringAsFixed(2)),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  SmoothStarRating(
                                    allowHalfRating: false,
                                    rating: course.course!.details!.rating!
                                        .toDouble(),
                                    isReadOnly: true,
                                    size: 20,
                                    starCount: 5,
                                    color: Colors.yellow.shade700,
                                    borderColor: Colors.yellow.shade700,
                                    spacing: 0.0,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "${course.course!.details!.learners!.length.toString()} students enrolled",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.payment,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(course.course!.details!.learnType
                                      .toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(course.course!.details!.duration
                                      .toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      "${course.course!.details!.weeklyStudy.toString()} hours")
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(10.0),
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: [
                            //       Text(
                            //         "NRP ${discount > 0 ? (price - discount).toString() : price.toString()}",
                            //         style: TextStyle(
                            //             fontSize: p1, fontWeight: FontWeight.w600, color: gray_900),
                            //       ),
                            //       SizedBox(
                            //         width: 2,
                            //       ),
                            //       if (discount > 0)
                            //         Text(
                            //           price.toString(),
                            //           style: TextStyle(
                            //               fontSize: p2,
                            //               color: gray_900,
                            //               decoration: TextDecoration.lineThrough),
                            //         )
                            //     ],
                            //   ),
                            // ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Instructors",
                                    style: TextStyle(
                                        fontSize: h5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        ...course.course!.details!.lecturers!
                                            .map((e) => InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  onTap: () {
                                                    // Navigator.of(context).pushNamed(InstructorScreen.routeName);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 5),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child:
                                                                CacheImageUtil(
                                                              image: e.user!
                                                                  .userImage
                                                                  .toString(),
                                                              height: 80,
                                                              width: 80,
                                                              fit: BoxFit.cover,
                                                              default_image:
                                                                  "assets/images/default_user.png",
                                                            )
                                                            // Image.asset(
                                                            //   "assets/demo/user/user1.jpg",
                                                            //   height: 80,
                                                            //   width: 80,
                                                            //   fit: BoxFit.cover,
                                                            // )
                                                            ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                capitalize(e
                                                                        .user!
                                                                        .firstname
                                                                        .toString()) +
                                                                    " " +
                                                                    capitalize(e
                                                                        .user!
                                                                        .lastname
                                                                        .toString()) +
                                                                    "\n",
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    color:
                                                                        kBlack,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        p1),
                                                              ),
                                                              Text(
                                                                e.user!.email
                                                                        .toString() +
                                                                    "\n",
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    color:
                                                                        kBlack,
                                                                    fontSize:
                                                                        p2),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
            ),
          ],
        ),
      ));
    });
  }
}
