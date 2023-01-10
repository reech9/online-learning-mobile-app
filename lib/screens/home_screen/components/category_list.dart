import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/screens/search_screen/components/top_categoeies.dart';
import 'package:digi_school/widgets/circular_container_outlined.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../constants/fonts.dart';

class CategoryList extends StatefulWidget {
  final title;
  CategoryList({Key? key, this.title}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.title,
                style: const TextStyle(color: kWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: h4))),
        const SizedBox(
          height: 5,
        ),
        const TopCategoriesWidget(
          screen: "home",
        ),
      ],
    );
  }
}
