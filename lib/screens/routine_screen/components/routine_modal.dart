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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../course_detail/course_detail_viewmodel.dart';
import '../routine_screen.dart';

class RoutineModal extends StatelessWidget {
  RoutineModal({Key? key,required this.appointmentDetails})
      : super(key: key);
  Meeting appointmentDetails;
  double headerHeight = 40;


  @override
  Widget build(BuildContext context) {
    var _startTimeText = DateFormat('hh:mm a').format(appointmentDetails.from).toString();
    var _endTimeText = DateFormat('hh:mm a').format(appointmentDetails.to).toString();
    return Consumer2<LessonViewModel, CourseDetailViewModel>(builder: (context, data, course, child) {
      return SafeArea(
        child:
        isLoading(course.routineApiResponse) ?
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
                          course.routine[appointmentDetails.index].title.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),

                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '$_startTimeText - $_endTimeText',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                course.routine[appointmentDetails.index].content.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap:(){
                                Navigator.of(context).pop();
                                launchUrl(Uri.parse(course.routine[appointmentDetails.index].classLink.toString()) );
                              },
                              child: Text(course.routine[appointmentDetails.index].classLink.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 15, color: khyperlink)),
                            ),

                          ],
                        ),
                      ),

                      SizedBox(height: 20,),
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
