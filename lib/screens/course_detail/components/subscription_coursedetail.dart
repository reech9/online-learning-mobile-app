import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/course_detail/course_detail_viewmodel.dart';
import 'package:digi_school/widgets/snakbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_viewmodel.dart';
import '../../../configs/api_response.config.dart';

class Subscriptioncoursedetail extends StatefulWidget {
  const Subscriptioncoursedetail({Key? key}) : super(key: key);

  @override
  _SubscriptioncoursedetailState createState() => _SubscriptioncoursedetailState();
}

class _SubscriptioncoursedetailState extends State<Subscriptioncoursedetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<CommonViewModel, CourseDetailViewModel, AuthViewModel>(
        builder: (context, common, data, auth, child) {
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor//background color of button
                    ),
                    onPressed: () {
                      try{
                        if(!auth.loggedIn)
                          {
                            snackThis(context: context, color: Colors.red, content: Text("Please sign in first."));
                          }
                        else if(!data.hasAccess){
                          common.setLoading(true);
                          data.enrollCourse(auth.user, data.course!.details!.courseSlug.toString()).then((value){
                              commonSnackHacks(context: context, response: data.courseEnrollApiResponse);
                              common.setLoading(false);
                          }).catchError((error){
                            common.setLoading(false);
                          });
                        }
                      }catch(e){

                      }

                    },
                    child: data.hasAccess ?  Text("Enrolled") :Text("Enroll now")),
              ),
            ),
            SizedBox(height: 10,),
          ],
        );
      }
    );
  }
}
