
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/course_detail/course_detail.dart';
import 'package:digi_school/widgets/list_card_product.dart';
import 'package:flutter/material.dart';

import '../../../api/models/course.dart';
import '../../../constants/colors.dart';

class MyCourseWidget extends StatefulWidget {
  MyCourseWidget({Key? key, required this.courses}) : super(key: key);
  List<Course> courses;
  @override
  _MyCourseWidgetState createState() => _MyCourseWidgetState();
}

class _MyCourseWidgetState extends State<MyCourseWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Column(
          children: [
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text("My Courses",
                      style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: h5)),
                  Text(" " + widget.courses.length.toString(),
                      style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: h5)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ...List.generate(
                widget.courses.length > 3 ? 3 : widget.courses.length,
                    (index) => ListCardProduct(
                  title: widget.courses[index].courseTitle!,
                  user: widget.courses[index].learnType!,
                  image: widget.courses[index].image.toString(),
                  discount: widget.courses[index].discount == null ? 0 : widget.courses[index].discount!,
                  price: widget.courses[index].price == null ? 0 : widget.courses[index].price!,
                  rating: widget.courses[index].rating == null ? 0 : widget.courses[index].rating!,
                  border: false,
                  onPress: (){
                    Navigator.pushNamed(context,
                        CourseDetail.routeName,
                        arguments: widget.courses[index]
                            .courseSlug
                            .toString());
                  },
                )),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                print("SEE ALL");
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: kBlack,
                        width: 2
                    )
                ),
                child: Text('See all',textAlign: TextAlign.center , style: TextStyle(
                    color: kBlack,
                    fontSize: h5,fontWeight: FontWeight.w500
                ),),
              ),
            ),
          ],
        ),
      );
  }
}
