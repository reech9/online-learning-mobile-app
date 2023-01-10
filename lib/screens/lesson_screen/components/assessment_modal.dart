import 'package:digi_school/api/response/course_detail_response.dart';
import 'package:digi_school/api/response/lesson_response.dart' as LessonResponse;
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/assessment_screen/assessment_screen.dart';
import 'package:digi_school/screens/lesson_screen/components/lesson_filter_shimmer.dart';
import 'package:digi_school/screens/lesson_screen/lesson_screen.dart';
import 'package:digi_school/screens/lesson_screen/lesson_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../course_detail/course_detail_viewmodel.dart';

class AssessmentModal extends StatelessWidget {
  GlobalKey<ScaffoldState> globalKey;
  AssessmentModal({Key? key, required this.globalKey})
      : super(key: key);
  double headerHeight = 40;
  @override
  Widget build(BuildContext context) {
    return Consumer2<LessonViewModel, CourseDetailViewModel>(builder: (context, data, course, child) {
      return SafeArea(
        child:
        isLoading(course.courseAssessmentApiResponse) ?
        LessonFilterShimmer()
            :
        course.course == null ? Text("Error Please try again") :
        Stack(
          children: [
            Container(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: headerHeight + 20,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Assessments",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                      if(course.course!.weeks!=null)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: course.assessmentData.length,
                          itemBuilder: (context, i) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: InkWell(
                                    onTap:(){
                                      print("TAP");
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(AssessmentScreen.routeName, arguments: course.assessmentData[i].lesson!.lessonSlug);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                        child: Text("${i+1}. ${course.assessmentData[i].lesson!.lessonTitle}", style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: h5
                                        ),)),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              height: headerHeight,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      );
    }
    );
  }
}
