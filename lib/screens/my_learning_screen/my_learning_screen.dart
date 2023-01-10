import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/configs/preference.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/demo.dart';
import 'package:digi_school/screens/course_detail/course_detail.dart';
import 'package:digi_school/screens/lesson_screen/components/lesson_shimmer.dart';
import 'package:digi_school/screens/my_learning_screen/components/learning_card.dart';
import 'package:digi_school/screens/my_learning_screen/components/my_learning_shimmer.dart';
import 'package:digi_school/widgets/explore_button.dart';
import 'package:digi_school/widgets/string_util.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/fonts.dart';

class MyLearningScreen extends StatefulWidget {
  const MyLearningScreen({Key? key}) : super(key: key);

  @override
  _MyLearningScreenState createState() => _MyLearningScreenState();
}

class _MyLearningScreenState extends State<MyLearningScreen> {
  List<Map<String, dynamic>> demo = dummyProduct;

  Future<void> getMyLearning(CommonViewModel commonViewModel) async{
    await commonViewModel.getMyLearnings();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CommonViewModel>(
        builder: (context, common, child) {
        return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [kPrimaryColor, Colors.black])),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                  child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: RefreshIndicator(
                        edgeOffset: 50,
                        onRefresh: ()=>getMyLearning(common),
                        child: CustomScrollView(slivers: <Widget>[
                          SliverAppBar(
                            toolbarHeight: 50,
                            titleSpacing: 10,
                            backgroundColor: Colors.transparent,
                            pinned: true,
                            automaticallyImplyLeading: false,
                            title: Container(
                              margin: const EdgeInsets.only(right: 10),
                              alignment: Alignment.centerRight,
                              height: 50,
                              decoration: const BoxDecoration(
                                // color: Colors.red
                              ),
                              padding:
                             const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  scafoldHeader("My Learning")
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child:
                            isLoading(common.myLearningsApiResponse) ? MyLearningShimmer() :
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if(common.learningData.isEmpty)
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.asset("assets/images/empty.png"),
                                            Text("Looks like you are not enrolled in any courses.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                              fontSize: h5,
                                              fontWeight: FontWeight.w500,
                                                color: kWhite

                                            ),),
                                            SizedBox(height: 25,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                ExploreButton(
                                                    title: "Explore",
                                                    icon: Icons.arrow_forward,
                                                    onTap: () {
                                                      common.itemTapped(1);
                                                    }),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                 if(common.learningData.isNotEmpty)
                                ...List.generate(common.learningData.length, (index) => Builder(
                                  builder: (context) {
                                    String makeLecturer = "";
                                    try{
                                      for(int i=0; i<common.learningData[index].lecturers!.length; i ++ ){
                                        if(i==0){
                                          makeLecturer +=  "${capitalize(common.learningData[index].lecturers![i].user!.firstname.toString())} ${capitalize(common.learningData[index].lecturers![i].user!.lastname.toString())}";
                                        }else{
                                          makeLecturer +=  " | ${capitalize(common.learningData[index].lecturers![i].user!.firstname.toString())} ${capitalize(common.learningData[index].lecturers![i].user!.lastname.toString())}";
                                        }
                                      }
                                    }catch(e){}
                                    return LearningCard(
                                      title: common.learningData[index].courseTitle.toString(),
                                      subTitle: makeLecturer,
                                      image: common.learningData[index].image.toString(),
                                      onClick: ()=>Navigator.of(context).pushNamed(CourseDetail.routeName, arguments: common.learningData[index].courseSlug),
                                      progress: common.learningData[index].progress==null ? 0 : common.learningData[index].progress!,

                                    );
                                  }
                                )),
                                 SizedBox(height: 80,)
                              ],
                            ),
                          )
                        ]),
                      ))),
            ));
      }
    );
  }
}
