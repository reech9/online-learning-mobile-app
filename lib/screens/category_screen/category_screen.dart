import 'dart:convert';

import 'package:digi_school/api/models/category.dart';
import 'package:digi_school/constants/demo.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/screens/category_screen/category_viewmodel.dart';
import 'package:digi_school/screens/category_screen/components/category_card_list.dart';
import 'package:digi_school/screens/category_screen/components/category_filter.dart';
import 'package:digi_school/screens/category_screen/components/instructor_list.dart';
import 'package:digi_school/screens/home_screen/components/Course_test.dart';
import 'package:digi_school/screens/home_screen/components/category_list.dart';
import 'package:digi_school/screens/home_screen/home_view_model.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:digi_school/widgets/list_card_product.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../search_screen/components/top_categoeies.dart';
import 'components/subcategory_widget.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen(
      {Key? key, this.id = "", this.subcategory, this.slug, this.name})
      : super(key: key);
  dynamic id;
  String? name;
  String? slug;
  List<Category>? subcategory;

  static const String routeName = "/category";

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CategoryBody(
      id: widget.id,
      subcategory: widget.subcategory,
      name: widget.name,
    );
  }
}

class CategoryBody extends StatefulWidget {
  CategoryBody({Key? key, this.id = "", this.subcategory, this.name})
      : super(key: key);
  String id = "";
  List<Category>? subcategory;
  String? name;

  @override
  _CategoryBodyState createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  List<Map<String, dynamic>> demo = [];
  List<String> demoCategories = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    demo = dummyProduct.toList();
    demoCategories = dummyCategories.toList();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(builder: (context, category, child) {
      return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kPrimaryColor, Colors.black])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            key: _scaffoldKey,
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
                            pinned: true,
                            automaticallyImplyLeading: true,
                            leading: IconButton(
                                icon: Icon(Icons.chevron_left),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text(
                                      widget.name.toString(),
                                      style: const TextStyle(
                                          color: kWhite,
                                          fontWeight: FontWeight.w700,
                                          fontSize: h2),
                                    )),

                                CourseTest(
                                  id: widget.id,
                                  title: 'Course to get you started',
                                ),
                                widget.subcategory!.isEmpty ||
                                        widget.subcategory == null
                                    ? SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, left: 8.0, top: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: Text(
                                                'Related Topics',
                                                style: TextStyle(
                                                    fontSize: h3,
                                                    color: kWhite,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            SubCategoriesWidget(
                                                subcategories:
                                                    widget.subcategory),
                                          ],
                                        ),
                                      ),

                                // Builder(builder: (context) {
                                //   demo.shuffle();
                                //   return CategoryCardList(
                                //       data: data.courses, title: "Featured courses");
                                // }),

                                const SizedBox(
                                  height: 20,
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                // InstructorList(),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            "All Course",
                                            style: TextStyle(
                                                fontSize: h3,
                                                color: kWhite,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CourseTest(
                                      display: "list",
                                    )
                                    // ...List.generate(
                                    //     demo.length,
                                    //     (index) => ListCardProduct(
                                    //           title: demo[index]["title"],
                                    //           user: demo[index]["user"],
                                    //           image: demo[index]["image"],
                                    //           discount: demo[index]["discount"],
                                    //           price: demo[index]["price"],
                                    //           rating: demo[index]["rating"],
                                    //         ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ]))))),
      );
    });
  }
}
