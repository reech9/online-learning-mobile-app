import 'package:digi_school/api/models/category.dart';
import 'package:digi_school/configs/api_response.config.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/category_screen/category_screen.dart';
import 'package:digi_school/screens/search_screen/search_viewmodel.dart';
import 'package:digi_school/widgets/circular_container_outlined.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../constants/fonts.dart';

class SubCategoriesWidget extends StatefulWidget {
  List<Category>? subcategories;
  SubCategoriesWidget({Key? key, this.subcategories}) : super(key: key);

  @override
  _SubCategoriesWidgetState createState() => _SubCategoriesWidgetState();
}

class _SubCategoriesWidgetState extends State<SubCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
            height: 120,
            child: MasonryGridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              crossAxisCount: 2,
              itemCount: widget.subcategories!.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: CircularContainerOutlined(
                        onTap: () {
                          Navigator.pushNamed(
                              context, CategoryScreen.routeName,
                              arguments: CategoryScreen(
                                subcategory: [],
                                  id: widget.subcategories![index].id,
                                  name: widget.subcategories![index]
                                      .categoryName,));
                        },
                        title: widget.subcategories![index].categoryName
                            .toString(),
                      )),
                );
              },
            ),
          );
  }
}
