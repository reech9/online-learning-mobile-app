import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/demo.dart';
import 'package:digi_school/screens/instructor_screen/instructor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/fonts.dart';

class InstructorList extends StatelessWidget {
  InstructorList({Key? key}) : super(key: key);
  List<Map<String, dynamic>> demoInstructor = dummyInstructor.toList();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        demoInstructor.shuffle();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("Top Instructor", style: TextStyle(
                fontSize: h3, fontWeight: FontWeight.w600,
                color: kBlack,
              ),),
            ),
            SizedBox(height: 10,),
            Container(
              height: 300,
              child: GridView(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                children: [
                  ...List.generate(
                      demoInstructor.length,
                      (index) => InstructorCard(
                        title: demoInstructor[index]["title"],
                        image: demoInstructor[index]["image"],
                        courses: demoInstructor[index]["courses"],
                        students: demoInstructor[index]["students"],
                        subTitle: demoInstructor[index]["subTitle"],
                      ))
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}


class InstructorCard extends StatelessWidget {
  InstructorCard({Key? key, this.image="", this.title="", this.subTitle="", this.courses=0, this.students=0}) : super(key: key);
  String image = "";
  String id = "";
  String title = "";
  String subTitle = "";
  num students = 0;
  num courses = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, InstructorScreen.routeName, arguments: "id");
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  image,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title + "\n", maxLines: 2 ,
                    style: TextStyle(
                        color: kBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: p1
                    ),),
                  Text(subTitle + "\n", maxLines: 2, style: TextStyle(
                      color: kBlack, fontSize: p2
                  ),),
                  Text(students.toString() +" student",  style: TextStyle(
                      color: kBlack, fontSize: p2
                  ),),
                  Text(courses.toString() + " courses",  style: TextStyle(
                      color: kBlack, fontSize: p2
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
