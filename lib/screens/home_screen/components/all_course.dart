import 'package:digi_school/api/models/course.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/category_screen/components/category_filter.dart';
import 'package:digi_school/screens/course_detail/course_detail.dart';
import 'package:digi_school/widgets/list_card_product.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Allcourse extends StatefulWidget {
  List<Course> data = [];
  final title;
  Allcourse({Key? key, required this.data, this.title}) : super(key: key);

  @override
  _AllcourseState createState() => _AllcourseState();
}

class _AllcourseState extends State<Allcourse> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kPrimaryColor, Colors.black])),
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          endDrawer: const Drawer(child: CategoryFilter()),
          body: Container(
              color: Colors.transparent,
              child: SafeArea(
                  right: false,
                  child: ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: CustomScrollView(slivers: <Widget>[
                        SliverAppBar(
                          actions: [Container()],
                          toolbarHeight: 50,
                          backgroundColor: Colors.transparent,
                          pinned: false,
                          automaticallyImplyLeading: true,
                          leading:IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              size: 30,
                              color: kWhite,
                            ),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                          titleSpacing: 0,
                          title: Container(
                            margin: const EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            height: 50,
                            decoration: const BoxDecoration(
                                // color: Colors.red
                                ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.title,
                                  style: TextStyle(color: kWhite),
                                ),
                                InkWell(
                                    onTap: () {
                                      try {
                                        _scaffoldKey.currentState!
                                            .openEndDrawer();
                                      } catch (e) {}
                                    },
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: const Icon(
                                          Icons.filter_alt_outlined,
                                          color: kWhite,
                                        ))),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: widget.data.length,
                              itemBuilder: (context, index) {
                                return ListCardProduct(
                                  title:
                                      widget.data[index].courseTitle.toString(),
                                  user: "",
                                  image: widget.data[index].image.toString(),
                                  discount: 20,
                                  price: 100,
                                  rating: 3,
                                  onPress: () {
                                    Navigator.pushNamed(
                                        context, CourseDetail.routeName,
                                        arguments: widget.data[index].courseSlug
                                            .toString());
                                  },
                                );
                              },
                            ),
                          ],
                        ))
                      ]))))),
    );
  }
}
