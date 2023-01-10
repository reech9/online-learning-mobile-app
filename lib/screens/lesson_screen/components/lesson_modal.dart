import 'package:digi_school/api/response/course_detail_response.dart';
import 'package:digi_school/api/response/lesson_response.dart' as LessonResponse;
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/lesson_screen/components/lesson_filter_shimmer.dart';
import 'package:digi_school/screens/lesson_screen/lesson_screen.dart';
import 'package:digi_school/screens/lesson_screen/lesson_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../course_detail/course_detail_viewmodel.dart';

class LessonModal extends StatelessWidget {
  GlobalKey<ScaffoldState> globalKey;
  LessonModal({Key? key, required this.globalKey})
      : super(key: key);
  double headerHeight = 40;
  @override
  Widget build(BuildContext context) {

    return Consumer2<LessonViewModel, CourseDetailViewModel>(builder: (context, data, course, child) {
        return SafeArea(
          child:
          isLoading(data.lessonDetailApiResponse) ?
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
                            "Curriculum",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                        if(course.course!.weeks!=null)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: course.course!.weeks!.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                Theme(
                                  data:
                                  ThemeData().copyWith(dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    initiallyExpanded: i == course.activeWeekIndex,
                                    // trailing:  const Icon(Icons.add,color: kBlack,),
                                      title: Text(
                                        course.course!.weeks![i].title.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 12),
                                      ),
                                      children:
                                      List.generate(course.course!.weeks![i].lessons!.length, (j) {
                                        return Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Column(
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  data.getLesson(course.course!.weeks![i].lessons![j].lessonSlug.toString()).then((value){
                                                    course.findWeek(data.lesson!.lessonSlug);
                                                  });

                                                  try {
                                                    Navigator.of(globalKey.currentState!.context).pop();
                                                  } catch (e) {}
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: data.lesson != null &&  data.lesson!.lessonSlug == course.course!.weeks![i].lessons![j].lessonSlug ?  Colors.black.withOpacity(0.15) : Colors.transparent,
                                                  ),
                                                  child: ListTile(
                                                    title: Text(
                                                      course.course!.weeks![i].lessons![j].lessonTitle.toString(),
                                                      style: const TextStyle(fontSize: 14),
                                                    ),
                                                    trailing:  course.course!.weeks![i].lessons![j].status == false ? SizedBox(height: 0, width: 0,) : Icon(
                                                            Icons
                                                                .check_circle,
                                                            color: Colors
                                                                .green,
                                                          )
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      })),
                                ),
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
