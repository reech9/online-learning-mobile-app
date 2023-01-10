import 'package:digi_school/api/response/course_detail_response.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/lesson_screen/lesson_screen.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class Coursecontentcoursedetail extends StatelessWidget {
  final lessons;
  List<Week> weeks;
  bool hasAccess = false;
  Coursecontentcoursedetail({Key? key, this.lessons, required this.weeks, required this.hasAccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(hasAccess.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Curriculum",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weeks.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  Theme(
                    data:
                    ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(

                      // trailing:  const Icon(Icons.add,color: kBlack,),
                        title: Text(
                          weeks[i].title.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                        children:
                        List.generate(weeks[i].lessons!.length, (j) {
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    if(hasAccess){
                                      Navigator.of(context)
                                          .pushNamed(LessonScreen.routeName, arguments: weeks[i].lessons![j].lessonSlug.toString());
                                    }else{
                                        snackThis(context: context, color: Colors.red, content: Text("You don\'t have access to this course. Please enroll to view lesson."));
                                    }

                                  },
                                  child: ListTile(
                                    // trailing: completion
                                    //     .contains(datas
                                    //     .lessons![
                                    // i]
                                    //     .id)
                                    //     ? const Icon(
                                    //   Icons
                                    //       .check_circle,
                                    //   color: Colors
                                    //       .green,
                                    // )
                                    //     : null,
                                    title: Text(
                                      weeks[i].lessons![j].lessonTitle.toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    // trailing: completion
                                    //         .contains(datas
                                    //             .lessons[i]
                                    //             .id)
                                    //     ? Icon(
                                    //         Icons
                                    //             .check_circle,
                                    //         color: Colors
                                    //             .green,
                                    //       )
                                    //     : null,\
                                    // onTap: () {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder:
                                    //             (context) =>
                                    //             Lessoncontent(
                                    //               data: datas,
                                    //               moduleSlug: widget.moduleslug,
                                    //               index: i,
                                    //             )),
                                    //   );
                                    // },
                                    // onTap: () async {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder:
                                    //           (context) =>

                                    // );
                                    //   final SharedPreferences
                                    //       sharedPreferences =
                                    //       await SharedPreferences
                                    //           .getInstance();
                                    //   sharedPreferences
                                    //       .setString(
                                    //           'lessonId',
                                    //           datas
                                    //               .lessons[
                                    //                   i]
                                    //               .id);
                                    // },
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
    );
  }
}
