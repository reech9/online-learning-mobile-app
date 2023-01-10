import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/category_screen/category_screen.dart';
import 'package:digi_school/screens/search_screen/search_viewmodel.dart';
import 'package:digi_school/widgets/circular_container_outlined.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../constants/fonts.dart';

class TopCategoriesWidget extends StatefulWidget {
  final screen;
  const TopCategoriesWidget({Key? key, this.screen}) : super(key: key);

  @override
  _TopCategoriesWidgetState createState() => _TopCategoriesWidgetState();
}

class _TopCategoriesWidgetState extends State<TopCategoriesWidget>
    with AutomaticKeepAliveClientMixin {
  List<Color> _colors = [];
  late SearchViewModel _searchViewModel;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
      _searchViewModel.fetchAllcatgory().then((value) {
        _colors = List.generate(_searchViewModel.categories.length,
            (index) => Color(Random().nextInt(0xfffff400)).withAlpha(0xffff));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(builder: (context, data, child) {
      return isLoading(data.categoryApiResponse)
          ? const Center(
              child: CircularProgressIndicator(
              color: khyperlink,
            ))
          : data.categories == null || data.categories.isEmpty
              ? Container(
                  height: 20,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('No category found'),
                  ),
                )
              : widget.screen == "search"
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        child: Column(
                          children: [
                            GridView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 3 / 1.5,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemCount: data.categories.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, CategoryScreen.routeName,
                                            arguments: CategoryScreen(
                                                id: data.categories[index].id,
                                                name: data.categories[index]
                                                    .categoryName,
                                                subcategory: data
                                                    .categories[index]
                                                    .subCategories));
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Color(
                                              Random().nextInt(0xffffffff)),
                                        ),
                                        child: Stack(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      data.categories[index]
                                                          .categoryName
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 14.0),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // Positioned(
                                            //     right: -10.0,
                                            //     bottom: -30.0,
                                            //     height: 100,
                                            //     width: 100,
                                            //     child: Transform.rotate(
                                            //       angle: 0.4,
                                            //       child: ClipRect(
                                            //         child: Image.network(
                                            //             'http://45.115.217.46:8080/' +
                                            //                 data
                                            //                     .categories[
                                            //                         index]
                                            //                     .image!
                                            //                     .first,
                                            //             fit: BoxFit.fill),
                                            //       ),
                                            //     ))
                                            Positioned(
                                              width: 80,
                                              height: 60,
                                              bottom: -15.0,
                                              right: -35.0,
                                              child: Transform.rotate(
                                                angle: 0.3,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Image.network(
                                                      'https://api.digischoolglobal.com/' +
                                                          data.categories[index]
                                                              .image!.first,
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                }),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                        // GridView.count(
                        //   crossAxisSpacing: 10.0,
                        //   mainAxisSpacing: 10.0,
                        //   // Create a grid with 2 columns. If you change the scrollDirection to
                        //   // horizontal, this produces 2 rows.
                        //   crossAxisCount: 2,
                        //   shrinkWrap: true,
                        //   physics: const ScrollPhysics(),
                        //   // Generate 100 widgets that display their index in the List.
                        //   children: List.generate(data.categories.length, (index) {
                        //     return InkWell(
                        //       onTap: () {
                        //         Navigator.pushNamed(
                        //             context, CategoryScreen.routeName,
                        //             arguments: CategoryScreen(
                        //                 id: data.categories[index].id,
                        //                 name: data.categories[index]
                        //                     .categoryName,
                        //                 subcategory: data
                        //                     .categories[index]
                        //                     .subCategories));
                        //       },
                        //       child: Container(
                        //         padding: const EdgeInsets.symmetric(
                        //             vertical: 10),
                        //         child: Text(
                        //           data.categories[index]
                        //               .categoryName
                        //               .toString(),
                        //           style:
                        //           TextStyle(fontSize: p1,color: kWhite),
                        //         ),
                        //       ),
                        //     );
                        //   }),
                        // ),
                      ),
                    )
                  : widget.screen == "chip"
                      ? Container(
                          child: Wrap(
                            children: [
                              ...List.generate(
                                  data.categories.length,
                                  (index) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (data.recommendation.contains(
                                                data.categories[index].id
                                                    .toString())) {
                                              setState(() {
                                                data.recommendation.remove(data
                                                    .categories[index].id
                                                    .toString());
                                              });
                                            } else {
                                              setState(() {
                                                data.recommendation.add(data
                                                    .categories[index].id
                                                    .toString());
                                              });
                                            }
                                          });
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Chip(
                                                  backgroundColor: data
                                                          .recommendation
                                                          .contains(data
                                                              .categories[index]
                                                              .id
                                                              .toString())
                                                      ? kPrimaryColor
                                                      : Colors.grey.shade300,
                                                  label: Text(
                                                    data.categories[index]
                                                        .categoryName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: p1,
                                                        color: data
                                                                .recommendation
                                                                .contains(data
                                                                    .categories[
                                                                        index]
                                                                    .id)
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                ))),
                                      ))
                            ],
                          ),
                        )
                      : widget.screen == "landing"
                          ? Container(
                              child: Column(
                                children: [
                                  GridView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 200,
                                              childAspectRatio: 3 / 1.7,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20),
                                      itemCount: data.categories.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: _colors.length > 0
                                                ? _colors[index]
                                                : Colors.transparent,
                                          ),
                                          child: Stack(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        data.categories[index]
                                                            .categoryName
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0.0,
                                                left: 0.0,
                                                child: Checkbox(
                                                    value: data.recommendation
                                                        .contains(data
                                                            .categories[index]
                                                            .id
                                                            .toString()),
                                                    onChanged: (value) {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (timeStamp) {
                                                        if (data.recommendation
                                                            .contains(data
                                                                .categories[
                                                                    index]
                                                                .id
                                                                .toString())) {
                                                          setState(() {
                                                            data.recommendation
                                                                .remove(data
                                                                    .categories[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                          });
                                                        } else {
                                                          setState(() {
                                                            data.recommendation
                                                                .add(data
                                                                    .categories[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                          });
                                                        }
                                                      });
                                                    }),
                                              ),
                                              // Positioned(
                                              //     right: -10.0,
                                              //     bottom: -30.0,
                                              //     height: 100,
                                              //     width: 100,
                                              //     child: Transform.rotate(
                                              //       angle: 0.4,
                                              //       child: ClipRect(
                                              //         child: Image.network(
                                              //             'http://45.115.217.46:8080/' +
                                              //                 data
                                              //                     .categories[
                                              //                         index]
                                              //                     .image!
                                              //                     .first,
                                              //             fit: BoxFit.fill),
                                              //       ),
                                              //     ))
                                              Positioned(
                                                width: 80,
                                                height: 60,
                                                bottom: -5.0,
                                                right: -35.0,
                                                child: Transform.rotate(
                                                  angle: 0.3,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Image.network(
                                                        'https://api.digischoolglobal.com/' +
                                                            data
                                                                .categories[
                                                                    index]
                                                                .image!
                                                                .first,
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: 100,
                                  )
                                ],
                              ),
                              // GridView.count(
                              //   crossAxisSpacing: 10.0,
                              //   mainAxisSpacing: 10.0,
                              //   // Create a grid with 2 columns. If you change the scrollDirection to
                              //   // horizontal, this produces 2 rows.
                              //   crossAxisCount: 2,
                              //   shrinkWrap: true,
                              //   physics: const ScrollPhysics(),
                              //   // Generate 100 widgets that display their index in the List.
                              //   children: List.generate(data.categories.length, (index) {
                              //     return InkWell(
                              //       onTap: () {
                              //         Navigator.pushNamed(
                              //             context, CategoryScreen.routeName,
                              //             arguments: CategoryScreen(
                              //                 id: data.categories[index].id,
                              //                 name: data.categories[index]
                              //                     .categoryName,
                              //                 subcategory: data
                              //                     .categories[index]
                              //                     .subCategories));
                              //       },
                              //       child: Container(
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 10),
                              //         child: Text(
                              //           data.categories[index]
                              //               .categoryName
                              //               .toString(),
                              //           style:
                              //           TextStyle(fontSize: p1,color: kWhite),
                              //         ),
                              //       ),
                              //     );
                              //   }),
                              // ),
                            )
                          : Container(
                              height: 120,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: MasonryGridView.count(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  crossAxisCount: 2,
                                  itemCount: data.categories.length,
                                  itemBuilder: (context, index) {
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: CircularContainerOutlined(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  CategoryScreen.routeName,
                                                  arguments: CategoryScreen(
                                                      name: data
                                                          .categories[index]
                                                          .categoryName,
                                                      id: data
                                                          .categories[index].id,
                                                      subcategory: data
                                                          .categories[index]
                                                          .subCategories));
                                            },
                                            title: data
                                                .categories[index].categoryName
                                                .toString(),
                                          )),
                                    );
                                  },
                                ),
                              ));
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
